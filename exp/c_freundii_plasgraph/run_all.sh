#!/bin/bash

SAMPLES=`cat /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/data/c_freundii/c_freundii_id.txt`

for SAMPLE in ${SAMPLES}
do
    sed "s/SAMPLE_ID/${SAMPLE}/g" run_template.sh > scripts/run_${SAMPLE}.sh
    sbatch scripts/run_${SAMPLE}.sh
done
