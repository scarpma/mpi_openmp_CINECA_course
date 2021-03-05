program prova
use mpi
implicit none

integer :: me, you, nproc, ii, ierr, errcode, req
integer :: status(MPI_STATUS_SIZE)
integer, parameter :: ndata = 10000
real, dimension(:) :: a(ndata), b(ndata)

call mpi_init(ierr)

nproc = 0
me = 0

call mpi_comm_size(MPI_COMM_WORLD, nproc, ierr)
call mpi_comm_rank(MPI_COMM_WORLD, me, ierr)
if (nproc .NE. 2) then
    print *, "nproc must be 2."
    call mpi_abort(MPI_COMM_WORLD, errcode, ierr)
    stop
end if


you = 1 - me
a(:) = me

!! if (me .EQ. 0) then
!!     call mpi_send(a, ndata, MPI_REAL, 1, 0, MPI_COMM_WORLD, ierr)
!!     call mpi_recv(b, ndata, MPI_REAL, 1, 0, MPI_COMM_WORLD, status, ierr)
!! else
!!     call mpi_recv(b, ndata, MPI_REAL, 0, 0, MPI_COMM_WORLD, status, ierr)
!!     call mpi_send(a, ndata, MPI_REAL, 0, 0, MPI_COMM_WORLD, ierr)
!! end if

call mpi_isend(a, ndata, MPI_REAL, you, 0, MPI_COMM_WORLD, req, ierr)
call mpi_recv(b, ndata, MPI_REAL, you, 0, MPI_COMM_WORLD, status, ierr)
call mpi_wait(req, status, ierr)

print *, "I am task ", me, "and I have received b(1) = ", b(1)

call mpi_finalize(ierr)

end program prova
