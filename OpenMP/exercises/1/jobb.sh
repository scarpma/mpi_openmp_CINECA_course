#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=4
#SBATCH --account=tra21_mpiompB
#SBATCH --time=0:30
#SBATCH --partition=gll_usr_prod

# module load autoload intelmpi

export OMP_NUM_THREADS=4

./test &> log1
#./test &> log2
#./test &> log3
#./test &> log4
