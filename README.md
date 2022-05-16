# ARETE All Hands Meeting May 2022
## Software Demo: HyAsP and plASgraph
## <a href="https://cchauve.github.io/">Cedric Chauve</a>, Simon Fraser University

### Overview
This repo contains the material for the software demo presenting two tools:
- <a href="https://github.com/cchauve/HyAsP">HyAsP</a>, a plasmid contigs binning tool,
- <a href="https://github.com/cchauve/plAsGraph">plASgraph</a>, a plasmid contigs classification tool.

Both tools take as input the *assembly graph* of a bacterial sample, sequenced with Illumina short-reads.
- HyAsP is a greedy algorithm that computes groups of contigs (bins) assumed to originate from the same plasmid;
- plASgraph is a deep learning tool that computes for each contig (of length above 100bp) a chromosome score and a plasmid score and classifies each contig as
  - plasmid (plasmid score >0.5, chromosome score <=0.5),
  - chromosome (plasmid score <=0.5, chromosome score >0.5),
  - ambiguous (both scores >0.5),
  - no_label (both scores <=0.5).

HyAsP was evaluated on a set of **E. coli** and **E. faecium** samples.
PlASgraph was evaluated on a et of **C. freundii** samples.