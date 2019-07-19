#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: input a index in list.txt"
    exit
fi
# index and ip can be sperate with multiple spaces or tabs
ip=`cat list.txt | grep -E  "^$1[[[:space:]]|\t]?([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $2}'`
if [ ! "$ip" ]
then
    echo "Failed to get IP with given index : "$1
    exit 1
fi

./expect.sh $ip
