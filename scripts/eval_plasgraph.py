import sys
import os
import math
import matplotlib.pyplot as plt

HOME_DIR = sys.argv[1]
SPECIES = sys.argv[2]

# Read samples list
SAMPLES_ID_FILE = os.path.join(HOME_DIR,'data',SPECIES,f'{SPECIES}_id.txt')
SAMPLES_ID_DATA = open(SAMPLES_ID_FILE, 'r').readlines()
SAMPLES_ID_LIST = []
for sample_id in SAMPLES_ID_DATA:
    SAMPLES_ID_LIST.append(sample_id.rstrip())

PRECISION, RECALL, F1 = {}, {}, {}
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

fig, ax = plt.subplots(2,2,figsize=(20,20))
fig.suptitle('plASgraph accuracy', fontsize=30, fontweight='bold')
ax[0,0].scatter(CHR_X, CHR_Y, color='red', alpha=0.5, s=CHR_SIZE)
ax[0,0].axvline(0.5)
ax[0,0].axhline(0.5)
ax[0,0].set_title('Chromosomal contigs', fontsize=25)
ax[0,1].scatter(PLA_X, PLA_Y, color='green', alpha=0.5, s=4)
ax[0,1].axvline(0.5)
ax[0,1].axhline(0.5)
ax[0,1].set_title('Plasmid contigs', fontsize=25)
ax[1,0].scatter(AMB_X, AMB_Y, color='blue', alpha=0.5, s=4)
ax[1,0].axvline(0.5)
ax[1,0].axhline(0.5)
ax[1,0].set_title('Ambiguous contigs', fontsize=25)
ax[1,1].scatter(NOL_X, NOL_Y, color='black', alpha=0.5, s=4)
ax[1,1].axvline(0.5)
ax[1,1].axhline(0.5)
ax[1,1].set_title('Unlabelled contigs', fontsize=25)
fig.add_subplot(1, 1, 1, frame_on=False)
plt.tick_params(labelcolor="none", bottom=False, left=False)
plt.xlabel('chromosome score', fontsize=25, fontweight='bold')
plt.ylabel('plasmid score', fontsize=25, fontweight='bold')
plt.savefig(f'{SPECIES}_plasgraph_accuracy.png')
