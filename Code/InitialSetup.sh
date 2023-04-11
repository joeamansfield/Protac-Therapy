#!/bin/bash

#SBATCH --time=99:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=5069M   # memory per CPU core
#SBATCH -J "Run all"   # job name
#SBATCH --mail-user=david.gstone42@gmail.com   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd ../ProcessedData/packageManaging/
conda env create -f environment.yml
conda env create -f pymolEnv.yml
conda env create -f volcanoEnv.yml
cd ../../Code/

# conda create -y -n E3v1
# source activate E3v1
# conda install -c bioconda snakemake -y
# conda install -c bioconda cptac -y
# conda deactivate

# conda create -y -n pymolv1
# source activate pymolv1
# conda install -c schrodinger pymol-bundle -y
# conda deactivate

# conda create -y -n gridv1
# source activate gridv1
# conda install -c bioconda grid -y
# conda install -c conda-forge r-janitor -y
# conda deactivate

# conda create -y -n volcanov1
# source activate volcanov1
# conda install -c conda-forge r-tidyverse -y
# conda install -c conda-forge r-ggrepel -y
# conda install -c conda-forge r-viridis -y
# conda install -c conda-forge r-data.table -y
# conda deactivate