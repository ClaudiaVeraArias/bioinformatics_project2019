# This is a script to take all ref files and add to one file

for file in mcrAgene_*.fasta
do
    cat $file >> mcrAref.fasta
done
