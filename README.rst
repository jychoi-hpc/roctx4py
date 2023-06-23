===============
GPTL for Python
===============

Python bindings for ROC-TX library, AMD's Code Annotation Events API.

Overview
--------

This package provides Python bindings for ROC-TX.

Build and install
-----------------

.. code-block:: rst

  python setup.py install --prefix=/dir/to/install


Quick Start
-----------

.. code-block:: python
  
  import roctx4py as rx

  rx.start("count")
  for i in range(1000):
      pass
  rx.stop("count")

  ## Or, use with a decorator
  @rx.profile
  def count():
    for i in range(1000):
        pass



For more details, check `example` directory.