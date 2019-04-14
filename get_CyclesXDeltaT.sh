#!/bin/bash

cat candump_cycles_dec.txt | awk '{cycle=$2-($2%10); print cycle}' | sort |uniq |sort -nk 1 | while read CYCLE; do ( cat candump_cycles_dec.txt | awk '{cycle=$2-($2%10); print cycle,($2 - cycle)}' | sort -nk 1 | awk -v cycle=$CYCLE '{if($1==cycle){print $2}}' > cycle_${CYCLE}.txt ); done



