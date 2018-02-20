PROGRAM avoid_lock
  USE mpi
  Implicit none
  INTEGER ierr, myid, nproc
  INTEGER status(MPI_STATUS_SIZE)
  integer requests(4)

  REAL A(2), B(2)

  CALL MPI_INIT(ierr)
  CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
  CALL MPI_COMM_RANK(MPI_COMM_WORLD, myid, ierr)

  requests=MPI_REQUEST_NULL
  IF( myid .EQ. 0 ) THEN
     a(1) = 2.0
     a(2) = 4.0
     CALL MPI_ISEND(a, 2, MPI_REAL, 1, 10, MPI_COMM_WORLD, requests(1), ierr)
     CALL MPI_IRECV(b, 2, MPI_REAL, 1, 11, MPI_COMM_WORLD, requests(2), ierr)
  ELSE IF( myid .EQ. 1 ) THEN
     a(1) = 3.0
     a(2) = 5.0
     CALL MPI_ISEND(a, 2, MPI_REAL, 0, 11, MPI_COMM_WORLD, requests(3), ierr)
     CALL MPI_IRECV(b, 2, MPI_REAL, 0, 10, MPI_COMM_WORLD, requests(4), ierr)
  END IF
  call mpi_waitall(4, requests, MPI_STATUSES_IGNORE, ierr)

  WRITE(6,*) myid, ': b(1)=', b(1), ' b(2)=', b(2)

  CALL MPI_FINALIZE(ierr)

END program avoid_lock

