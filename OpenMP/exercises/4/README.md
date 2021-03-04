Exercise 4
==========

This code solves a 2-D Laplace equation by using a relaxation scheme.

The exercise is solved in 3 steps:

v1 : Parallelize the code by using OpenMP directives. Work on the most computationally intensive loop.

v2 : Try to include also the while loop in the parallel region

v3 : (Fortran users only): Also the part about the "T" array-sintax may be parallelized... (hint: use "omp workshare")

WARNING for C programmers: the solution may differ depending on what version of OpenMP is installed on your workstation, thus be careful to use 3.1 version or older.
