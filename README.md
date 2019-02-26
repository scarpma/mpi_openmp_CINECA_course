# MPI example programs for the Cineca MPI + OpenMP course.
 
 

## Login and download tutorial
```bash
ssh username@login.galileo.cineca.it
git clone https://gitlab.hpc.cineca.it/training/mpi-openmp.git
```
The username and password will be provided to you by the demonstrators.
From time-to-time the demonstrators may update the tutorial with solutions or further
materials. To see the updates do the following in the  tutorial directory,
```bash
git pull
```

## Running slurm jobs on galileo
For this you will need also the "account number", i.e the budget, which will be supplied by a demonstrator.
For example with an account number of train_mpi19 you can set the budget in  a slurm script as follows
```bash
#SBATCH --account=train_mpi19
```
do not confuse it with the UNIX username!


