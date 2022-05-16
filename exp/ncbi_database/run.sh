#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

source ../../home.sh

# Virtual environment home directory
HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/
source ${HYASP_ENV_HOME}/bin/activate

hyasp create ncbi_database_genes.fasta -p plasmids.csv -k ncbi_database_plasmids.fa -b ncbi_blacklist.txt -d -l 500 -m 100 -t GenBank -v  > log_2022-05-04_1.txt
