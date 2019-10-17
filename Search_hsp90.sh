#search matches with hsp90HMM

for file in proteome*.fasta
do
/afs/crc.nd.edu/user/c/cvera/Private/programs/hmmer-3.2.1/bin/hmmsearch hsp90HMM $file >> Search_hsp90.txt
done
