from absl import app
from absl import flags
from absl import logging
import os
import tensorflow as tf
import numpy as np
import pandas as pd
from sklearn.metrics import log_loss
# import talos

from goalcred import config
from goalcred import data
from goalcred import model
from goalcred import ml

CONFIG_DIR = 'config'
MODEL_DIR = 'goalcred/training-runs'


def move_config(config_file, model_dir):
    """
        Move config file to model directory
    """
    logging.info('Copying config file to model directory...')
    tf.io.gfile.makedirs(os.path.join(model_dir, CONFIG_DIR))
    new_config_file = os.path.join(model_dir, CONFIG_DIR, os.path.basename(config_file))
    tf.io.gfile.copy(config_file, new_config_file, overwrite=True)

    return new_config_file


def main(_):
    logging.info(f'Using Tensorflow version: {tf.__version__}')

    config_base = os.path.splitext(os.path.basename(FLAGS.config_file))[0]
    model_dir = os.path.join(os.getcwd(), MODEL_DIR, config_base)
    logging.info(f'Using model directory: {model_dir}')
    new_config_file = move_config(FLAGS.config_file, model_dir)

    logging.info('Reading config file...')
    cfg = config.Config(new_config_file)

    logging.info('Preprocessing data...')
    data_df = data.preprocess(cfg, input_file=FLAGS.data_file)

    logging.info('Fetching data...')
    x_train, y_train, x_test, y_test, cat_indexes = data.fetch_train_and_test(cfg, data_df)
    logging.info(f'Train shape: {x_train.shape}')
    logging.info(f'Test shape: {x_test.shape}')

    if cfg.get('talos') is not None:

        logging.info('Training via Talos...')
        params = cfg.get('talos.params')
        # h = talos.Scan(x_train, y_train,
        #                x_val=x_test, y_val=y_test,
        #                params=params,
        #                experiment_name=cfg.get('talos.name'),
        #                model=eval(cfg.get('talos.model_fn')),
        #                fraction_limit=cfg.get('talos.fraction_limit'))
    else:
        y_train = y_train.ravel()
        y_test = y_test.ravel()

        cls = cfg.get('model.class')
        cls_parent_args = cfg.get('model.classifier')

        # Sample from train data and perform feature selection on model
        logging.info(f'Sample {cfg.get("model.feature_selection.sample.size"):,} for feature selection...')
        x_train_sample, y_train_sample = data.fetch_sample(x_train, y_train,
                                                           cfg.get('model.feature_selection.sample.size'),
                                                           cfg.get('model.feature_selection.sample.seed'))

        logging.info(f'Train feature selection model...')
        cls_args = {**cls_parent_args, **cfg.get('model.feature_selection.classifier')}
        if cfg.get('model.cat_property') is not None:
            cls_args[cfg.get('model.cat_property')] = cat_indexes
        print(cls_args)
        feature_model = ml.train_classifier(x_train_sample, y_train_sample, cls, cls_args)

        best_features = np.where(np.asarray(feature_model.feature_importances_) >
                                 cfg.get('model.feature_selection.threshold'))[0]
        cat_indexes = [list(best_features).index(ci) for ci in cat_indexes if ci in best_features]
        logging.info(f'Found {len(best_features)} best features...')

        # Select the best features
        x_train_features = x_train[:, best_features]
        x_test_features = x_test[:, best_features]
        # ----------------------------------------------------------------

        # Sample from train data to do hyperparameter tuning
        logging.info(f'Sample {cfg.get("model.hyperparameter_tuning.sample.size"):,} for hyperparameter tuning...')
        x_train_sample, y_train_sample = data.fetch_sample(x_train_features, y_train,
                                                           cfg.get('model.hyperparameter_tuning.sample.size'),
                                                           cfg.get('model.hyperparameter_tuning.sample.seed'))

        logging.info(f'Building categorical clusters and appending to features...')
        x_cluster, _ = ml.fetch_clusters(x_train_sample,
                                         cfg.get('model.clustering.pca'),
                                         cfg.get('model.clustering.gaussian'))
        x_train_sample = np.concatenate((x_train_sample, x_cluster), axis=-1)

        logging.info(f'Training the XGB grid search...')
        cls_args = cls_parent_args
        if cfg.get('model.cat_property') is not None:
            cls_args[cfg.get('model.cat_property')] = cat_indexes
        grid = ml.grid_search(x_train_sample, y_train_sample,
                              cls,
                              cls_args,
                              cfg.get('model.hyperparameter_tuning.grid.params'),
                              cfg.get('model.hyperparameter_tuning.grid.scoring'),
                              cfg.get('model.hyperparameter_tuning.grid.cv'))

        logging.info(f'Grid search best CV score: {grid.best_score_:.6f}')
        logging.info(f'Grid search best hyperparameters: {grid.best_params_}')
        # ----------------------------------------------------------------

        # Train on entire train data
        logging.info(f'Building categorical clusters and appending to features for all training data...')
        x_cluster, x_cluster_test = ml.fetch_clusters(x_train_features,
                                                      cfg.get('model.clustering.pca'),
                                                      cfg.get('model.clustering.gaussian'),
                                                      x_test=x_test_features)

        x_train_features = np.concatenate((x_train_features, x_cluster), axis=-1)
        x_test_features = np.concatenate((x_test_features, x_cluster_test), axis=-1)

        logging.info(f'Training on all the data using best parameters...')
        cls_args = {**cls_parent_args, **grid.best_params_}
        if cfg.get('model.cat_property') is not None:
            cls_args[cfg.get('model.cat_property')] = cat_indexes
        final_model = ml.train_classifier(x_train_features, y_train, cls, cls_args)
        # ----------------------------------------------------------------

        # Evaluate
        logging.info(f'Getting predictions on test set...')
        predictions_test = final_model.predict_proba(x_test_features)
        loss = log_loss(y_test, predictions_test[:, 1])
        logging.info(f'Log loss (all training data): {loss:.6f}')
        # ----------------------------------------------------------------

        # Run predictions on entire data set
        logging.info(f'Predict the entire data set...')
        x_all, y_all, _, _, _ = data.fetch_train_and_test(cfg, data_df, split=False)
        x_all_features = x_all[:, best_features]

        logging.info(f'Add cluster categories to the entire data set...')
        x_cluster, x_cluster_test = ml.fetch_clusters(x_all_features,
                                                      cfg.get('model.clustering.pca'),
                                                      cfg.get('model.clustering.gaussian'))
        x_all_features = np.concatenate((x_all_features, x_cluster), axis=-1)

        logging.info(f'Calculate probabilities...')
        predictions_all = final_model.predict_proba(x_all_features)
        predictions_df = pd.DataFrame({'prob_nogoal': predictions_all[:, 0], 'prob_goal': predictions_all[:, 1]})

        file_name = f'pred_{os.path.splitext(os.path.basename(FLAGS.data_file))[0]}.csv'
        logging.info(f'Write file to {file_name} in model directory...')
        predictions_df.to_csv(os.path.join(model_dir, file_name))


flags.DEFINE_string(
    'data_file', './goalcred/data/shots_2007-2018_with_stats_processed.csv',
    'Full path to the data file used for training')

flags.DEFINE_string(
    'config_file', './goalcred/config/catboost-gpu.yaml',
    'File containing the configuration for this training run')

FLAGS = flags.FLAGS

if __name__ == '__main__':
    tf.compat.v1.enable_v2_behavior()
    logging.set_verbosity(logging.INFO)
    app.run(main)
