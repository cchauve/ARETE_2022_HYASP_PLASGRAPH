#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

source /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22/hyasp_env/bin/activate

module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0 mash

mob_init

# Fixing apparentbug
makeblastdb -in /project/6069942/PLASMIDS/ARETE_MAY22/hyasp_env/lib/python3.6/site-packages/mob_suite-3.0.3-py3.6.egg/mob_suite/databases/rep.dna.fas -dbtype nucl
makeblastdb -in /project/6069942/PLASMIDS/ARETE_MAY22/hyasp_env/lib/python3.6/site-packages/mob_suite-3.0.3-py3.6.egg/mob_suite/databases/orit.fas -dbtype nucl

