# This is a script to take all ref files and add to one file

for file in hsp70gene_[0-9]{2}.fasta
do
    cat $file >> hsp70ref.fasta
done

# This script will take our fasta files and run them through muscle

~/Private/programs/muscle -in hsp70ref.fasta -out hsp70ref.afa

# This script will take our files and run through hmmr

~/Private/programs/hmmer-3.2/bin/hmmbuild hsp70ref.hmm hsp70ref.afa

~/Private/programs/hmmer-3.2/bin/hmmsearch hsp70ref.hmm hsp70ref.fa

