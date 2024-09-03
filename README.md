# Gene prediction

Pipelines developed to predict genes from draft genomes. <br /> <br /> <br /> 



# coding-exon-prediction


When using a reference sequence from a close relative:<br /> <br /> <br /> 


`coding_exon_prediction.sh`  will predict coding-exons (and the full orf of the gene) based on a protein reference using the protein2genome model in `Exonerate`. All predictions are translated using `transeq(EMBOSS)` and the longest open reading frames identified using `longest_orf.py` (see Sequence-tools) <br /> <br /> <br /> 

  
      Usage: ./coding_exon_prediction.sh  [dir_list.txt]  [protein_query.fasta]  [best_n_hits]  [masked_query(Y/N)]  [trans_table(standard=1)]  [gene_id]



Requires:
* `Exonerate` (tested on v2.2.0)
* `Transeq(EMBOSS)` (tested on EMBOSS 6.6.6)
* `longest_orf.py` (see Sequence-tools repository)



<br /> <br /> <br /> 


## hmm_to_fasta

When using reference sequences from more distantly related species: <br /> <br /> <br /> 


hmm.sh is a pipeline that builds an hmm profile from a nucleotide or protein query multi-fasta file then searches through a target genome and
using `nhmmer_or_hmmsearch_to_fasta.py` (see Sequence-tools) returns the top hit sequence.<br /> <br /> <br /> 


      Usage: ./hmm.sh  query.fasta  target.fasta  P/N  id



Requires:
* `HMMER` (tested with v3.1)
* `nhmmer_or_hmmsearch_to_fasta.py`



