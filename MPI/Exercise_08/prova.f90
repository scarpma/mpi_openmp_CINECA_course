program prova
use mpi
implicit none

integer :: me, nproc, ii, ierr, rem
integer, parameter :: count = 2, len=10
real :: a(len), b(count)

call mpi_init(ierr)

nproc = 0
me = 0

call mpi_comm_size(MPI_COMM_WORLD, nproc, ierr)
call mpi_comm_rank(MPI_COMM_WORLD, me, ierr)

rem = mod(len, nproc)
count = (len-rem) / nproc

if (me < rem) then
    count = count + 1
end do

if (me .eq. 0) then 
  do ii=1,size(a)
    a(ii) = real(ii)
  end do
end if

call mpi_scatter(a, count, MPI_REAL, b, count, MPI_REAL, 0, MPI_COMM_WORLD, ierr)

print *, "me ", me, " a(1)=", b(1), " b(2)=", b(2) 

b = b + me

call mpi_gather(b, count, MPI_REAL, a, 2, MPI_REAL, 0, MPI_COMM_WORLD, ierr)

if (me .eq. 0) then
    do ii=1,size(a)
        print *, "ii=", ii, " a(ii)=", a(ii)
    end do
end if

call mpi_finalize(ierr)

end program prova
