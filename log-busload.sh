#!/bin/bash

if [ -z $1 ]; then
	# entrada com Log === candump [interface] -t z -l
	echo "analysis.sh <Log>"
	exit -1
else
	CODE_DIR=$(dirname "$@")
fi

cd ${CODE_DIR}

CANDUMP="$@"

sed 's/(//; s/\..*//' ${CANDUMP} | uniq -c | awk -v FRAMESIZE=64 '{print $1*FRAMESIZE}' | ./plot.sh 
