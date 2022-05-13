#!/bin/bash

# Experiments home directory
ARETE_MAY22_HOME=/home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/
SPECIES=$1
ID_LIST=`cat ${ARETE_MAY22_HOME}/data/${SPECIES}/${SPECIES}_id.txt`

EXP_DIR_1=${ARETE_MAY22_HOME}/exp/${SPECIES}_hyasp_doi_10.15146_R33X2J__v2/
EXP_DIR_2=${ARETE_MAY22_HOME}/exp/${SPECIES}_hyasp_ncbi/

EVAL_DIR=${ARETE_MAY22_HOME}/scripts/
OUT_DIR=${ARETE_MAY22_HOME}/exp/hyasp_eval/${SPECIES}
mkdir -p ${OUT_DIR}

for ID in ${ID_LIST}
do
    PRED_FILE_1=${EXP_DIR_1}/results/${ID}/contig_chains_putative.csv
    PRED_FILE_2=${EXP_DIR_2}/results/${ID}/contig_chains_putative.csv
    GROUND_TRUTH_FILE=${ARETE_MAY22_HOME}/data/${SPECIES}/ground_truth/${ID}_minimap_alignment_labelled_ambiguity_cutoff_1.csv

    cd ${EVAL_DIR}
    python evaluate_sample.py --pred ${PRED_FILE_1} --map ${GROUND_TRUTH_FILE} --out ${OUT_DIR} --res ${ID}_doi_10.15146_R33X2J__v2.txt --amb 1 --ori 1
    python evaluate_sample.py --pred ${PRED_FILE_2} --map ${GROUND_TRUTH_FILE} --out ${OUT_DIR} --res ${ID}_ncbi.txt --amb 1 --ori 1
done

cd ${OUT_DIR}
cd ../
grep precision ${SPECIES}/* > ${SPECIES}_precision.txt
grep recall ${SPECIES}/* > ${SPECIES}_recall.txt
grep f1_score ${SPECIES}/* > ${SPECIES}_F1.txt
