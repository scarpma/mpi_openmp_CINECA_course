subroutine mpi_init(ierr)
integer :: ierr
write(*,*) 'Hi from mpi_init'

call pmpi_init(ierr)

end subroutine mpi_init
subroutine MPI_finalize(ierr)
integer :: ierr
write(*,*) 'Finishing..'
call pmpi_finalize(ierr)

end subroutine mpi_finalize

