#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --account=def-chauvec

# To edit to go into the directory where you want to install the environment
cd /home/chauvec/projects/ctb-chauvec/PLASMIDS/ARETE_MAY22

module load python/3
python3 -m venv --system-site-packages ./plasgraph_env
source ./plasgraph_env/bin/activate

pip install networkx==2.6.3
pip install pandas==1.4.0
pip install numpy==1.22.2
pip install scikit-learn==0.23.1
pip install biopython==1.79
pip install matplotlib==3.5.1
pip install --no-index tensorflow==2.8
pip install spektral==1.0.8

mkdir -p tools
cd tools/
git clone https://github.com/cchauve/plASgraph.git

deactivate
