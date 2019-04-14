#!/bin/bash
# sort -n -k 1 candump_cycles_dec.txt | sed 's/[^ ]*\./\./' | ../software/bin/plot.sh 

cat candump_cycles_dec.txt | awk '{cycle=$2-($2%10); print $1,($2 - cycle)}' | sort -n -k 1  | ./plot.sh 
