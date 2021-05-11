# distutils: language = c++
# distutils: extra_compile_args = -std=c++11

cdef extern from "<random>" namespace "std":
    cdef cppclass mt19937:
        mt19937() # we need to define this constructor to stack allocate classes in Cython
        mt19937(unsigned int seed) # not worrying about matching the exact int type for seed
    
    cdef cppclass uniform_real_distribution[T]:
        uniform_real_distribution()
        uniform_real_distribution(T a, T b)
        T operator()(mt19937 gen) # ignore the possibility of using other classes for "gen"
        
def test():
    cdef:
        mt19937 gen = mt19937(5)
        uniform_real_distribution[double] dist = uniform_real_distribution[double](0.0,1.0)
    return dist(gen)