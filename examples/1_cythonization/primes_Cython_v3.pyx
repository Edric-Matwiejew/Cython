from cpython.mem cimport PyMem_Malloc, PyMem_Free

def primes(nPrimes):

    cdef int n = 2
    cdef int maxPrime = 0
    cdef int primeCount = 0
    cdef int i
    cdef int *primes = <int *>PyMem_Malloc(
            <int>nPrimes * sizeof(int))

    while primeCount < nPrimes:

        for i in range(2, maxPrime):
            if n % i == 0:
                break
        else:
            primes[primeCount] = n
            maxPrime = n
            primeCount += 1

        n += 1


    primesOut = [prime for prime in primes[:nPrimes]]

    PyMem_Free(primes)

    return primesOut



