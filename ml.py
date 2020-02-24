from sklearn.decomposition import PCA
from sklearn.mixture import GaussianMixture
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import GridSearchCV
from goalcred import util


def train_classifier(x_train, y_train, cls, cls_args):
    """
    Train a classifier
    """
    classifier = util.get_class(cls, kwargs=cls_args)
    result = classifier.fit(x_train, y_train)
    return result


def fetch_clusters(x, pca_args, gauss_args, x_test=None):
    """
    Create categorical clusters for train input (and optionally test input) and return the results
    """
    pca = PCA(**pca_args).fit(x)
    pca_result = pca.transform(x)

    gaussian = GaussianMixture(**gauss_args).fit(pca_result)
    gauss_predict = gaussian.predict(pca_result)

    gauss_predict = gauss_predict.reshape(-1, 1)
    one_hot = OneHotEncoder(sparse=False, categories='auto').fit(gauss_predict)
    one_hot_result = one_hot.transform(gauss_predict)

    one_hot_result_test = None
    if x_test is not None:
        pca_result_test = pca.transform(x_test)
        gauss_predict_test = gaussian.predict(pca_result_test)
        one_hot_result_test = one_hot.transform(gauss_predict_test.reshape(-1, 1))

    return one_hot_result, one_hot_result_test


def grid_search(x_train, y_train, cls, cls_args, params, scoring, cv):
    classifier = util.get_class(cls, kwargs=cls_args)

    grid = GridSearchCV(estimator=classifier, param_grid=params, scoring=scoring, cv=cv, n_jobs=1, verbose=10)
    grid.fit(x_train, y_train)

    return grid

