# module load autoload intelmpi
# mpiifort -o hello_f90 hello.f90

# budget tra21_mpiompB

srun -N 1 -n 4 -A tra21_mpiompB -p gll_usr_prod -t 5:00 --pty bash
# mpirun -n 4 ./rank &> log.txt
# mpirun -n 4 ./hello_f90
# srun
