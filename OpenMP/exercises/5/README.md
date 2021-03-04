Exercise 5
==========

This code computes the interaction forces of N point charges at a set potential V and periodic boundary conditions.

Linked below are two different input files named "position.xyz.DIM" . In order to choose what file you are accessing to, remember to define the DIM parameter in compilation phase, for example:

gcc -O3 -DDIM=55000 Nbody.c -o nbody -lm

After the execution, an output file with the results will be produced. It will contain the total energy of the system at the first line, and then the forces interacting with each particle.

Try to parallelize the code keeping in mind the following variations:

- while parallelizing the for loop you can choose between different scheduling options (static, guided, dynamic, ...) make some tests and see the differences.

- pay attention to the update of the "forces" array. You may want to update it by reducing it, but in the solutions there is also a slightly different version of the code which updates it atomically . You can test both versions and see the differences.


Input files:

position.xyz.20000

position.xyz.55000
