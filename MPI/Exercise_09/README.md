# Exercise 9

Each process initializes a one-dimensional array by giving to all the elements the value of its rank+1. Then the root process (task 0) performs two reduce operations (sum and then product) to the arrays of all the processes. Finally, each process generates a random number and root process finds (and prints) the maximum value among these random values.

Modify the code to perform a simple scalability test using MPI_Wtime. Notice what happens when you go up with the number of processes involved.

## HINTS:

|    | **C** | **FORTRAN** |
|----|-------|-------------|
| [MPI_REDUCE](https://www.open-mpi.org/doc/v3.1/man3/MPI_Reduce.3.php) | int MPI_Reduce(void\* sendbuf, void\* recvbuf, int count, MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm) | MPI_REDUCE(SENDBUF, RECVBUF, COUNT, DATATYPE, OP, ROOT, COMM, IERROR) <br> \<type> SENDBUF(\*), RECVBUF(\*) INTEGER COUNT, DATATYPE, OP, ROOT, COMM, IERROR |
| [MPI_INIT](https://www.open-mpi.org/doc/v3.1/man3/MPI_Init.3.php) | int MPI_Init(int \*argc, char \***argv) | MPI_INIT(IERROR) <br> INTEGER IERROR |
| [MPI_COMM_SIZE](https://www.open-mpi.org/doc/v3.1/man3/MPI_Comm_size.3.php) | int MPI_Comm_size(MPI_Comm comm, int \*size) | MPI_COMM_SIZE(COMM, SIZE, IERROR) <br> INTEGER COMM, SIZE, IERROR |
| [MPI_COMM_RANK](https://www.open-mpi.org/doc/v3.1/man3/MPI_Comm_rank.3.php) | int MPI_Comm_rank(MPI_Comm comm, int \*rank) | MPI_COMM_RANK(COMM, RANK, IERROR) <br> INTEGER COMM, RANK, IERROR |
| [MPI_FINALIZE](https://www.open-mpi.org/doc/v3.1/man3/MPI_Finalize.3.php) | int MPI_Finalize(void) | MPI_FINALIZE(IERROR) <br> INTEGER IERROR |
| [MPI_WTIME](https://www.open-mpi.org/doc/v3.1/man3/MPI_Wtime.3.php) | double MPI_Wtime(void) | MPI_WTIME() |
