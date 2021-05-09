# Assignment 8
## Part 1
### Due 13/05/21 ###

Clone the assignment files form:

https://github.com/Edric-Matwiejew/Cython.git

1. Using the cython examples as reference, cythonize the module 'PyQuantumWalk' to create a faster C-extension module 'CyQuantumWalk'. (2 Marks)

As a suggested order:

	* Identify scalar variables to statically type
	* Convert constant length arrays into static C arrays
	* Experiment with the dynamic allocation of C arrays

Report the speed up of your final Cythonized module. 

Note: Marks will be awarded based on the reported speedup - or the variety in your usage of the Cython programming language.

2. Do you think the code in PyQuantumWalk is a good candidate for parallism? Justify your position, present the problem or a parallel solution. (2 Marks)

### Background Information ####

'PyQuantumWalk' is a module simulating the discrete-time quantum walk of a 1/2-spinor a line (or path) graph.

https://en.wikipedia.org/wiki/Quantum_walk

Loosely speaking, 

    a. If the spinor is spin down, [1,0], it moves to the left. 
    b. If the spinor is spin up, [0,1], it moves to the right.
    c. If the spinor in an a superposition, it will move both left and right.

At each step the spinor:

1. Is put into an equal superposition at each of the line nodes (where it has probability density).
2. Moves from that node following rules (a) to (c).

Changes to the code using Cython should not interefere with the algorithm's logic, the output should remain the same.

## Part 2

3. The $n$-dimensional unit-sphere is an object whose parameters satisfy:
    '''
    $`𝑥_1^2+…+𝑥_𝑛^2=1`$
    '''
With reference to,

https://en.wikipedia.org/wiki/Monte_Carlo_integration#Overview,

and 

https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm ,

Develop a parallel algorithm capable of calculating the volume of an $`n`$-dimensional unit sphere (at least) up to $`𝑛=10`$. Outline your algorithm using a  program flow chart.

Implement this algorithm so it can solve up to (at least) $`𝑛=10`$.

Plot the performance of your package as a function of thread count, and target variance, comment of the success of your algorithm in terms of its speed and accuracy.
(6 marks)
