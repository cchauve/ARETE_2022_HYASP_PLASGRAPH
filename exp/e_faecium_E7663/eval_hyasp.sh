#!/bin/bash

# Experiments home directory
source ../../home.sh
EXP_DIR=${ARETE_MAY22_HOME}/exp/e_faecium_E7663/
EVAL_DIR=${ARETE_MAY22_HOME}/scripts/
OUT_DIR=${EXP_DIR}/hyasp_eval/

PRED_FILE_1=${EXP_DIR}/hyasp_output_1/contig_chains_putative.csv
gunzip ${PRED_FILE_1}.gz
PRED_FILE_2=${EXP_DIR}/hyasp_output_2/contig_chains_putative.csv
gunzip ${PRED_FILE_2}.gz
GROUND_TRUTH_FILE=${EXP_DIR}/E7663_ground_truth.csv

cd ${EVAL_DIR}
python evaluate_sample.py --pred ${PRED_FILE_1} --map ${GROUND_TRUTH_FILE} --out ${OUT_DIR} --res E7663_hyasp_eval_1 --amb 1 --ori 1
python evaluate_sample.py --pred ${PRED_FILE_2} --map ${GROUND_TRUTH_FILE} --out ${OUT_DIR} --res E7663_hyasp_eval_2 --amb 1 --ori 1

gzip ${PRED_FILE_1}
gzip ${PRED_FILE_2}
