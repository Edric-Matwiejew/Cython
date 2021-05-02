import numpy as np

def primes(nPrimes):

    if nPrimes > 1000:
        nPrimes = 1000

    primes = np.zeros(nPrimes, dtype = np.int32)  # A list to store the primes.
    primeCount = 0


    n = 2 # 0 and 1 are not prime, so start from 2.
    maxPrime = 0
    while primeCount < nPrimes:

        # Is n prime?
        for i in primes[:primeCount]:
            if n % i == 0:
                break
        # If no break occurred in the loop, we have a prime.
        else:
            primes[primeCount] = n
            maxPrime = n
            primeCount += 1
        n += 1

    return primes[:nPrimes]
