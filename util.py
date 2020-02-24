import importlib


def get_class(class_path, args=[], kwargs={}):
    module_name, class_name = class_path.rsplit(".", 1)
    klass = getattr(importlib.import_module(module_name), class_name)
    instance = klass(*args, **kwargs)
    return instance

