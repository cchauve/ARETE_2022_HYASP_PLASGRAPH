# ARETE All Hands Meeting May 2022
### Software Demo: HyAsP and plASgraph
### <a href="https://cchauve.github.io/">Cedric Chauve</a>, Simon Fraser University

This repo contains all the experiments:
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