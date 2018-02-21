#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[]) {

int size, rank;
double a[2],b[2];

MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);

if (rank ==0) {
   a[0]=2.0;
   a[1]=4.0;
   mpi_send(a,2,MPI_DOUBLE,1,10,MPI_COMM_WORLD);
   mpi_recv(b,2,MPI_DOUBLE,1,10,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
}
else if (rank==1) {
   a[0]=3.0;
   a[1]=5.0;
   mpi_recv(b,2,MPI_DOUBLE,0,10,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
   mpi_send(a,2,MPI_DOUBLE,0,10,MPI_COMM_WORLD);
}
printf("%d b[0]=%lf, b[1]=%lf \n",rank,b[0],b[1]);


MPI_Finalize();


}

