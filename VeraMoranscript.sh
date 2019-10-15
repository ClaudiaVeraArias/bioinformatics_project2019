# Usage: bash VeraMoranscript.sh <outputname>

# This is a script to take all ref files and add to one file

for file in *.fasta
do
    cat $file >> $1.fasta
done

# This script will take our fasta files and run them through muscle

~/Private/programs/muscle -in $1.fasta -out $1.afa
rm $1.fasta

# This script will take our files and run through hmmr

~/Private/programs/hmmer-3.2/bin/hmmbuild $1.hmm $1.afa

#for proteome in *.fasta
#do
#    ~/Private/programs/hmmer-3.2/bin/hmmsearch -o output.txt $1.hmm $proteome
#    cat output.txt | grep 'target sequence' |
#done



