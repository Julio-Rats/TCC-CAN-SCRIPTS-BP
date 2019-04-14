#!/bin/bash

if [ -z $3 ]; then
# getJitter.sh out1.txt 081 10
	echo "$0 <INPUT> <ID (HEX)> <GAB>"
	exit -1
fi

INPUT=$1
ID=$2
GAB=$3

cat $INPUT | sed 's/[()]//g' | awk -v GAB=$GAB -v ID=$ID 'BEGIN{ANT=-1} {if ($3==ID){ if (ANT!=-1) printf("%f\n",(($1-ANT)-(GAB/1000))); ANT=$1}}'
