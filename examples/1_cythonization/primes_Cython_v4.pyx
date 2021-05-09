def primes( int nPrimes):

    if nPrimes > 1000:
        nPrimes = 1000

    cdef int n = 2 # 0 and 1 are not prime, so start from 2.
    cdef int maxPrime = 0,  primeCount = 0
    cdef int i
    cdef int[1000] primes # A c-array in which to store the primes.

    while primeCount < nPrimes:

        # Is n prime?
        for i in range(primeCount):
            if n % primes[i] == 0:
                break
        # If no break occurred in the loop, we have a prime.
        else:
            primes[primeCount] = n
            maxPrime = n
            primeCount += 1

        n += 1

    return [prime for prime in primes[:primeCount]]
