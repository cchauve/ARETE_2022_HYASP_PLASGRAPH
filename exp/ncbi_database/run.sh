#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --account=def-chauvec
#SBATCH --mem=8G
source /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/hyasp_env/bin/activate 
cd /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/exp/ncbi_database
hyasp create ncbi_database_genes.fasta -p plasmids.csv -k ncbi_database_plasmids.fa -b ncbi_blacklist.txt -d -l 500 -m 100 -t GenBank -v  > log_2022-05-04_1.txt
