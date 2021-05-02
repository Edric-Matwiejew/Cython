import sys
sys.path.insert(1,'compiled_modules/')

import time
import primes_Python
import primes_Cython_v1
import primes_Cython_v2
import primes_Cython_v3
import primes_Cython_v4
import primes_NumPy

repeats = 100

nPrimes = 300

start = time.time()
for i in range(repeats):
    primes = primes_Python.primes(nPrimes)
pythonTime = (time.time() - start)/repeats
print(primes)
print('Primes (Python): ', pythonTime)

start = time.time()
for i in range(repeats):
    primes = primes_Cython_v1.primes(nPrimes)
#print(primes)
cython1Time = (time.time() - start)/repeats
print('Primes (Cython1): ', cython1Time, 'Speedup (x): ', pythonTime/cython1Time)

start = time.time()
for i in range(repeats):
    primes = primes_Cython_v2.primes(nPrimes)
#print(primes)
cython2Time = (time.time() - start)/repeats
print('Primes (Cython2): ', cython2Time, 'Speedup (x): ', pythonTime/cython2Time)

start = time.time()
for i in range(repeats):
    primes = primes_Cython_v3.primes(nPrimes)
#print(primes)
cython3Time = (time.time() - start)/repeats
print('Primes (Cython3): ', cython3Time, 'Speedup (x): ', pythonTime/cython3Time)

start = time.time()
for i in range(repeats):
    primes = primes_Cython_v4.primes(nPrimes)
#print(primes)
cython4Time = (time.time() - start)/repeats
print('Primes (Cython4): ', cython4Time, 'Speedup (x): ', pythonTime/cython4Time)

start = time.time()
for i in range(repeats):
    primes = primes_NumPy.primes(nPrimes)
#print(primes)
NumPyTime = (time.time() - start)/repeats
print('Primes (NumPy): ', NumPyTime, 'Speedup (x): ', pythonTime/NumPyTime)

