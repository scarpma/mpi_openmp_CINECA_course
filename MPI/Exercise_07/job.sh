# module load autoload intelmpi
# mpiifort -o hello_f90 hello.f90

# budget tra21_mpiompB

srun -N1 -n4 -A tra21_mpiompB -p gll_usr_prod -t 2:00 --pty bash

# srun -N1 -n4 -A tra21_mpiompB -p gll_usr_prod -t 10:00 bash \
# mpirun -n 4 ./test &> log.txt

# mpirun -n 4 ./hello_f90
# srun
