#!/bin/bash

ARETE_MAY22_HOME=/home/cchauve/projects/ctb-chauvec/PLASMIDS/ARETE_2022_HYASP_PLASGRAPH

module load python/3

python3 ../../scripts/eval_plasgraph.py ${ARETE_MAY22_HOME} c_freundii
