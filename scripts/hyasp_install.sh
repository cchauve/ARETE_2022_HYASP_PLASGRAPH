#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

source ../home.sh
cd ${ARETE_MAY22_HOME}

module load python/3
python3 -m venv --system-site-packages ./hyasp_env
source ./hyasp_env/bin/activate

pip install numpy
pip install pandas
pip install biopython

mkdir -p tools
cd tools/
git clone https://github.com/cchauve/hyasp.git
cd hyasp
python setup.py sdist
pip install dist/HyAsP-1.0.0.tar.gz

deactivate
