#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[]) {

int size, rank;
double a[2],b[2];

MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
MPI_Request *requests;

requests[]={MPI_REQUEST_NULL, MPI_REQUEST_NULL, MPI_REQUEST_NULL, MPI_REQUEST_NULL};
if (rank ==0) {
   a[0]=2.0;
   a[1]=4.0;
   MPI_Send(a,2,MPI_DOUBLE,1,10,MPI_COMM_WORLD,requests[0];
   MPI_Recv(b,2,MPI_DOUBLE,1,10,MPI_COMM_WORLD,requests[1]);
}
else if (rank==1) {
   a[0]=3.0;
   a[1]=5.0;
   MPI_Recv(b,2,MPI_DOUBLE,0,10,MPI_COMM_WORLD,requests[2]);
   MPI_Send(a,2,MPI_DOUBLE,0,10,MPI_COMM_WORLD,requests[3]);
}

// Passing MPI_STATUS_IGNORE for the status argument causes MPI to skip filling in the status field
MPI_Waitall(4, requests, MPI_STATUSES_IGNORE);
printf("%d b[0]=%lf, b[1]=%lf \n",rank,b[0],b[1]);


MPI_Finalize();


}

