#script to take the table of matches

beginning='grep -n 'Query:' Search_hsp90.txt | cut -d: -f1
end='grep -n 'Domain annotation for each sequence' Search_hsp90.txt | cut -d: -$
lines=$(($end-$beginning))

tail -n +$beginning Search_hsp90.txt | head -$lines > Test.txt
