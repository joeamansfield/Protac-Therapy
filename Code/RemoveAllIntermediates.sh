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

rm ../Figures/VolcanoPlots/*
rm ../ProcessedData/pvalues/*
rm ../ProcessedData/E3List.txt
rm ../ProcessedData/sig_pairs/most_sig/*
rm ../ProcessedData/sig_pairs/val_protacs/*
rm ../ProcessedData/sig_pairs/potential_protacs/*
rm ../ProcessedData/E3Sub_pairs_full.txt
rm ../ProcessedData/existing_protacs.txt
rm ../ProcessedData/subset_data/*
rm ../ProcessedData/subset_list.txt
rm ../ProcessedData/targetProteinList.txt
rm ../ProcessedData/merged_types_validated.txt
rm ../ProcessedData/merged_types_potential.txt
rm ../ProcessedData/tieredpairs.tsv
rm ../ProcessedData/pymol/merged_types_uniprot.tsv
rm ../ProcessedData/pymol/protein_features_table.tsv
rm ../ProcessedData/pymol/uniprot_to_hugo_pot.tsv
rm ../ProcessedData/pymol/uniprot_to_hugo_val.tsv
rm ../ProcessedData/pymol/uniprot_to_hugo.tsv
rm ../ProcessedData/pymol/val_pdb.tsv
rm ../ProcessedData/pymol/val_uniprot.csv
rm ../ProcessedData/pymol/pdbfiles/*
rm ../ProcessedData/pymol/proteinFeatures/*/*