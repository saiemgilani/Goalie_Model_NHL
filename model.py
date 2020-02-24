from absl import logging
import tensorflow as tf
from goalcred.hidden_layers import hidden_layers


def talos_mlp(x_train, y_train, x_val, y_val, params):
    """
    Build multi-layer perceptron model per Talos specs and return

    The network input is a row of shot features. The target output is a 1 or 0 signifying a scored goal or not.
    Therefore the predicts the probability of a goal.
    """
    model = tf.keras.Sequential()
    model.add(tf.keras.layers.Dense(params['first_neuron'],
                                    input_shape=(x_train.shape[1], ),
                                    activation=params['activation'],
                                    kernel_initializer='glorot_uniform',
                                    kernel_regularizer=tf.keras.regularizers.l1_l2(0.01, 0.0001)))

    model.add(tf.keras.layers.Dropout(params['dropout']))

    hidden_layers(model, params, 1)

    model.add(tf.keras.layers.Dense(1, kernel_initializer='glorot_uniform', activation=params['last_activation']))
    logging.info(model.summary())

    metric = tf.keras.metrics.BinaryAccuracy(threshold=0.30)
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.0001)
    model.compile(loss=params['losses'], optimizer=optimizer, metrics=[metric])

    train_dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train))
    train_dataset = train_dataset.batch(params['batch_size'])

    val_dataset = tf.data.Dataset.from_tensor_slices((x_val, y_val))
    val_dataset = val_dataset.batch(params['batch_size'])

    callbacks = [
        tf.keras.callbacks.EarlyStopping(monitor='val_loss', min_delta=1e-4, patience=5, verbose=1),
        tf.keras.callbacks.ReduceLROnPlateau(monitor='val_loss',
                                             factor=0.2,
                                             patience=2,
                                             min_lr=0.000001,
                                             verbose=1),
    ]
    out = model.fit(train_dataset,
                    epochs=params['epochs'],
                    verbose=1,
                    validation_data=val_dataset,
                    callbacks=callbacks)

    return out, model
