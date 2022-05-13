#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

# Experiments home directory
ARETE_MAY22_HOME=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/

# Virtual environment home directory
HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/
source ${HYASP_ENV_HOME}/bin/activate
# Not included initially in python virtual environment
module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Input
EXP_DIR=${ARETE_MAY22_HOME}/exp/e_faecium_E7663/
mkdir -p ${EXP_DIR}/hyasp_output_1 ${EXP_DIR}/hyasp_output_2
INPUT=${EXP_DIR}/E7663.gfa
gunzip ${INPUT}.gz

# Mapping contigs against the reference plasmid genes database
REF1=${ARETE_MAY22_HOME}/exp/doi_10.15146_R33X2J__v2/doi_10.15146_R33X2J__v2_genes.fasta
hyasp map    ${REF1}  -g ${INPUT} ${EXP_DIR}/hyasp_output_1/E7663_1_gcm.csv 
hyasp filter ${REF1}  ${EXP_DIR}/hyasp_output_1/E7663_1_gcm.csv ${EXP_DIR}/hyasp_output_1/E7663_1_filtered_gcm.csv
# Compute plasmid bins
hyasp find  ${INPUT} ${REF1} ${EXP_DIR}/hyasp_output_1/E7663_1_filtered_gcm.csv ${EXP_DIR}/hyasp_output_1/

# Using an alternate database
REF2=${ARETE_MAY22_HOME}/exp/ncbi_database/ncbi_database_genes.fasta
hyasp map    ${REF1}  -g ${INPUT}                            ${EXP_DIR}/hyasp_output_2/E7663_1_gcm.csv 
hyasp filter ${REF1}  ${EXP_DIR}/hyasp_output_2/E7663_1_gcm.csv    ${EXP_DIR}/hyasp_output_2/E7663_1_filtered_gcm.csv
hyasp find  ${INPUT} ${REF1} ${EXP_DIR}/hyasp_output_1/E7663_1_filtered_gcm.csv ${EXP_DIR}/hyasp_output_2/

rm assembly.fasta contigs_blast*
gzip ${INPUT}
gzip ${EXP_DIR}/hyasp_output_1/*
gzip ${EXP_DIR}/hyasp_output_2/*
