#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

source ../home.sh

module load python/3
python3 -m venv --system-site-packages ${ARETE_MAY22_HOME}/hyasp_env
source ${ARETE_MAY22_HOME}/hyasp_env/bin/activate

module load StdEnv/2020  gcc/9.3.0 blast+/2.12.0

pip install numpy
pip install pandas
pip install biopython

mkdir -p ${ARETE_MAY22_HOME}/tools
cd ${ARETE_MAY22_HOME}/tools/
git clone https://github.com/cchauve/hyasp.git
cd hyasp
python setup.py sdist
pip install dist/HyAsP-1.0.0.tar.gz

deactivate
