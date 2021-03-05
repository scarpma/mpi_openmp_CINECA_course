#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=16
#SBATCH --account=tra21_mpiompB
#SBATCH --time=2:00
#SBATCH --partition=gll_usr_prod

# module load autoload intelmpi

export OMP_NUM_THREADS=16

time ./test
