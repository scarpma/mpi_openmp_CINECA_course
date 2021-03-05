#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=16
#SBATCH --account=tra21_mpiompB
#SBATCH --time=0:30
#SBATCH --partition=gll_usr_prod

# module load autoload intelmpi

export OMP_NUM_THREADS=16

./test 1000 &> log1
./test 1000 &> log2
#./test &> log3
#./test &> log4
