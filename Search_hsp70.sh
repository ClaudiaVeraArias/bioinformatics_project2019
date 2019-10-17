#search matches with hsp90HMM

for file in proteome*.fasta
do
/afs/crc.nd.edu/user/c/cvera/Private/programs/hmmer-3.2.1/bin/hmmsearch hsp90HMM $file >> Search_hsp90.txt
cat Search_hsp90.txt | egrep "^ {1,4}[0-9][.][0-9]*-?[0-9a-zA-Z]" Search_hsp90.txt > hsp90Columns.txt
done
