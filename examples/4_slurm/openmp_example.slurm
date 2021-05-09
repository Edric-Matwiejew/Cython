#!/bin/bash
#
# An example slurm script for a job using OpenMP.
#
#SBATCH --job-name=assignment          # the job's name
#SBATCH --nodes=1                      # the workstation is the node, always set to 1
#SBATCH --ntasks=1                     # number of tasks (or 'programs')
#SBATCH --cpus-per-task=32             # number of threads per task
#SBATCH --mem=8GB                      #RAM requested for the task
#SBATCH --time=00:10:00                # time limit hrs:min:sec
#SBATCH --output=out.log               # redirect the task terminal output to a *.log
#SBATCH --partition=coursework         # partition to which the job is submitted


# Load gcc before python3.9.
module load gcc
module load python3.9/

pip3 install matplotlib
python3 plot.py

# Set the compile flag after loading gcc.
export CFLAGS=-fopenmp

# Compile cython module 'matrix_multiplication', if it has changed.
cythonize -i matrix_multiplication.pyx $

# Run the parallel program.
echo "Demonstration of program scaling:"

echo "1 thread"
export OMP_NUM_THREADS=1
time python3 main.py

echo "2 threads"
export OMP_NUM_THREADS=2
time python3 main.py

echo "4 threads"
export OMP_NUM_THREADS=4
time python3 main.py

echo "8 threads"
export OMP_NUM_THREADS=8
time python3 main.py

echo "16 threads"
export OMP_NUM_THREADS=16
time python3 main.py

echo "32 threads"
export OMP_NUM_THREADS=32
time python3 main.py
