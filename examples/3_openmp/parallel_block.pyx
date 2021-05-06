

from cython.parallel import parallel
cimport openmp

cdef int thread_id, num_threads

print("Maximum possible threads:",
        openmp.omp_get_max_threads())

print(
        "Number of active threads:",
        openmp.omp_get_num_threads(),
        "Thread ID:",
        openmp.omp_get_thread_num())

with nogil, parallel():

    num_threads = openmp.omp_get_num_threads()
    thread_id = openmp.omp_get_thread_num()

    with gil:
        print(
                "Number of active threads:",
                openmp.omp_get_num_threads(),
                "Thread ID:",
                openmp.omp_get_thread_num())

print(
        "Number of active threads:",
        openmp.omp_get_num_threads(),
        "Thread ID:",
        openmp.omp_get_thread_num())



