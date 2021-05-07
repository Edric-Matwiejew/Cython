from cpython.mem cimport PyMem_Malloc, PyMem_Free
from libc.stdlib cimport rand, RAND_MAX
from cython.parallel import prange
from cython import cdivision
cimport openmp

cdef void matrixVectorDot(int N, double[:,:] A, double v[], double u[]) nogil:
    cdef:
        int i, j

    for i in prange(N):
        for j in range(N):
            u[i] += A[i][j]*u[j]
                
        



cdef:
    int iterations = 10
    int i, j, N = 5
    double A[5][5] 
    double b_k[5]
    double b_k1[5] 
    double b_k2[5]
    double b_k3[5]

for i in prange(N, nogil = True):
    for j in range(i):
        A[i][j] = 1
        A[j][i] = 1

for i in prange(N, nogil = True):
    A[i][i] = 0

for i in prange(N, nogil = True):
    b_k[i] = <double>rand()/<double>RAND_MAX 

matrixVectorDot(N,A,b_k,b_k1)

