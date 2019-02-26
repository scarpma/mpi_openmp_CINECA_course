#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=4
#SBATCH --account=#ACCOUNT#
#SBATCH --time=10:00

module load autoload intelmpi

mpirun -n 4 ./exercise.x
