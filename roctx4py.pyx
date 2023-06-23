# cython: language_level=3
from __future__ import absolute_import
from functools import wraps
from contextlib import contextmanager

cdef extern from "roctracer/roctx.h":
    cdef void roctxMark (const char *)
    cdef void roctxRangePush (const char *)
    cdef void roctxRangePop (const char *)

cdef extern from "string.h" nogil:
    char   *strdup  (const char *s)
    size_t strlen   (const char *s)

## bytes-to-str problem for supporting both python2 and python3
## python2: str(b"") return str
## python3: str(b"") return 'b""'. Correct way: b"".decode()

cpdef str b2s(bytes x):
    return x.decode()

cpdef bytes s2b(str x):
    return strdup(x.encode())

cpdef mark(str name):
    roctxMark(s2b(name))

cpdef start(str name):
    roctxRangePush(s2b(name))

cpdef stop(str name):
    roctxRangePop(s2b(name))

def profile(x_or_func=None, *decorator_args, **decorator_kws):
    def _decorator(func):
        @wraps(func)
        def wrapper(*args, **kws):
            if 'x_or_func' not in locals() or callable(x_or_func) or x_or_func is None:
                x = func.__name__
            else:
                x = x_or_func
            start(x)
            out = func(*args, **kws)
            stop(x)
            return out
        return wrapper

    return _decorator(x_or_func) if callable(x_or_func) else _decorator

@contextmanager
def timer(x):
    start(x)
    yield
    stop(x)

