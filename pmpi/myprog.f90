program myprog
use mpi
integer :: ierr,size,rank

call mpi_init(ierr)
call mpi_comm_size(mpi_comm_world,size,ierr)
call mpi_comm_rank(mpi_comm_world,rank,ierr)

write(*,*) 'Rank ',rank,' of ',size


call mpi_finalize(ierr)
end program myprog
