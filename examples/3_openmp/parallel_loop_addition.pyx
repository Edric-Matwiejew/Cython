
from cython.parallel import prange


cdef:
    int i, n = 100000
    int a[100000]
    int b[100000]
    int c[100000]

for i in prange(n, nogil = True):
    a[i] = i
    b[i] = i

for i in range(5):
    print('a:', a[i], 'b:', b[i])

for i in prange(n, nogil = True):
    c[i] = a[i] + b[i]

for i in range(5):
    print('a:', a[i], 'b:', b[i], 'c:', c[i])






