#!/bin/bash

if [ -z $1 ]; then
	echo "$0 <Cycle/ID>"
	exit -1
fi

candump=$1
cd `dirname "$0"`
numRoll=$(wc -l $candump | awk '{print $1}')

cat $candump | sort -nk 1 | awk -v numroll=$numRoll '{if ( ( NR > numroll*0.05 ) && ( NR < numroll-(numroll*0.05) ) ) print $1 }' > /tmp/tempwrite.txt

mv /tmp/tempwrite.txt $candump
