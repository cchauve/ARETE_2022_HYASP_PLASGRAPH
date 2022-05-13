#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

# Experiments home directory
ARETE_MAY22_HOME=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/

# Virtual environment home directory
HYASP_ENV_HOME=${ARETE_MAY22_HOME}/hyasp_env/
source ${HYASP_ENV_HOME}/bin/activate

hyasp create doi_10.15146_R33X2J__v2_genes.fasta -a doi_10.15146_R33X2J__v2_id.txt -k doi_10.15146_R33X2J__v2_plasmids.fa -d -l 500 -m 100 -v 
