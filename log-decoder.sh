#!/bin/bash

if [ -z $1 ]; then
# entrada com Log === candump [interface] -t z -l
	echo "$0 <Log>"
	exit -1
fi

CANDUMP="$@"

## CANGEN   gera arquivo com ID e DELTA 

#awk '{print $3}' ${CANDUMP} | sed 's/#.*//' | gawk --non-decimal-data '{ $1 = sprintf("%d", "0x" $1) } 1' | sort | uniq | sort -n > ids.txt

awk '{print $3,$1}' ${CANDUMP} | sed 's/[()]//g;s/#.* / /' | awk '{id=$1; milis=$2*1000; if(last[id]==0){last[id]=milis} else{print id,(milis-last[id]); last[id]=milis}}' | gawk --non-decimal-data '{ $1 = sprintf("%d", "0x" $1) } 1'  > candump_cycles_dec.txt

