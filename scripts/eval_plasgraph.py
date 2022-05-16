import sys
import os
import math
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

HOME_DIR = sys.argv[1]
SPECIES = sys.argv[2]

# Read samples list
SAMPLES_ID_FILE = os.path.join(HOME_DIR,'data',SPECIES,f'{SPECIES}_id.txt')
SAMPLES_ID_DATA = open(SAMPLES_ID_FILE, 'r').readlines()
SAMPLES_ID_LIST = []
for sample_id in SAMPLES_ID_DATA:
    SAMPLES_ID_LIST.append(sample_id.rstrip())

CLASS_CTG, LABELS_CTG, LEN_CTG = {}, {}, {}

def read_classification_file(CLASS_DATA):
    result = {}
    for ctg_class in CLASS_DATA:
        ctg_class_split = ctg_class.split(',')
        if ctg_class_split[0] != 'contig_name':
            ctg_id = ctg_class_split[0]
            pla_score = float(ctg_class_split[1])
            chr_score = float(ctg_class_split[2])
            result[ctg_id] = (chr_score, pla_score)
    return(result)

DATA_ALL = {'chromosome': [], 'plasmid': [], 'ambiguous': [], 'no_label': []}
LEN_ALL = {'chromosome': [], 'plasmid': [], 'ambiguous': [], 'no_label': []}

NB_CTG = 0

for sample_id in SAMPLES_ID_LIST:
    # Read classifcation file
    CLASS_FILE = os.path.join(HOME_DIR, 'exp', f'{SPECIES}_plasgraph', 'results', sample_id, f'{sample_id}_class.csv')
    CLASS_DATA = open(CLASS_FILE, 'r').readlines()
    CLASS_CTG[sample_id] = read_classification_file(CLASS_DATA)
    # Read ground truth
    GT_FILE = os.path.join(HOME_DIR,'data',SPECIES,'ground_truth', f'{sample_id}_minimap_alignment_labelled_ambiguity_cutoff_1.csv')
    GT_DATA = open(GT_FILE, 'r').readlines()
    LABELS_CTG[sample_id], LEN_CTG[sample_id] = {}, {}
    for chrom in GT_DATA:
        ctg_id = chrom.split(',')[0]
        if ctg_id != 'short_read_contig_id':
            ctg_len = int(chrom.split(',')[1])
            LEN_CTG[sample_id][ctg_id] = ctg_len
        ctg_label = chrom.rstrip().split(',')[6]
        if ctg_id in CLASS_CTG[sample_id].keys():
            LABELS_CTG[sample_id][ctg_id] = ctg_label
    for ctg_id in LABELS_CTG[sample_id].keys():
        (chr_score, pla_score) = CLASS_CTG[sample_id][ctg_id]
        ctg_label = LABELS_CTG[sample_id][ctg_id]
        DATA_ALL[ctg_label].append((chr_score, pla_score))
        LEN_ALL[ctg_label].append(LEN_CTG[sample_id][ctg_id])
        NB_CTG += 1

NB_SAMPLES = len(SAMPLES_ID_LIST)
        
CHR_X = [x[0] for x in DATA_ALL['chromosome']]
PLA_X = [x[0] for x in DATA_ALL['plasmid']]
AMB_X = [x[0] for x in DATA_ALL['ambiguous']]
NOL_X = [x[0] for x in DATA_ALL['no_label']]
CHR_Y = [x[1] for x in DATA_ALL['chromosome']]
PLA_Y = [x[1] for x in DATA_ALL['plasmid']]
AMB_Y = [x[1] for x in DATA_ALL['ambiguous']]
NOL_Y = [x[1] for x in DATA_ALL['no_label']]
CHR_SIZE = [math.ceil(x/1000) for x in LEN_ALL['chromosome']]
PLA_SIZE = [math.ceil(x/1000) for x in LEN_ALL['plasmid']]
AMB_SIZE = [math.ceil(x/1000) for x in LEN_ALL['ambiguous']]
NOL_SIZE = [math.ceil(x/1000) for x in LEN_ALL['no_label']]

COLOR = {'chromosome': 'red', 'plasmid': 'green', 'ambiguous': 'blue', 'no_label': 'black'}

def create_fig_mpl(keyword):
    fig = plt.figure(figsize=(10,10))
    gs = GridSpec(4, 4)
    X = [x[0] for x in DATA_ALL[keyword]]
    Y = [x[1] for x in DATA_ALL[keyword]]
    S = [math.ceil(x/1000) for x in LEN_ALL[keyword]]
    ax_scatter = fig.add_subplot(gs[1:4, 0:3])
    ax_hist_x = fig.add_subplot(gs[0,0:3])
    ax_hist_y = fig.add_subplot(gs[1:4, 3])
    ax_scatter.scatter(X, Y, color=COLOR[keyword], alpha=0.5, s=S)
    ax_scatter.axvline(0.5)
    ax_scatter.axhline(0.5)
    ax_scatter.set_xlabel('chromosome score', fontsize=20)
    ax_scatter.set_ylabel('plasmid score', fontsize=20)
    plt.suptitle(f'plASgraph accuracy: {keyword} contigs', fontsize=25)
    ax_hist_x.hist(X, bins=20)
    ax_hist_y.hist(Y, bins=20, orientation = 'horizontal')   
    plt.savefig(f'{SPECIES}_plasgraph_accuracy_{keyword}.png')

create_fig_mpl('chromosome')
create_fig_mpl('plasmid')
create_fig_mpl('ambiguous')
create_fig_mpl('no_label')
