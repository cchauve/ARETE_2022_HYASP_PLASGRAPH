import sys
import os
import matplotlib.pyplot as plt

SPECIES=sys.argv[1]
STAT=sys.argv[2]

# Reading data
STATS_FILE = f'{SPECIES}_{STAT}.txt'
STATS_DATA = open(STATS_FILE, 'r').readlines()
STATS_DOI = {}
STATS_NCBI = {}
for stat in STATS_DATA:
    stat_value = float(stat.split()[1])
    if 'doi' in stat:
        sample_id = stat.split('/')[1].split('_doi')[0]
        STATS_DOI[sample_id] = stat_value
    elif 'ncbi' in stat:
        sample_id = stat.split('/')[1].split('_ncbi')[0]
        STATS_NCBI[sample_id] = stat_value
samples_list = list(STATS_DOI.keys())

X_DOI = [STATS_DOI[sample_id] for sample_id in samples_list]
X_NCBI = [STATS_NCBI[sample_id] for sample_id in samples_list]

plt.figure()
plt.scatter(X_DOI, X_NCBI, alpha=0.5)
ident = [0.0, 1.0]
plt.plot(ident,ident)
plt.title(f'{SPECIES} {STAT}')
plt.xlabel('R33X2J__v2')
plt.ylabel('NCBI')
plt.savefig(f'{SPECIES}_{STAT}_comp.png')

plt.figure()
plt.boxplot([X_DOI, X_NCBI])
plt.title(f'{SPECIES} {STAT}')
labels = ['R33X2J__v2', 'NCBI']
x = [1,2]
plt.xticks(x, labels)
plt.savefig(f'{SPECIES}_{STAT}_dist.png')
