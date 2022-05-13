import sys
import os

DATA_DIR = sys.argv[1]
ALL_CHAINS_FILE = os.path.join(DATA_DIR, 'contig_chains.csv')
PUTATIVE_CHAINS_FILE = os.path.join(DATA_DIR, 'contig_chains_putative.csv')
QUESTIONABLE_PLASMIDS_FILE = os.path.join(DATA_DIR, 'questionable_plasmid_contigs.fasta')

# Read questionable plasmids ID
QUESTIONABLE_PLASMIDS_LIST = []
QUESTIONABLE_PLASMIDS_DATA = open(QUESTIONABLE_PLASMIDS_FILE, 'r').readlines()
for contig in QUESTIONABLE_PLASMIDS_DATA:
    if contig[0] == '>':
        plasmid_id = '_'.join(contig.split('|')[1].split('_')[1:]).rstrip()
        if plasmid_id not in QUESTIONABLE_PLASMIDS_LIST:
            QUESTIONABLE_PLASMIDS_LIST.append(plasmid_id)

# Filter out questionable plasmids
PUTATIVE_CHAINS_DATA = open(PUTATIVE_CHAINS_FILE, 'w')
ALL_CHAINS_DATA = open(ALL_CHAINS_FILE, 'r').readlines()
for chain in ALL_CHAINS_DATA:
    plasmid_id = chain.split(';')[0]
    if plasmid_id not in QUESTIONABLE_PLASMIDS_LIST:
        PUTATIVE_CHAINS_DATA.write(chain)
