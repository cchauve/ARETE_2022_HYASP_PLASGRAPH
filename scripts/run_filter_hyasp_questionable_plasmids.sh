#!/bin/bash

./filter_hyasp_questionable_plasmids.sh ../exp/e_coli_hyasp_doi_10.15146_R33X2J__v2/ ../data/e_coli/e_coli_id.txt
./filter_hyasp_questionable_plasmids.sh ../exp/e_coli_hyasp_ncbi/ ../data/e_coli/e_coli_id.txt
./filter_hyasp_questionable_plasmids.sh ../exp/e_faecium_hyasp_ncbi/ ../data/e_faecium/e_faecium_id.txt
./filter_hyasp_questionable_plasmids.sh ../exp/e_faecium_hyasp_doi_10.15146_R33X2J__v2/ ../data/e_faecium/e_faecium_id.txt
