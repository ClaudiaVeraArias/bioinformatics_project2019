# Usage: bash VeraMoranscript.sh <refdirectory> no slash

# In order to use this script you need the
# following programs:
# muscle
# hmmer-3.2
# In your home directory you should place both programs
# within Private/programs/


## This is a script to take all ref files and add to one file
for file in $@
do
cat $file/* > refs.fasta

# This script will take our fasta files and run them through muscle

~/Private/programs/muscle -in refs.fasta -out $file.afa

# This script will take our files and run through hmmer

~/Private/programs/hmmer-3.2/bin/hmmbuild $file.hmm $file.afa

#
rm summaryfile_$file.txt

echo $file >> summaryfile_$file.txt

for filename in proteomes/*.fasta
do
    ~/Private/programs/hmmer-3.2/bin/hmmsearch --tblout output_tblout.txt -o output.txt -A outputA.txt $file.hmm $filename
    numberofmatchingproteins=$(cat output_tblout.txt | egrep -o '^[WY]P[^ ]+' | sort | uniq | wc -l)
    echo "$numberofmatchingproteins" >> summaryfile_$file.txt
done

rm output_tblout.txt output.txt outputA.txt

done
rm Report.txt
echo This file has the info > Report.txt
echo Proteome ID > proteomename.txt
ls proteomes/ >> proteomename.txt
paste proteomename.txt summaryfile_*.txt > Report.txt

rm TopHits.txt
echo "The following proteomes are the best candidates to be pH-resistant methanogens." >> TopHits.txt
var=$(cat Report.txt | head -n 1)
echo "$var" >> TopHits.txt
cat Report.txt | grep -v 'Proteome ID' | grep -v "0$" | grep -v "0\t" | sort -n -k2,2nr -k3,3nr >> TopHits.txt
