#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

# Experiments home directory
ARETE_MAY22_HOME=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/
cd ${ARETE_MAY22_HOME}/exp/e_faecium_E7663/

# Virtual environment home directory
HYASP_ENV=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/
source ${HYASP_ENV_HOME}/hyasp_env/bin/activate
# Not included initially in python virtual environment
module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Input
gunzip E7663.gfa.gz
INPUT=E7663.gfa

# Mapping contigs against the reference plasmid genes database
REF1=../doi_10.15146_R33X2J__v2/doi_10.15146_R33X2J__v2_genes.fasta
hyasp map    ${REF1}  -g ${INPUT}        E7663_1_gcm.csv 
hyasp filter ${REF1}  E7663_1_gcm.csv    E7663_1_filtered_gcm.csv
# Compute plasmid bins
hyasp find  ${INPUT} ${REF1} E7663_1_filtered_gcm.csv ./output_1

# Using an alternate database
REF2=../ncbi_database/ncbi_database_genes.fasta
hyasp map    ${REF2}  -g ${INPUT}        E7663_2_gcm.csv 
hyasp filter ${REF2}  E7663_2_gcm.csv    E7663_2_filtered_gcm.csv
hyasp find  ${INPUT} ${REF2} E7663_2_filtered_gcm.csv ./output_2

rm assembly.fasta contigs_blast*
gzip E7663*
gzip output_*/*
