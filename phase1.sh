for file in $@/*.fasta
do
   cat $file >> $@.fasta
done
