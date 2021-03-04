#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=4
#SBATCH --account=#ACCOUNT#
#SBATCH --time=10:00
#SBATCH --partition=gll_usr_prod

#module load autoload intelmpi
module load autoload openmpi

export OMP_NUM_THREADS=4
./exercise.x
