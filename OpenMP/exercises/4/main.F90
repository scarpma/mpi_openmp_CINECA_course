program laplace
#ifdef _OPENMP
    use omp_lib
#endif
   implicit none
   integer, parameter                 :: dp=kind(1.d0)
   integer                            :: n, maxIter, i, j, iter = 0
   real (dp), dimension(:,:), pointer :: T, Tnew, Tmp=>null()
   real (dp)                          :: tol, var = 1.d0, top = 100.d0
   integer                            :: ierr
   character(len=128)                 :: command
   character(len=80)                  :: arg
   real(8)                            :: wtime1, wtime2

   call get_command_argument(0,command)
   if (command_argument_count() /= 3) then
     write(0,*) 'Usage:', trim(command), 'mesh_size maxIter, tolerance'
     stop
   else
     call get_command_argument(1,arg)
     read(arg,*) n
     call get_command_argument(2,arg)
     read(arg,*) maxIter
     call get_command_argument(3,arg)
     read(arg,*) tol
   endif

#ifdef _OPENMP
    wtime1 = omp_get_wtime()
#else
   call cpu_time(wtime1)
#endif

   allocate (T(0:n+1,0:n+1), Tnew(0:n+1,0:n+1),stat=ierr)
   if(ierr/=0) STOP 'T Tnew matrix allocation failed'

   T(0:n,0:n) = 0.d0

   T(n+1,1:n) = (/ (i, i=1,n) /) * (top / (n+1))
    
   T(1:n,n+1) = (/ (i, i=1,n) /) * (top / (n+1))

   Tnew = T

!$omp parallel
   do while (var > tol .and. iter <= maxIter)
!$omp barrier
!$omp single
      iter = iter + 1
      var = 0.d0       
!$omp end single


!$omp do private(i,j) reduction(max:var)
      do j = 1, n
         do i = 1, n
            Tnew(i,j) = 0.25d0 * ( T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1) )
            var = max(var, abs( Tnew(i,j) - T(i,j) ))
         end do
      end do
!$omp end do
!$omp single
      Tmp =>T; T =>Tnew; Tnew => Tmp; 

      if( mod(iter,100) == 0 ) write(*,"(a,i8,e12.4)") &
         ' iter, variation:', iter, var
!$omp end single nowait

   end do
!$omp end parallel

#ifdef _OPENMP
    wtime2 = omp_get_wtime()
#else
   call cpu_time(wtime2)
#endif

   write(*,'(/A,F10.4)') ' Elapsed time (s)     =', wtime2 - wtime1
   write(*,*) 'Mesh size            =', n
   write(*,*) 'Stopped at iteration =', iter
   write(*,*) 'The maximum error    =', var
    
   open(10, file='results', action='write', iostat=ierr)
   if(ierr /= 0)  STOP 'Error in opening output file!'
   write(10, "(i8, i8, e18.9)") (( i, j, T(i,j), i=1,n), j=1,n)
   close(10)

   deallocate (T, Tnew)
   nullify(Tmp)

end program laplace
