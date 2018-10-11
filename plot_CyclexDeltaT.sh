#!/bin/bash
cat candump_cycles_dec.txt | awk '{cycle=$2-($2%10); print cycle,($2 - cycle)}' | sort -n -k 1  | ./plot.sh 
