#!/bin/bash

source ../../home.sh

module load python/3

python3 ${ARETE_MAY22_HOME}/scripts/eval_plasgraph.py ${ARETE_MAY22_HOME} c_freundii
