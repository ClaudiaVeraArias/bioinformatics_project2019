# This is a script to take all ref files and add to one file

for file in mcrAgene_[0-9]{2}.fasta
do
    cat $file >> mcrAref.fasta
done
