#!/bin/bash

srun -N 1 -n 4 -A tra21_mpiompB -p gll_usr_prod -t 5:00 ./test &> log

