program prova
use mpi
implicit none

integer :: me, nproc, ii, ierr

call mpi_init(ierr)

nproc = 0
me = 0

call mpi_comm_size(MPI_COMM_WORLD, nproc, ierr)
call mpi_comm_rank(MPI_COMM_WORLD, me, ierr)

print *, "Hello World, I am proc ", me, "out of ", nproc

call mpi_finalize(ierr)

end program prova
