from cpython.mem cimport PyMem_Malloc, PyMem_Realloc, PyMem_Free

def primes(nPrimes):

    cdef int n = 2 # 0 and 1 are not prime, so start from 2.
    cdef int maxPrime = 0
    cdef int primeCount = 0
    cdef int i
    # Creating a pointer to a section of memory.
    # Using PyMem_Malloc command.
    # Size 'int bytes x 'nPrimes'.
    # Note the explicit type conversion.
    cdef int *primesMem = <int *>PyMem_Malloc(<int>nPrimes * sizeof(int))
    # Creating a 'dataview' into the allocated memory.
    # A bit like taking a 'slice' of a NumPy array, bit different.
    # Note, the dimension is specified at the variable type, not variable name.
    #       The type conversion always requries an upper bound.
    #       We can always get the shape of a 'dataview' using the *.shape() method.
    #       lengthPrimes = primes.shape[0]
    cdef int[:] primes = <int[:<int>nPrimes]>primesMem # A c-array in which to store the primes.

    while primeCount < nPrimes:

        # Is n prime?
        for i in range(2, maxPrime):
            if n % i == 0:
                break
        # If no break occurred in the loop, we have a prime.
        else:
            primes[primeCount] = n
            maxPrime = n
            primeCount += 1

        n += 1


    primesOut = [prime for prime in primes[:nPrimes]]

    # We always need to free dynamically allocated memory.
    # If we don't, we get a 'memory leak'
    # Unused allocated memory chewing up your RAM.
    PyMem_Free(primesMem)

    # Statically declared arrays are automatically deallocated!

    return primesOut
