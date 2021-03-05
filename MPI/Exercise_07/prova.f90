program prova
use mpi
implicit none

integer :: me, nproc, ii, ierr
real :: a

call mpi_init(ierr)

nproc = 0
me = 0

call mpi_comm_size(MPI_COMM_WORLD, nproc, ierr)
call mpi_comm_rank(MPI_COMM_WORLD, me, ierr)

a = 0.

if (me .eq. 0) then 
    a = 3.2
    a = 3.2 ** 2.
end if

print *, "me ", me, " a=", a, "\n"

call mpi_bcast(a, 1, MPI_REAL, 0, MPI_COMM_WORLD, ierr)

print *, "me ", me, " a=", a 

call mpi_finalize(ierr)

end program prova
