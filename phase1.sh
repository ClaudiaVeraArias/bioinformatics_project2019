# This is a script to take all ref files and add to one file

for file in hsp70gene_*.fasta
do
    cat $file >> hsp70ref.fasta
done
