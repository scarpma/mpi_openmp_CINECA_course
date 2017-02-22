#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mpi.h"
#include <string.h>


// Grid boundary conditions
#define RIGHT 1.0
#define LEFT 1.0
#define TOP 1.0
#define BOTTOM 10.0

// Algorithm settings
#define TOLERANCE 0.0001
#define NPRINT 1000
#define MAX_ITER 10000

int main(int argc, char*argv[]) {

  int k;
  double tmpnorm,bnorm,norm;

  int size,myrank; 
  MPI_Request requests[]={MPI_REQUEST_NULL, MPI_REQUEST_NULL, MPI_REQUEST_NULL, MPI_REQUEST_NULL};

  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&size);
  MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

  if (argc !=3) {
    if (myrank==0) printf("usage: %s GRIDX GRIDY\n",argv[0]);
    return(-1);
  }


  int nx=atoi(argv[1]);
  int ny=atoi(argv[2]);
  int ny2=ny+2;

  if (myrank==0) printf("grid size %d X %d \n",ny,ny);

  // local grid size
  int local_nx=nx/size;
  if (local_nx * size < nx) {
    if (myrank < nx - local_nx * size) local_nx++;
  }

  double *grid= (double*)malloc(sizeof(double)*(local_nx+2)*(ny+2));
  double *grid_new= (double*)malloc(sizeof(double)*(local_nx+2)*(ny+2));
  double start_time;
  
 
  // Initialise Grid boundaries
  int i,j;
  for (i=0;i<ny+2;i++) {
    grid_new[i]=grid[i]=  (myrank==0 ?TOP:0.0);
    j=(ny+2)*(local_nx+1)+i;
    grid_new[j]=grid[j]=  (myrank==size-1?BOTTOM:0.0);
  }
  for (i=1;i<local_nx+1;i++) {
    j=(ny+2)*i;
    grid_new[j]=grid[j]=LEFT;
    grid_new[j+ny+1]=grid[j+ny+1]=RIGHT;
  }
   
  // Initialise rest of grid
  for (i=1;i<=local_nx;i++) 
    for (j=1;j<=ny;j++)
      k=(ny+2)*i+j;
  grid_new[k]=grid[k]=0.0;
   
  // Calculate initial norm
  tmpnorm=0.0;
  for (i=1;i<=local_nx;i++) {
    for (j=1;j<=ny;j++) {
      k=(ny+2)*i+j;            
      tmpnorm=tmpnorm+pow(grid[k]*4-grid[k-1]-grid[k+1] - grid[k-(ny+2)] - grid[k+(ny+2)], 2); 

    }
  }
  MPI_Allreduce(&tmpnorm, &bnorm, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
  bnorm=sqrt(bnorm);

  start_time=MPI_Wtime();
  int iter;
  for (iter=0; iter<MAX_ITER; iter++) {

    // Halo communications
    // Insert halo communications here:	
     //  HINT: You will need  two ifs, 1 for myrank>0, 1 for myrank <nsize-1
     //        Each if should have a MPI_Send/MPI_Recv pair. 
	
    // Recalculate norm
    //
    double rnorm;
    tmpnorm=0.0;
    for (i=1;i<=local_nx;i++) {
      for (j=1;j<=ny;j++) {
	k=(ny+2)*i+j;
	tmpnorm=tmpnorm+pow(grid[k]*4-grid[k-1]-grid[k+1] - grid[k-(ny+2)] - grid[k+(ny+2)], 2); 
      }
    }

    // Sum up all the tmpnorms and copy to all nodes
    // mpi command here
    norm=sqrt(rnorm)/bnorm;

    // Convergence test
    //
    if (norm < TOLERANCE) break;

    // Calculate new grid
    for (i=1;i<=local_nx;i++) {
      for (j=1;j<=ny;j++) {
	k=(ny+2)*i+j;    
	grid_new[k]=0.25 * (grid[k-1]+grid[k+1] + grid[k-(ny+2)] + grid[k+(ny+2)]);
      }
    }

    // Copy newgrid into old one for next cycle
    memcpy(grid, grid_new, sizeof(double) * (local_nx + 2) * (ny+2));

    if (iter % NPRINT ==0 && myrank==0 ) printf("Iteration =%d ,Relative norm=%e\n",iter,norm);
  }
  // End of iterative cycle

  if (myrank==0) printf("Terminated on %d iterations, Relative Norm=%e, Total time=%e seconds \n", iter,norm, MPI_Wtime() - start_time);
  


  free(grid);
  //free(temp);
  free(grid_new);

  MPI_Finalize();
  return 0;
    

}
