#!/bin/bash
mpiifort -shared -fpic -o libmympi.so mympi.f90
mpiifort -o myprog myprog.f90
mpirun -genv LD_PRELOAD ./libmympi.so -np 2 ./myprog

