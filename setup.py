# from conf.mpidistutils import setup
from setuptools import setup, find_packages
from setuptools.extension import Extension
from Cython.Build import cythonize

import os
import sys

include_dirs = list()
library_dirs = list()
libraries = list()
roctx_lib_dir = None
if os.getenv("ROCM_PATH") is not None:
    roctx_dir = os.environ.get("ROCM_PATH")
    roctx_include_dir = os.path.join(roctx_dir, "include")
    roctx_lib_dir = os.path.join(roctx_dir, "lib")
    include_dirs.append(roctx_include_dir)
    library_dirs.append(roctx_lib_dir)
    libraries.append("roctx64")
else:
    raise Exception("ROCM_PATH env is not set.")

extensions = [
    Extension(
        "roctx4py",
        ["roctx4py.pyx"],
        include_dirs=include_dirs,
        library_dirs=library_dirs,
        libraries=libraries,
        extra_link_args=["-fopenmp", "-Wl,-rpath,%s" % roctx_lib_dir],
    ),
]

setup(name="roctx4py", packages=find_packages(), ext_modules=cythonize(extensions))
