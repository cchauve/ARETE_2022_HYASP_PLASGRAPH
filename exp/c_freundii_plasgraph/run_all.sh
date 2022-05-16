#!/bin/bash

source ../../home.sh

SAMPLES=`cat ${ARETE_MAY22_HOME}/data/c_freundii/c_freundii_id.txt`
for SAMPLE in ${SAMPLES}
do
    sed "s/SAMPLE_ID/${SAMPLE}/g" run_template.sh > scripts/run_${SAMPLE}.sh
    sbatch scripts/run_${SAMPLE}.sh
done
