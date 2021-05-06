
from cython.parallel import prange


cdef:
    int i, n = 100000
    int a[100000]
    int b[100000]
    int c[100000]
    int total = 0

for i in prange(n, nogil = True):
    a[i] = i
    b[i] = i

for i in prange(n, nogil = True):
    total += a[i] + b[i]

print(<double>total/n)







