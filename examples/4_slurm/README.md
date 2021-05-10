## OpenMP and Slurm Job Scheduling

This folder contains an example of how to compile and run OpenMP parallelised Cython code on the QUISA workstation using the Slurm job scheduler. The *.pyx file contains a program demonstrating OpenMP parallelised matrix-multiplication. The Slurm job script 'openmp_example.slurm' sets up the required software environment, compiles the *.pyx file and measures the wall-time of the program 'main.py' over an increasing number of threads. 

There will be a formal introduction to Slurm and software management using Environment Modules in the next workshop. For now, this will enable you to start running your code on a more powerful computer - if you are interested in doing so. 

### Accessing and Using the Workstation

1. Log on following the instructions posted to LMS.

2. Using 'cd' in the terminal, navigate to your group directory:
```bash
cd $MY_GROUP
```
3. Clone the updated Cython repository (or your fork of the respository) into $MY_GROUP:
	
```bash
git clone https://github.com/Edric-Matwiejew/Cython.git
```

4. Navigate to Cython/examples/4_slurm:

```bash
cd Cython/examples/4_slurm
```

To run your code, copy the contents of this folder, replace the Cython and Python files with your own, and modify 'opemmp_example.slurm' accordingly. On the workstation you can use Nano or Vim to edit text files. Otherwise, edit these files locally in your favourite text editor and transfer them to the workstation using Git + Github.

### Example Workflow

But beforehand, ensure that you can complete the following steps:

1. Submit the example job: 
```bash
sbatch openmp_example.py
```

2. Look at the status of the job in the queue:
```bash
squeue
```

3. Once the job has finished, read the program output:
```bash
cat out.log
```

A speedup should be observed as the number of threads increases from 1 to 32. 

There a number of way to get files on-and-off the workstation (and other remote computers). For now, transfer your work using Git and your GitHub account.

### ***Warning***!

Interactive user accounts are allocated 128M of RAM and 1/10th of a single CPU thread - without Slurm you'll be computing like it's 1999.

