#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

source ../../home.sh

# Virtual environment home directory
HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/
source ${HYASP_ENV_HOME}/bin/activate

module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Input
EXP_DIR=${ARETE_MAY22_HOME}/exp/e_faecium_E7663/
mkdir -p ${EXP_DIR}/hyasp_output_1 ${EXP_DIR}/hyasp_output_2
INPUT=${EXP_DIR}/E7663.gfa
gunzip ${INPUT}.gz
SCRIPTS_DIR=${ARETE_MAY22_HOME}/scripts

rm -f ${EXP_DIR}/hyasp_output_1/*
rm -f ${EXP_DIR}/hyasp_output_2/*

# Using a first reference database
REF1=${ARETE_MAY22_HOME}/exp/doi_10.15146_R33X2J__v2/doi_10.15146_R33X2J__v2_genes.fasta
hyasp map             ${REF1} -g ${INPUT} ${EXP_DIR}/hyasp_output_1/E7663_1_gcm.csv 
hyasp filter          ${REF1}             ${EXP_DIR}/hyasp_output_1/E7663_1_gcm.csv ${EXP_DIR}/hyasp_output_1/E7663_1_filtered_gcm.csv
hyasp find   ${INPUT} ${REF1}             ${EXP_DIR}/hyasp_output_1/E7663_1_filtered_gcm.csv ${EXP_DIR}/hyasp_output_1/
python ${SCRIPTS_DIR}/filter_hyasp_questionable_plasmids.py ./hyasp_output_1/

# Using an alternate database
REF2=${ARETE_MAY22_HOME}/exp/ncbi_database/ncbi_database_genes.fasta
hyasp map             ${REF2} -g ${INPUT} ${EXP_DIR}/hyasp_output_2/E7663_2_gcm.csv 
hyasp filter          ${REF2}             ${EXP_DIR}/hyasp_output_2/E7663_2_gcm.csv ${EXP_DIR}/hyasp_output_2/E7663_2_filtered_gcm.csv
hyasp find   ${INPUT} ${REF2}             ${EXP_DIR}/hyasp_output_2/E7663_2_filtered_gcm.csv ${EXP_DIR}/hyasp_output_2/
python ${SCRIPTS_DIR}/filter_hyasp_questionable_plasmids.py ./hyasp_output_2/

gzip ${INPUT}
gzip ${EXP_DIR}/hyasp_output_1/*
gzip ${EXP_DIR}/hyasp_output_2/*

deactivate
