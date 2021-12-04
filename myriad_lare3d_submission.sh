#!/bin/bash -l

# Batch script to run an MPI parallel job under SGE on UCL's cluster, Myriad

module load compilers/intel/2018/update3
module load mpi/intel/2018/update3/intel

#$ -l h_rt=47:59:0  # Wallclock time
#$ -N lare3d # Job name
#$ -pe mpi 36 # number of MPI processes
#$ -l mem=5G
#$ -cwd # Output to current working directory

data_dir=$(pwd)
echo "running directory: " $data_dir

# Run our MPI job.  GERun is a wrapper that launches MPI jobs on our clusters.
gerun bin/lare3d
