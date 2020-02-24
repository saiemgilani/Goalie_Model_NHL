from absl import app
from absl import flags
from absl import logging
import pandas as pd
from sklearn.model_selection import train_test_split
import numpy as np
import os
from goalcred import config
from goalcred import util


def preprocess(cfg, input_file='goalcred/data/shots_2007-2018_with_stats_processed.csv', write=False):
    """
    Preprocesses data based on a config file. The config file is a csv with 'column' and 'use' columns. The 'column'
    is the name of the column in the data. Returns the input dataframe and optionally writes it out.

    The 'use' is what to do with the column. Possible values are:

    <blank>: no actions are taken on blank 'use' values therefore these columns are kept
    drop: drop the column
    cat: keep and one-hot encode
    cat_idx: the index of fields with this label are returned in an array
    scale: keep and scale column (not used here)
    stratify: stratify and remove column (not used here)
    stratify_scale: stratify and scale column
    target: target value for training (not used here)
    """
    if isinstance(cfg, str):
        logging.info(f'Reading config file...')
        cfg = config.Config(cfg)

    config_data_path = cfg.get('data.config_path')
    config_data_df = pd.read_csv(config_data_path)

    logging.info('Reading input file...')
    in_df = pd.read_csv(input_file)

    logging.info('Drop unwanted columns...')
    drop_df = config_data_df[config_data_df['use'] == 'drop']
    in_df = in_df.drop(columns=drop_df['column'])

    logging.info('One-hot encode columns...')
    cat_df = config_data_df[config_data_df['use'] == 'cat']
    in_df = pd.get_dummies(in_df, columns=cat_df['column'])

    if write:
        out_name = os.path.basename(config_data_path).split('.')[0]
        logging.info(f'Write output file: {out_name}...')
        in_df.to_csv(os.path.join(os.path.dirname(input_file), f'{out_name}.csv'), index=False)

    return in_df


def fetch_train_and_test(cfg, data_df, split=True):
    """
    Get the data, split into training and validation sets and scale. Convert to numpy arrays for use in training
    """
    config_data_df = pd.read_csv(cfg.get('data.config_path'))

    # Use the goal field as the target and drop from the training data
    target_col = (config_data_df[config_data_df['use'] == 'target']).column.iloc[0]
    y_data = data_df[target_col]
    x_data = data_df.drop(columns=[target_col])

    strat_remove_cols = list((config_data_df[config_data_df['use'] == 'stratify'])['column'])
    strat_keep_cols = list((config_data_df[config_data_df['use'] == 'stratify_scale'])['column'])
    stratify_cols = strat_remove_cols + strat_keep_cols
    logging.info(f'Stratifying on cols: {stratify_cols}')
    if len(stratify_cols) > 0:
        x_data['stratify'] = x_data[stratify_cols].apply(lambda row: '_'.join(row.values.astype(str)), axis=1)
        x_data['stratify'] = y_data.astype(str) + '_' + x_data['stratify']
    else:
        x_data['stratify'] = y_data

    # Split to train and test sets if requested
    if split:
        logging.info(f'Split to train and test sets...')
        x_train, x_test, y_train, y_test = train_test_split(x_data, y_data,
                                                            test_size=cfg.get('data.test_split'),
                                                            stratify=x_data['stratify'])
    else:
        x_train = x_data
        y_train = y_data
        x_test = None
        y_test = None

    # Remove stratify columns
    x_train = x_train.drop(columns=strat_remove_cols + ['stratify'])

    logging.info('Build index list of category columns')
    cat_idx_cols = list(config_data_df[config_data_df['use'] == 'cat_idx']['column'])
    cat_indexes = [x_train.columns.get_loc(c) for c in cat_idx_cols]

    # Scale the data by fitting on the train data and applying that to both train and test if necessary
    logging.info(f'Scale configured columns...')
    scaler = util.get_class(cfg.get('data.scale.class'))
    scale_cols = list((config_data_df[config_data_df['use'] == 'scale'])['column'])
    scaler.fit(x_train[scale_cols])
    x_train[scale_cols] = scaler.transform(x_train[scale_cols])

    # x_train = x_train.to_numpy().astype(np.float32)
    x_train = x_train.to_numpy()
    y_train = y_train.to_numpy().astype(np.float32)[:, np.newaxis]

    if split:
        x_test = x_test.drop(columns=strat_remove_cols + ['stratify'])
        x_test[scale_cols] = scaler.transform(x_test[scale_cols])
        # x_test = x_test.to_numpy().astype(np.float32)
        x_test = x_test.to_numpy()
        y_test = y_test.to_numpy().astype(np.float32)[:, np.newaxis]

    return x_train, y_train, x_test, y_test, cat_indexes


def fetch_sample(x, y, size, seed=None):
    """
    Fetch and return a random sample from the passed in data
    """
    np.random.seed(seed)
    feature_sample = np.random.choice(len(x), size, replace=False)
    x_sample = x[feature_sample]
    y_sample = y[feature_sample]
    np.random.seed(None)

    return x_sample, y_sample


def main(_):
    if FLAGS.task == 'preprocess':
        logging.info('--Preprocessing data--')
        config_file, write = FLAGS.task_args.split(',')
        preprocess(config_file, write=bool(write))
        logging.info('--Finished--')


flags.DEFINE_string(
    'task', 'preprocess',
    'Defines the task to perform')

flags.DEFINE_string(
    'task_args', 'goalcred/config/talos-mlp.yaml,True',
    'Optional arguments for the task')

FLAGS = flags.FLAGS

if __name__ == '__main__':
    logging.set_verbosity(logging.INFO)
    app.run(main)
