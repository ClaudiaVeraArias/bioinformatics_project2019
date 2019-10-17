#search matches with mcrAHMM

for file in proteome*.fasta
do
/afs/crc.nd.edu/user/c/cvera/Private/programs/hmmer-3.2.1/bin/hmmsearch mcrArefHMM $file >> Search_mcrA.txt
cat Search_hsp90.txt | egrep "^ {1,4}[0-9][.][0-9]*-?[0-9a-zA-Z]" Search_mcrA.txt > mcrAColumns.txt
done
