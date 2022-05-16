# ARETE All Hands Meeting May 2022
### Software Demo: HyAsP and plASgraph
### <a href="https://cchauve.github.io/">Cedric Chauve</a>, Simon Fraser University

This repo contains the data to run all experiments.

The directory [doi_10.15146_R33X2J__v2/](doi_10.15146_R33X2J__v2/)
contains the list of GenBank accession numbers for one of the two
plasmid databases used by HyAsP.

Each of the directories [c_freundii](c_freundii), [e_coli](e_coli) and
[e_faecium](e_faecium) contains the short-reads assembly graphs, list
of samples ID and ground truth labelling for short-reads contigs (of
size >100bp) for a set of species-specific samples.

For each species `SPECIES`,
- the file `SPECIES/SPECIES_id.txt` contains the list of samples ID,
- the directory `SPECIES/assembly_graphs/` contains the gzipped assembly graphs, one file `SAMPLE_ID.gfa.gz` per sample; the GFA format is described in <a href="http://gfa-spec.github.io/GFA-spec/GFA1.html">GFA-spec</a>.
- the directory `SPECIES/ground_truth/` contain the ground truth labelling files, one file `SAMPLE_ID_minimap_alignment_labelled_ambiguity_cutoff_1.csv` per sample.

For a given sample, the ground truth labelling file contains, for each
short-reads contig, the hybrid long/short-read contigs it maps to and
the label of the short reads contig (chromosome, plasmid, ambiguous,
no_label).