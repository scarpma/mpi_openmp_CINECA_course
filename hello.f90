program hello

use mpi
implicit none

integer :: ierr,size,myrank

call mpi_init(ierr)
call mpi_comm_size(MPI_COMM_WORLD,size,ierr)
call mpi_comm_rank(MPI_COMM_WORLD,myrank,ierr)

print *,'I am rank ',myrank, ' of ',size

call mpi_finalize(ierr)

end program hello
