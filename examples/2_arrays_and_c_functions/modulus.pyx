from cpython.mem cimport PyMem_Malloc, PyMem_Free

cdef modulusSquared1(double complex[::1] z):

    cdef int i, n = z.shape[0]

    for i in range(n):
        z[i] = z[i].real*z[i].real + z[i].imag*z[i].imag

cdef modulusSquared2(double complex[:,::1] z):

    cdef:
        int i, j
        int ni = z.shape[0]
        int nj = z.shape[1]


    for i in range(ni):
        for j in range(nj):
            z[i][j] = z[i][j].real*z[i][j].real + z[i][j].imag*z[i][j].imag


def test(a):

    cdef:
        int i
        double complex *balloc = <double complex * >PyMem_Malloc(<int>a * sizeof(double complex))
        double complex *calloc = <double complex * >PyMem_Malloc(<int>a*2 * sizeof(double complex))
        double complex[::1] b = <double complex[:a]>balloc
        double complex[:,::1] c = <double complex[:a,:2]>calloc

    for i in range(a):
        b[i] = 1 + 1j
        c[i][0] = 1+ 2j
        c[i][1] = 1+ 3j

    modulusSquared1(b)
    modulusSquared2(c)
 
    print('b:')
    for i in range(a):
        print(b[i])

    print('\nc:')
    for i in range(a):
        print(c[i][0], c[i][1])

    PyMem_Free(balloc)
    PyMem_Free(calloc)
 

#print(test(10))
