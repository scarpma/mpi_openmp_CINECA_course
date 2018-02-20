program ex3

  use mpi
  implicit none
  integer::ierr, size, myrank 
  integer, parameter::n = 10
  integer, dimension (n)::a, b
  integer :: src,dest

  ! dont forget the status param in recv integer status (MPI_STATUS_SIZE)
  call mpi_init (ierr)
  call mpi_comm_size (MPI_COMM_WORLD, size, ierr)
  call mpi_comm_rank (MPI_COMM_WORLD, myrank, ierr)

  if (myrank < size-1) then
     dest=myrank+1
  else
    dest=0
  endif

  if (myrank >0) then
    src=myrank-1 
  else
    src=size-1 
  endif

  call mpi_send (a, n, MPI_INTEGER, dest, 10, MPI_COMM_WORLD, ierr)
  call mpi_recv (b, n, MPI_INTEGER, src, 10, MPI_COMM_WORLD, status, ierr)

   write (*, *) 'I am task ', myrank, ' have received ', b (0)
   call mpi_finalize (ierr)
end program
