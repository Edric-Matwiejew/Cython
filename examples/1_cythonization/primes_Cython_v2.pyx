def primes(nPrimes):

    cdef int n = 2 # 0 and 1 are not prime, so start from 2.
    cdef int maxPrime = 0
    cdef int primeCount = 0
    cdef int i

    primes = []  # A list to store the primes.

    while primeCount < nPrimes:

        # Is n prime?
        for i in range(2, maxPrime):
            if n % i == 0:
                break
        # If no break occurred in the loop, we have a prime.
        else:
            primes.append(n)
            maxPrime = n
            primeCount += 1

        n += 1

    return primes
