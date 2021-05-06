from libc.stdlib cimport rand, RAND_MAX #must not me import!
from cython import cdivision
from cython.parallel import parallel
cimport openmp

@cdivision(True) # use C-style division
cdef double rand_double(double low, double high) nogil:

    cdef double r

    r = <double>rand()/<double>RAND_MAX
    r = (1 - r)*low + r*high

    return r

cdef int thread_id
cdef double r

with nogil, parallel():

    thread_id = openmp.omp_get_thread_num()
    r = rand_double(0, 10)
    with gil:
        print("Thread ID:", thread_id, "Random double:", r)

