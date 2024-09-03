#!/bin/bash
# set -e
dir_list="$1"
protein="$2"
bestn="$3"
mask="$4"
trans_table="$5"
id="$6"


###print out usage if asked by -h
if [ "$1" == "-h" ]; then
  echo "Usage: ./coding_exon_prediction.sh  [dir_list.txt]  [protein_query.fasta]  [best_n_hits]  [masked_query(Y/N)]  [trans_table(standard=1)]  [gene_id]"
  exit 0
fi

###Save current dir as variable path
path=$(pwd)

###Make an output dir
mkdir -p "$path"/"$id"

###if masked query then tell exonerate...else dont
if [ "$mask" == "Y" ];then
	while IFS= read -r file
	do
		for f in "$file"/*.fna;do
		exonerate --model protein2genome --query "$protein" --target "$path"/"$f" --softmaskquery yes \
	        --showalignment no --showvulgar no --showtargetgff yes --bestn "$bestn" \
	        --ryo "%qi(%qab - %qae)\n%qas\n >%ti(%tab - %tae)\n%tas\n >%ti\n%tcs\n" > "$path"/"$id"/"$f".exonerate;done
	done < "$dir_list"
else
	while IFS= read -r file
	do
        	for f in "$file"/*.fna;do
        	exonerate --model protein2genome --query "$protein" --target "$path"/"$f" \
		--showalignment no --showvulgar no --showtargetgff yes --bestn "$bestn" \
		--ryo "%qi(%qab - %qae)\n%qas\n >%ti(%tab - %tae)\n%tas\n >%ti\n%tcs\n" > "$path"/"$id"/"$f".exonerate;done
	done < "$dir_list"
fi

###Change to output dir
cd "$path"/"$id"

###Separate exonerate output
for f in *.exonerate; do extract_exonerate_output.py "$id" "$f"

###Translate predicted cds
for f in *excds*; do transeq -sequence "$f" -outseq "$f".frames -table "$trans_table" -frame 6;done

###Find longest orf
for f in *.frames; do longest_orf.py "$f" > "$f".prot.fasta; done

###Cat all predicted proteins in one mf file
cat *.prot.fasta > "$id"_all_prots.fasta



