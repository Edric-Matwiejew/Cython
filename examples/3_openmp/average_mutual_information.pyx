#!python
#cython: language_level=3, boundscheck=True

from  cython.parallel import prange, parallel
from cython import cdivision

from libc.stdlib cimport malloc, free
from libc.math cimport log, ceil, floor
from libc.float cimport DBL_MAX
cimport openmp

cdef double dbl_max = DBL_MAX

cdef array_min(double a[], int n_a):
    cdef double a_min
    cdef int i
    a_min = dbl_max
    for i in range(n_a):
        if a_min > a[i]:
            a_min = a[i]
    return a_min

cdef array_max(double a[], int n_a):
    cdef double a_max
    cdef int i
    a_max = -dbl_max
    for i in range(n_a):
        if a_max < a[i]:
            a_max = a[i]
    return a_max

@cdivision(True)
def I(a_py, b_py, bins_a = 100, bins_b = 100):
    """
    Approximate the average mutal information of two series a and b.
    The algorithm 'discretises' a and b by dividing their intervals
    into bins of bin_width_a and bin_width_b.

    The algorithm can be used for discrete systems by setting the
    number of binds equal to the number of samples.
    """
    cdef int n_a = len(a_py), n_b = len(b_py)
    cdef int n_bins_a = bins_a, n_bins_b = bins_b

    cdef double a_min, a_max, b_min, b_max
    cdef double b_width_a, b_width_b
    cdef double norm_a, norm_b, norm_ab

    cdef double *a = <double *> malloc(n_a * sizeof(double))
    cdef double *b = <double *> malloc(n_b * sizeof(double))

    cdef int *a_bin = <int *> malloc(n_a * sizeof(int))
    cdef int *b_bin = <int *> malloc(n_a * sizeof(int))

    cdef double *P_a = <double *> malloc(n_bins_a * sizeof(double))
    cdef double *P_b = <double *> malloc(n_bins_b * sizeof(double))
    cdef double *P_ab = <double *> malloc(n_bins_a * n_bins_b * sizeof(double))

    cdef double bin_width_a, bin_width_b
    cdef double bin_n
    cdef double average_mutual_information

    cdef int i, j, k, start, end
    cdef int max_bins
    cdef int num_threads, thread_id
    cdef double *P_local

    if ((n_a < 2) or (n_b < 2)):
        raise ValueError('Length of input series must be greater than 1.')

    if n_a != n_b:
        raise ValueError('Input arrays of unequal size.')

    if ((n_bins_a <= 0) or (n_bins_b <= 0)):
        raise ValueError('Number of bins must be greater than 0.')

    for i in range(n_bins_a):
        P_a[i] = 0.0

    for i in range(n_bins_b):
        P_b[i] = 0.0

    for i in range(n_bins_a * n_bins_b):
            P_ab[ i ]  = 0.0

    for i in range(n_a):
        a[i] = <double>a_py[i]
        b[i] = <double>b_py[i]

    a_min = array_min(a, n_a)
    a_max = array_max(a, n_a)

    b_min = array_min(b, n_b)
    b_max = array_max(b, n_b)

    if a_min == a_max:
        bin_width_a = a_max
    else:
        bin_width_a = (a_max - a_min)/(n_bins_a - 1)

    if b_min == a_max:
        bin_width_b = b_max
    else:
        bin_width_b = (b_max - b_min)/(n_bins_b - 1)

    # set the minimum at zero to make bin assignment easier
    for i in prange(n_a, nogil = True):
        a[i] -= a_min
    for i in prange(n_b, nogil = True):
        b[i] -= b_min

    # Map each measurement to a bin.
    for i in prange(n_a, nogil = True):
        bin_n = ceil(a[i] / bin_width_a)
        a_bin[i] = <int>bin_n
    for i in prange(n_b, nogil = True):
        bin_n = ceil(b[i] / bin_width_b)
        b_bin[i] = <int>bin_n

    # count the observable frequencies
    with nogil, parallel():

        if n_bins_a > n_bins_b:
            max_bins = n_bins_a
        else:
            max_bins = n_bins_b

        P_local = <double*>malloc(max_bins*sizeof(double))

        for i in range(n_bins_a):
            P_local[i] = 0.0

        for k in prange(n_a):
            P_local[a_bin[k]] += 1

        with gil:
            for i in range(n_bins_a):
                P_a[i] += P_local[i]

        for i in range(n_bins_b):
            P_local[i] = 0.0

        for k in prange(n_b):
            P_local[b_bin[k]] += 1

        with gil:
            for i in range(n_bins_b):
                P_b[i] += P_local[i]

            free(P_local)

    # normalise the frequencies to probabilities
    norm_a = 1.0/n_a
    norm_b = 1.0/n_b
    for i in range(n_bins_a):
        P_a[i] *= norm_a
    for i in range(n_bins_b):
        P_b[i] *= norm_b

    # joint occurance frequecy
    with nogil, parallel():

        num_threads = openmp.omp_get_num_threads()
        thread_id = openmp.omp_get_thread_num()

        P_local = <double*>malloc(n_bins_a*n_bins_b*sizeof(double))

        for j in range(n_bins_a*n_bins_b):
            P_local[j] = 0.0

        start = thread_id*n_a/num_threads
        end = (thread_id + 1)*n_a/num_threads
        if ((thread_id + 1) == num_threads):
            end = n_a

        for i in range(start, end):
            P_local[ n_bins_a * a_bin[i] + b_bin[i] ] += 1.0

        with gil:
            for i in range(n_bins_a*n_bins_b):
                P_ab[i] += P_local[i]
            free(P_local)

    #normalise joint frequenccy to probabilities
    norm_ab = 1.0/n_a
    for i in prange(n_bins_a, nogil = True):
        for k in range(n_bins_b):
            P_ab[ n_bins_a * i + k ] *= norm_ab

    # the average mutual information of a_binned and b_binned
    average_mutual_information = 0
    for i in prange(n_a, nogil = True):
        for k in range(n_b):
            if P_ab[ n_bins_a * a_bin[i] + b_bin[k] ] != 0:
                average_mutual_information += \
                P_ab[ n_bins_a * a_bin[i] + b_bin[k] ]\
                *log(P_ab[ n_bins_a * a_bin[i] + b_bin[k] ]/(P_a[a_bin[i]]*P_b[b_bin[k]]))

    free( P_a )
    free( P_b )
    free( P_ab )

    free( a_bin )
    free( b_bin )

    free(a)
    free(b)

    return average_mutual_information
