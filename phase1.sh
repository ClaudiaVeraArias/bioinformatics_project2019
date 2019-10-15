# This is a script to take all ref files and add to one file

for file in hsp70gene_[0-9]{2}.fasta
do
    cat $file >> hsp70ref.fasta
done
