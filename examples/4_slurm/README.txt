# OpenMP and Slurm Job Scheduling

This folder contains a demonstration of how to compile and run OpenMP parallel Cython code on the QUISA workstation using the Slurm job scheduler. The *.pyx file contains a program demonstrating OpenMP parallelised matrix-multiplication. The Slurm job script 'openmp_example.slurm', sets up the required software envionment, compiles the *.pyx file and measures the wall-time of the program 'main.py' over an increasing number of hreads..There will be a formal introduction to Slurm and software managment using Environment Modules in the next workshop. For now, this will enable you to start running your code on a more powerful computer - if you are interested in doing so. 

## Accessing and Using the Workstation


1. Log on following the instructions posted to LMS.

2. Using 'cd' in the terminal, navigate to your group directory:

        '''
	cd $MY_GROUP
        '''
3. Clone the updated Cython repository to $MY_GROUP:
	
	'''
	git clone https://github.com/Edric-Matwiejew/Cython.git

	'''

To run your own code, copy the contents of this folder, replace the Cython and Python files with your own, and modify 'opemmp_example.slurm' accordingly. 

## Example Workflow

But before running your own code:

1. Submit the example job: 

	user@DEP58330: sbatch openmp_example.py

2. Look at the status of the job in the queue:

	user@DEP58330: squeue

3. Once the job has finished, read the program output:

	user@DEP58330: cat out.log

A speedup should be observed as the number of threads increases from 1 to 32. 

## ***Warning***!

Interactive user accounts are allocated 128M of RAM and 1/10th of a single CPU thread - without Slurm you'll be computing like it's 1999.

