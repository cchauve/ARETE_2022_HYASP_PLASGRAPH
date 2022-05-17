#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

source ../../home.sh
HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/

source ${HYASP_ENV_HOME}/bin/activate
module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Experiment directory
EXP_DIR=${ARETE_MAY22_HOME}/exp/e_coli_hyasp_doi_10.15146_R33X2J__v2/
# Reference database
REF=${ARETE_MAY22_HOME}/exp/ncbi_database/ncbi_database_genes.fasta
# Sample assembly graph
mkdir -p ${EXP_DIR}/tmp
cp ${ARETE_MAY22_HOME}/data/e_coli/assembly_graphs/SAMPLE_ID.gfa.gz ${EXP_DIR}/tmp/
gunzip ${EXP_DIR}/tmp/SAMPLE_ID.gfa.gz
GFA=${EXP_DIR}/tmp/SAMPLE_ID.gfa
# Output directory
OUT_DIR=${EXP_DIR}/results/SAMPLE_ID

mkdir -p ${OUT_DIR}
cd       ${OUT_DIR}

hyasp map    ${REF}        SAMPLE_ID_gcm.csv -g ${GFA}                  > SAMPLE_ID_log_map.txt
hyasp filter ${REF}        SAMPLE_ID_gcm.csv SAMPLE_ID_filtered_gcm.csv > SAMPLE_ID_log_filter.txt
hyasp find   ${GFA} ${REF} SAMPLE_ID_filtered_gcm.csv ./                > SAMPLE_ID_log_find.txt
SCRIPTS_DIR=${ARETE_MAY22_HOME}/scripts
python ${SCRIPTS_DIR}/filter_hyasp_questionable_plasmids.py ${OUT_DIR}

rm ${GFA}
