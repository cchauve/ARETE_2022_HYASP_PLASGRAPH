#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

source /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/hyasp_env/bin/activate

module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

# Reference database
REF=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/exp/ncbi_database/ncbi_database_genes.fasta
# Sample assembly graph
GFA=/home/chauvec/projects/ctb-chauvec/jsiele/results/e_faecium/unicycler_short_read_assembly/SAMPLE_ID_assembly/assembly.gfa
# Output directory
OUT=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/exp/e_faecium_hyasp_doi_10.15146_R33X2J__v2/results/SAMPLE_ID

mkdir -p ${OUT}
cd       ${OUT}

hyasp map    ${REF}        SAMPLE_ID_gcm.csv -g ${GFA}                  > SAMPLE_ID_log_map.txt
hyasp filter ${REF}        SAMPLE_ID_gcm.csv SAMPLE_ID_filtered_gcm.csv > SAMPLE_ID_log_filter.txt
hyasp find   ${GFA} ${REF} SAMPLE_ID_filtered_gcm.csv ./                > SAMPLE_ID_log_find.txt
