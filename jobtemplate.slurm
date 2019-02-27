#!/bin/bash
#SBATCH -N1
#SBATCH --tasks-per-node=4
#SBATCH --account=#ACCOUNT#
#SBATCH --time=10:00
#SBATCH --partition=gll_usr_prod

module load autoload intelmpi

srun -n 4 ./exercise.x
