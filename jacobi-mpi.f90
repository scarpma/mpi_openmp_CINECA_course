program jacobi

  use mpi
  implicit none

  real(8), parameter :: top=1.0,bottom=10.0, left=1.0,right=1.0
  integer, parameter :: max_iter=100000
  integer, parameter :: nprint=100
  integer :: nx,ny
  integer :: i,j,k,iter

  real(8) :: norm,bnorm,tmpnorm,rnorm
  real(8) :: tol=1e-4
  real(8), allocatable, dimension(:,:) :: grid,grid_new 
  real(8) :: start_time
  character(len=32) :: arg

  integer :: ierr,myrank,nsize,local_nx,requests(4)

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, nsize, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, myrank, ierr)

  start_time=MPI_Wtime()

  if (command_argument_count() /= 2) then
     print *, &
          "You must provide two command line arguments, the global size in X and the global size in Y"
     stop
  end if

  call get_command_argument(1, arg)
  read(arg,*) nx
  call get_command_argument(2, arg)
  read(arg,*) ny

  if (myrank==0) print *,'grid size ',nx, ' x ',ny

  local_nx=nx/nsize
  if (local_nx * nsize .lt. nx) then
      if (myrank .lt. nx - local_nx * nsize) local_nx=local_nx+1
  end if

  allocate(grid(0:ny+1,0:local_nx+1),grid_new(0:ny+1,0:local_nx+1) )


  ! boundary conditions

  grid(0,:)=left
  grid(local_nx+1,:)=right
  if (myrank ==0) then
     grid(:,0) = top
  endif
  if (myrank ==nsize-1) then
     grid(:,local_nx+1)=bottom
  endif

  ! starting conditions
  grid(1:ny,1:local_nx)=0.0
  grid_new=grid


  !! initial norm value

  tmpnorm=0.0
  do j=1,local_nx
     do i=1,ny
        tmpnorm=tmpnorm+((grid(i,j)*4-grid(i-1,j)-grid(i+1,j)-grid(i,j-1)-grid(i,j+1))**2)
     enddo
  enddo
  call mpi_allreduce(tmpnorm, bnorm, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD, ierr)


  bnorm=sqrt(bnorm)

  requests=MPI_REQUEST_NULL

  do iter=1, max_iter

     !  Insert Halo communications here
     !  HINT: You will need  two ifs, 1 for myrank>0, 1 for myrank <nsize-1
     !        Each if should have a MPI_Send/MPI_Recv pair. 
     ! 
    tmpnorm=0.0
     do j=1,local_nx
        do i=1,ny
           tmpnorm=tmpnorm+((grid(i,j)*4-grid(i-1,j)-grid(i+1,j)-grid(i,j-1)-grid(i,j+1))**2)
        enddo
     enddo

     call mpi_allreduce(tmpnorm, rnorm, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD, ierr)
     norm=sqrt(rnorm)/bnorm
 
    if (norm .lt. tol) exit

     do j=1,local_nx
        do i=1,ny
           grid_new(i,j)=0.25 * (grid(i-1,j) + grid(i+1,j) + grid(i,j-1) + grid(i,j+1))
        end do
     end do

     grid=grid_new

     if (mod(iter,nprint)==0 .and. myrank==0) then
        write(*,*) 'Iteration ',iter,' Relative norm ',norm
     endif

  enddo
  if (myrank ==0) write(*,*) 'Terminated on ',iter, ' iterations, relative norm=',norm, 'runtime=',MPI_Wtime()-start_time
  
  deallocate(grid,grid_new)

  call mpi_finalize(ierr)
end program jacobi

