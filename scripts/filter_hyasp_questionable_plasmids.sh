#!/bin/bash

EXP_DIR=$1
DATA_ID=`cat $2`

for ID in ${DATA_ID}
do
    python3 filter_hyasp_questionable_plasmids.py ${EXP_DIR}/results/${ID}/
done
