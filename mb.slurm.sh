#!/bin/bash -l

#SBATCH -A ACCOUNTID
#SBATCH -J mb
#SBATCH -t 1-10:00:00
#SBATCH -p node
#SBATCH -n 16

# Slurm script example for running MrBayes in parallel
#
# Important is to
# 1. Change ACCOUNTID to your SNIC compute account ID
# 2. Adjust the max time (DAYS-HOURS:MINUTES:SECONDS)
# 3. Check that number of nodes matches the number of chains in mb.nex
#
# Start by using
#     sbatch mb.slurm.sh
# Stop by using
#     scancel 1234
#     scancel -i -u $USER
#     scancel --state=pending -u $USER
# Monitor by using
#    jobinfo -u $USER
#    squeue

# Load modules
module load bioinfo-tools
module load mrbayes/3.2.6-mpi

# Copy the files used in the analysis to $SNIC_TMP
cp /path/to/folder/*.nex $SNIC_TMP
cd $SNIC_TMP

# Run the program
mpirun mb mb.nex

# Copy the results back to the network file system
cp $SNIC_TMP/* /path/to/folder/

