# Usage: bash VeraMoranscript.sh <refdirectory> no slash

# In order to use this script you need the
# following programs:
# muscle
# hmmer-3.2
# In your home directory you should place both programs
# within Private/programs/


# This is a script to take all ref files and add to one file

for file in $@/*.fasta
do
    cat $file >> $@.fasta
done

# This script will take our fasta files and run them through muscle

~/Private/programs/muscle -in $@.fasta -out $@.afa


# This script will take our files and run through hmmr

~/Private/programs/hmmer-3.2/bin/hmmbuild $@.hmm $@.afa

# This part needs to run each proteome through
# the hmmsearch and then pull out each alignment


for file in proteomes/*.fasta
do
    ~/Private/programs/hmmer-3.2/bin/hmmsearch --tblout output_tblout.txt -o output.txt -A outputA.txt $@.hmm $file
    proteomename=$(cat output_tblout.txt | grep Target | pcregrep -o 'proteomes/\K[^ ]+$')
    echo $proteomename >> summaryfile_$@.txt
    numberofmatchingproteins=$(cat outputA.txt | pcregrep -o '^WP[^ ]+' | sort | uniq | wc -l)
    echo "Number of matching proteins: $numberofmatchingproteins" >> summaryfile_$@.txt
    lengthofmatch=$(cat outputA.txt | pcregrep -o '^WP[^ ]+' | sort | uniq | cut -d / -f 2)
    proteinID=$(cat outputA.txt | pcregrep -o '^WP[^ ]+' | sort | uniq | cut -d / -f 1)
    #descriptionofprotein=$(cat output.txt | pcregrep '>> WP' | sed -E 's/>> WP_[0-9]+[.]1  //')
    echo "Protein ID    Match Location" >> summaryfile_$@.txt
    paste <(printf %s "$proteinID") <(printf %s "$lengthofmatch") >> summaryfile_$@.txt #<(printf %s "$descriptionofprotein")

done
