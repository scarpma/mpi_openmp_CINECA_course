program hello

#ifdef _OPENMP
    use omp_lib
#endif
    implicit none
    integer :: a, iam
    
    a = 0

#ifdef _OPENMP
!$OMP PARALLEL
    iam = omp_get_thread_num()
    print *, 'hello world, me=', iam
    ! a = a + iam
!$OMP END PARALLEL
#endif

    print *, a

end program hello
