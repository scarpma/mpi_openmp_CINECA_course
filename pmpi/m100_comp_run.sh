#!/bin/bash
module purge
module load gnu spectrum_mpi
mpif90 -shared -fPIC -o libmympi.so mympi.f90
mpif90 -o myprog myprog.f90
mpirun -np 2 -x LD_PRELOAD=./libmympi.so ./myprog
