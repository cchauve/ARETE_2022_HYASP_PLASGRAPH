#!/bin/bash
#SBATCH --gres=gpu:1 
#SBATCH --cpus-per-task=6 
#SBATCH --mem=32000M       
#SBATCH --time=1:00:00
#SBATCH --account=def-chauvec

# Experiments home directory
ARETE_MAY22_HOME=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/

# Virtual environment home directory
PLASGRAPH_ENV_HOME=${ARETE_MAY22_HOME}/plasgraph_env
source ${PLASGRAPH_ENV_HOME}/bin/activate

# Going into the plasgraph directory
cd ${ARETE_MAY22_HOME}/tools/plASgraph

# Input
EXP_DIR=${ARETE_MAY22_HOME}/exp/e_faecium_E7663/
mkdir -p ${EXP_DIR}/plasgraph_output/
INPUT=${EXP_DIR}/E7663.gfa
gunzip ${INPUT}.gz

# Running plASgraph
python plASgraph.py -i ${INPUT} -o ${EXP_DIR}/plasgraph_output/E7663_class.csv --draw_graph

gzip ${INPUT}
