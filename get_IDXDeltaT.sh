#!/bin/bash

cat candump_cycles_dec.txt | awk '{print $1}' | sort -nk 1 |uniq | while read ID; do ( cat candump_cycles_dec.txt | sort -nk 1 | awk -v ID=$ID '{cycle=$2-($2%10); if(ID==$1){print $2-cycle}}' > ID_$ID.txt); done



