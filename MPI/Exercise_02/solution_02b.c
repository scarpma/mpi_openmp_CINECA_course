#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

#define ndata 10000

int main(int argc, char* argv[]){

    int ierr, me, nprocs, i=0, you;
    MPI_Status status;
    MPI_Request req;

    float a[ndata];
    float b[ndata];

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &me);


    for(i=0;i<ndata;++i){
    a[i] = me;
    }

    if(nprocs>2 && me==0){
    printf("\n\tThis program must run on 2 processors");
    return 0;
    }

    you = 1-me;

    MPI_Isend(a, ndata, MPI_REAL, you, 0, MPI_COMM_WORLD, &req);
    MPI_Recv(b, ndata, MPI_REAL, you, 0, MPI_COMM_WORLD, &status);

    MPI_Wait(&req,&status);    

    printf("\n\tI am task %d and I have received b(0) = %1.2f \n", me, b[0]);

    MPI_Finalize();

}
