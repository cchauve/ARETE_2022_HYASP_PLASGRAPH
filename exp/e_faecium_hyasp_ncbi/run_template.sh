#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/

source ${HYASP_ENV_HOME}/bin/activate
module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Reference database
REF=${ARETE_MAY22_HOME}/exp/ncbi_database/ncbi_database_genes.fasta
# Sample assembly graph
GFA=${ARETE_MAY22_HOME}/data/e_faecium/assembly_graphs/SAMPLE_ID_assembly.gfa
gunzip ${GFA}.gz
# Output directory
OUT=${ARETE_MAY22_HOME}/exp/e_faecium_hyasp_ncbi/results/SAMPLE_ID

mkdir -p ${OUT}
cd       ${OUT}

hyasp map    ${REF}        SAMPLE_ID_gcm.csv -g ${GFA}                  > SAMPLE_ID_log_map.txt
hyasp filter ${REF}        SAMPLE_ID_gcm.csv SAMPLE_ID_filtered_gcm.csv > SAMPLE_ID_log_filter.txt
hyasp find   ${GFA} ${REF} SAMPLE_ID_filtered_gcm.csv ./                > SAMPLE_ID_log_find.txt

gzip ${GFA}
