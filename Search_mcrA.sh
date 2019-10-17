#search matches with mcrAHMM

for file in proteome*.fasta
do
/afs/crc.nd.edu/user/c/cvera/Private/programs/hmmer-3.2.1/bin/hmmsearch mcrArefHMM $file >> Search_mcrA.txt
done
