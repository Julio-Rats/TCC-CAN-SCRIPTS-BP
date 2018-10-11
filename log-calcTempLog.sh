#!/bin/bash

if [ -z $1 ]; then
# log de entrada === candump [interface] -t z -l
	echo "$0 <Log>"
	exit -1
else
	log="$1"
fi

cat $log | sed -n '$ p; 1 p;' | sed 's/).*//; s/(//'  | awk '{if(NR==1)first=$1}END{print $1-first}'
