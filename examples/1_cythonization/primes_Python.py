def primes(nPrimes):

    primes = []  # A list to store the primes.

    n = 2 # 0 and 1 are not prime, so start from 2.
    maxPrime = 0
    while len(primes) < nPrimes:

        # Is n prime?
        for i in range(2, maxPrime):
            if n % i == 0:
                break
        # If no break occurred in the loop, we have a prime.
        else:
            primes.append(n)
            maxPrime = n
        n += 1

    return primes
