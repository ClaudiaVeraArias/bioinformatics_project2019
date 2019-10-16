# Usage: bash VeraMoranscript.sh <refdirectory> no slash

# This is a script to take all ref files and add to one file

for file in $@/*.fasta
do
    cat $file >> $@.fasta
done

# This script will take our fasta files and run them through muscle

~/Private/programs/muscle -in $@.fasta -out $@.afa
rm $@.fasta

# This script will take our files and run through hmmr

~/Private/programs/hmmer-3.2/bin/hmmbuild $@.hmm $@.afa

# This part needs to run each proteome through
# the hmmsearch and then pull out each alignment

# We need a summary table collating the results of all searches


#for proteome in *.fasta
#do
#    ~/Private/programs/hmmer-3.2/bin/hmmsearch -o output.txt $1.hmm $proteome
#    cat output.txt | grep 'target sequence' | cut -f 9 -d ' ' >> Columns.txt
#done



