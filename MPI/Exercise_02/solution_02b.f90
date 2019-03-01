program hello
  implicit none
  include 'mpif.h'

  integer ierr,me,nprocs,you,req
  integer status(MPI_STATUS_SIZE)

  integer,parameter :: ndata = 10000
  real :: a(ndata)
  real :: b(ndata)

  call MPI_INIT(ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, me, ierr)

  a = me

  if (nprocs /= 2) then
     print *,'This program must run on 2 processors'
     call MPI_ABORT(ierr)
     stop
  endif

  you = 1-me

  call MPI_ISEND(a,ndata,MPI_REAL,you,0,MPI_COMM_WORLD,req,ierr)
  call MPI_RECV(b,ndata,MPI_REAL,you,0,MPI_COMM_WORLD,status,ierr)

  call MPI_WAIT(req,status,ierr)

  print *,'I am task ',me,' and I have received b(1) = ',b(1)
  call MPI_FINALIZE(ierr)

end program hello
