# distutils: language = c++
# distutils: extra_compile_args = -std=c++11
from cython.parallel import prange

cdef extern from "<random>" namespace "std" nogil:
    cdef cppclass mt19937:
        mt19937() # we need to define this constructor to stack allocate classes in Cython
        mt19937(unsigned int seed) # not worrying about matching the exact int type for seed

    cdef cppclass uniform_real_distribution[T]:
        uniform_real_distribution()
        uniform_real_distribution(T a, T b)
        T operator()(mt19937 gen) # ignore the possibility of using other classes for "gen"

cdef double test(double low, double high, int seed) nogil:
    cdef:
        mt19937 gen = mt19937(5)
        uniform_real_distribution[double] dist = uniform_real_distribution[double](low, high)
    return dist(gen)
