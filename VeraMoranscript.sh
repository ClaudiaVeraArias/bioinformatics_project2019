# Usage: bash VeraMoranscript <directory/for/each/gene/of/interest>
# Note: do not include slash after directory.
# Each set of reference genes should be in it's own directory.
# Proteome files should end in .fasta and they should be found in a subdirectory of
# the  directory that VeraMoran.sh is in. This subdirectory should be named proteomes/
# Example: bash VeraMoranscript hsp70gene mcrAgene
# Report.txt shows how many matches have the samples with the two reference genes
# TopHits.txt shows the best matches for pH resistant methanogens
#


# In order to use this script you need the
# following programs:
# muscle
# hmmer-3.2
# In your home directory you should place both programs
# within Private/programs/
# hmmer binary directory (bin) was placed within the hmmer-3.2 directory

# Start by clearing any files that may confuse the script
rm summaryfile*

## This is a script to take all ref files (hsp70 and mcrA) and add to one file named "refs.fasta"

for file in $@
do
cat $file/* > refs.fasta

# This script will take our fasta files and run them through muscle to aliment refs.fasta file

~/Private/programs/muscle -in refs.fasta -out $file.afa

# This script will take our files and run through hmmer to build the profile HMM form alignment refs.fasta file
# and create a sumary file

~/Private/programs/hmmer-3.2/bin/hmmbuild $file.hmm $file.afa


echo $file >> summaryfile_$file.txt

# This script will take all proteomes (samples) and will compare with reference profile HMM file
# it will create a table with all the matches between proteomes and HMM file and will
# the file that contains the table will be called "Report.txt"

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

# This script create a file that contains a table with the best candidates to be pH-resistant methanogens
# it will use the Report.txt information and sort it based on the number of matches
# The file name will be TopHits.txt

rm TopHits.txt
echo "The following proteomes are the best candidates to be pH-resistant methanogens." >> TopHits.txt
var=$(cat Report.txt | head -n 1)
echo "$var" >> TopHits.txt
cat Report.txt | grep -v 'Proteome ID' | grep -v "0$" | grep -v "0\t" | sort -n -k2,2nr -k3,3nr >> TopHits.txt
