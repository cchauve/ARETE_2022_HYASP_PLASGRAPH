#!/bin/bash
#SBATCH --gres=gpu:1 
#SBATCH --cpus-per-task=6 
#SBATCH --mem=32000M       
#SBATCH --time=1:00:00
#SBATCH --account=def-chauvec

source ../../home.sh

# Virtual environment home directory
PLASGRAPH_ENV_HOME=${ARETE_MAY22_HOME}/plasgraph_env
source ${PLASGRAPH_ENV_HOME}/bin/activate

# Going into the plasgraph directory
cd ${ARETE_MAY22_HOME}/tools/plASgraph

# Experiment directory
EXP_DIR=${ARETE_MAY22_HOME}/exp/c_freundii_plasgraph
# Input
DATA_DIR=${ARETE_MAY22_HOME}/data/c_freundii/assembly_graphs
mkdir -p ${EXP_DIR}/tmp
cp ${DATA_DIR}/SAMPLE_ID.gfa.gz ${EXP_DIR}/tmp
gunzip ${EXP_DIR}/tmp/SAMPLE_ID.gfa.gz
GFA=${EXP_DIR}/tmp/SAMPLE_ID.gfa

# Running plASgraph
OUT_DIR=${ARETE_MAY22_HOME}/exp/c_freundii_plasgraph/results/SAMPLE_ID
mkdir -p ${OUT_DIR}
python plASgraph.py -i ${GFA} -o ${OUT_DIR}/SAMPLE_ID_class.csv --draw_graph

rm ${GFA}
