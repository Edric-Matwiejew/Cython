# Assignment 8 (part 1) #
## Due 06/05/21 ##

1. Using the cython examples as reference, cythonize the module 'PyQuantumWalk' to create a faster C-extension module 'CyQuantumWalk'. (2 Marks)

As a suggested order:

	* Identify scalar variables to statically type
	* Convert constant length arrays into static C arrays
	* Experiment with the dynamic allocation of C arrays

Report the speed up of your final Cythonized module. 

Note: Marks will be awarded based on the reported speedup - or the variety in your usage of the Cython programming language.

2. Do you think the code in PyQuantumWalk is a good candidate for parallism? Justify your position and present the problem or a parallel solution. (2 Marks)

Total Assignments Marks: 10


### Background Information ####

'PyQuantumWalk' is a module simulating the discrete-time quantum walk of a 1/2-spinor a line (or path) graph.

https://en.wikipedia.org/wiki/Quantum_walk

Loosely speaking, 

a. If the spinsor is spin down, [1,0], it moves to the left. 
b. If the spinsor is spin up, [1,0], it moves to the right.
c. If the spinsor in an a superposition, it will move both left and right.

At each step the spinor:

1. Is put into an equal superposition at each of the line nodes (where it has probability density).
2. Moves from that node following rules (a) to (c).

Remember though, changes to the code using Cython should not interefere with the algorithm's logic, the output should remain the same.
