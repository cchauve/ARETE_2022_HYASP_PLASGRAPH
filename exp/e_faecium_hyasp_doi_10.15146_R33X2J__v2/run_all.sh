#!/bin/bash

source ../../home.sh
SAMPLES=`cat ${ARETE_MAY22_HOME}/data/e_faecium/e_faecium_id.txt`
mkdir -p scripts
for SAMPLE in ${SAMPLES}
do
    sed "s/SAMPLE_ID/${SAMPLE}/g" run_template.sh > scripts/run_${SAMPLE}.sh
    sbatch scripts/run_${SAMPLE}.sh
done
