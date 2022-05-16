# ARETE All Hands Meeting May 2022
### Software Demo: HyAsP and plASgraph
### <a href="https://cchauve.github.io/">Cedric Chauve</a>, Simon Fraser University

This directory contains the list of GenBank accession numbers for one
of the two plasmid databases used by HyAsP.

This database is described in the paper <a href="https://doi.org/10.1128/MRA.01325-18"></a> (Microbiology Resource Announcements, 2019).

The data were downloaded on 2022-05-03 from <a href="https://datadryad.org/stash/dataset/doi:10.15146/R33X2J">Dryad: Plasmids database</a>.

Once the data were downloaded, the list of accession numbers was generated as follows:
```
unzip doi_10.15146_R33X2J__v2.zip
grep ">" All_plasmids.fna | sed 's/>//g' > doi_10.15146_R33X2J__v2_id.txt
```