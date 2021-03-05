program prova
use mpi
implicit none

integer :: me, nproc, ii, ierr, errcode, req
integer :: status(MPI_STATUS_SIZE), status2(MPI_STATUS_SIZE)
integer, parameter :: N = 10
integer :: num_local_col, reminder, left_proc, right_proc
integer, allocatable :: matrix(:,:)

call mpi_init(ierr)

nproc = 0
me = 0

call mpi_comm_size(MPI_COMM_WORLD, nproc, ierr)
call mpi_comm_rank(MPI_COMM_WORLD, me, ierr)

reminder = mod(N, nproc)
num_local_col = (N - reminder) / nproc
! aggiungo colonne nel caso di N non divisibile per nproc
if (me < reminder) num_local_col = num_local_col + 1

! initialization of local matrix
allocate(matrix(N, num_local_col + 2))
matrix = me

left_proc = me - 1
right_proc = me + 1
if (left_proc < 0) left_proc = nproc - 1 
if (right_proc .eq. nproc) right_proc = 0

print *, "me ", me, " proc left ", left_proc, " proc right ", right_proc
print *, "me ", me, " num_local_col ", num_local_col

call mpi_sendrecv(matrix(:,2), N, MPI_INTEGER, left_proc, 10, &
                  matrix(:,num_local_col+2), N, MPI_INTEGER, right_proc, 10, &
                  MPI_COMM_WORLD, status ,ierr)

call mpi_sendrecv(matrix(:,num_local_col+1), N, MPI_INTEGER, right_proc, 11, &
                  matrix(:,1), N, MPI_INTEGER, left_proc, 11, &
                  MPI_COMM_WORLD, status2 ,ierr)

print *, "I am ", me, " col recv from left ", matrix(:,1)
print *, "I am ", me, " col recv from right ", matrix(:,num_local_col + 2)

deallocate(matrix)

call mpi_finalize(ierr)

end program prova
