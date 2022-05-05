#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --account=def-chauvec

source /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/hyasp_env/bin/activate

module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0 mash

# Sample contigs sequences
FASTA=/home/chauvec/projects/ctb-chauvec/jsiele/results/e_coli/short_read_assembly/SAMPLE_ID_assembly/assembly.fasta
# Output directory
OUT=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/exp/e_coli_mob/results/SAMPLE_ID

mkdir -p ${OUT}
cd       ${OUT}

mob_recon -i ${FASTA} -o ./
