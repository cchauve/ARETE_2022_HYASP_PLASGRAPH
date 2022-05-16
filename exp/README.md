# ARETE All Hands Meeting May 2022
### Software Demo: HyAsP and plASgraph
### <a href="https://cchauve.github.io/">Cedric Chauve</a>, Simon Fraser University


## Overview
This repo contains all the experiments and their results:
- [doi_10.15146_R33X2J__v21](doi_10.15146_R33X2J__v21): building the HyAsP plasmid reference database
  based on the data described in [../data/doi_10.15146_R33X2J__v2/](../data/doi_10.15146_R33X2J__v2/).
- [ncbi_database](ncbi_database): building the HyAsP plasmid reference database based on
  the HyAsP list of plasmids [ncbi_database/plasmids.csv](ncbi_database/plasmids.csv)
- [e_faecium_E7663](e_faecium_E7663): running HyAsP and plASgraph on a single *E. faecium* sample, with
  sample data in the directory.
- [e_coli_hyasp_doi_10.15146_R33X2J__v2](e_coli_hyasp_doi_10.15146_R33X2J__v2)
  and
  [e_coli_hyasp_ncbi](e_coli_hyasp_ncbi):
  analysis of *E. coli* samples with HyAsP, using the two different
  plasmid reference databases.
- [e_faecium_hyasp_doi_10.15146_R33X2J__v2](e_faecium_hyasp_doi_10.15146_R33X2J__v2)
  and
  [e_faecium_hyasp_ncbi](e_faecium_hyasp_ncbi):
  analysis of *E. faecium* samples with HyAsP, using the two different
  plasmid reference databases.
- [hyasp_eval](hyasp_eval): generating statistics and plots for the resultrs of HyAsP.
- [c_freundii_plasgraph](c_freundii_plasgraph): running plASgraph, with its default trained
  model on *C. freundii* data.

## Running HyAsP

In each HyAsP experiment directory, the results can be reproduced by running the script `run_all.sh`.

For a given sample `SAMPLE_ID`, the results are available in the subdirectory `results/SAMPLE_ID`.
The repo contains four files:
- `contig_chains.csv` contains all plasmid bins (putative and questionable);
- `contig_chains_putative.csv` contains all putative plasmid bins;
- A bin is described as an ordered list of oriented contig IDs, one bin per line;
- `SAMPLE_ID_filtered_gcm.csv` contains all considered hits of the sample contigs against the reference database;
- `putative_plasmid_contigs.fasta` contains the original short-read contigs, with a header augmented by the plasmid bin they belong to and their position in this bin;
- `putative_plasmids.fasta` contains the sequence defined by concatenating all contigs in each bin into a single sequence.

## HyAsP evaluation

For each species `SPECIES` (*E. coli* or *E. faecium*) the precision, recall and F1-score for each sample are recorded
in the files `hyasp_eval/SPECIES_[precision,recall,F1].txt`, for the experiment with each of the two databases.  

The figures suffixed by `dist.png` show the distribution for all theses statistics.

The figures suffixed by `comp.png` show scatterplots of the statistic values with both databases.

All these results can be reproduced by running [hyasp_eval/run_all.sh](hyasp_eval/run_all.sh).

## Running plASgraph

The plASgraph experiment can be reproduced by running [c_freundii_plasgraph/run_all.sh](c_freundii_plasgraph/run_all.sh).

For a given sample `SAMPLE_ID`, the results are available in the subdirectory `results/SAMPLE_ID`. It contains two files:
- `SAMPLE_ID__class.csv` contains, for each contig, both its plasmid and chromosome scores and the class the contig is assigned to.
- `SAMPLE_ID__class_graph.png` contains a picture of the assembly graph with contigs colored according to their predicted class.

The scatterplot figures of the contigs scores are available in the files `c_freundii_plasgraph_accuracy_[ambiguous,chromosome,no_label,plasmid].png` and can be reproduced by running [c_freundii_plasgraph/run_eval.sh](c_freundii_plasgraph/run_eval.sh).