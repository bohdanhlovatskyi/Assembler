
from distutils.core import setup, Extension

example_module = Extension('_sort_array', sources=['sort_array.c', 'sort_array.i', 'func'])

if __name__ == "__main__": 
    setup(name='sort_array', ext_modules=[example_module], py_modules=["sort_array"])