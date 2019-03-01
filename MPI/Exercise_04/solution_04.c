#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

int main(int argc, char* argv[]){

    int me, nprocs, left, right, count;
    MPI_Status status;

    float a;
    float b;
    float sum;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &me);
    /* Initialize workspace */
    a   = me;
    b   = -1;
    sum = a;
    /* Compute neighbour ranks */
    right = (me+1)%nprocs;
    left  = (me-1+nprocs)%nprocs;

    /* Circular sum*/
    for(count = 1; count < nprocs; count++)
      {
    MPI_Sendrecv(&a, 1, MPI_FLOAT, left, 0, &b, 1, MPI_FLOAT, right, 0, MPI_COMM_WORLD, &status);
    /* Set "a" value to the newly received rank */
    a    = b;
    /* Update the partial sum */
    sum += a;
      }
    printf("\tI am proc %d and sum(0) = %1.2f \n", me, sum);

    MPI_Finalize();

}