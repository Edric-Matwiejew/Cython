from libc.stdlib cimport rand, RAND_MAX
from cython.parallel import prange
from cython import cdivision
cimport openmp

cdef void matrixVectorDot( int N, double[:,:] A, double& v[], double& u[]) nogil:

    cdef:
        int i, j

    for i in prange(N, nogil = True):
        for j in range(N):
            u[i] += A[i][j]*v[j]

cdef:

    int iterations = 60
    int i, j, N = 15000
    double A[15000][15000]
    double b[15000]
    double c[15000]

for i in prange(N, nogil = True):
    b[i] = <double>rand()/<double>RAND_MAX
    for j in range(N):
        A[i][j] = 1

for i in range(iterations):

    matrixVectorDot(N,A,b,c)

    for j in prange(N, nogil = True):
        c[j] = 0
