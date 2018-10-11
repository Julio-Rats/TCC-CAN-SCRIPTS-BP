#!/bin/bash

cat candump_cycles_dec.txt | awk '{cycle=$2-($2%10); print $1,($2 - cycle)}' | sort -n -k 1,2 | awk '{if(NR>1 && $1!=lastID){print lastID,lastDelta} lastID=$1; lastDelta=$2;}' > wcrt.txt
