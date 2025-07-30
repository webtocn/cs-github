#!/bin/bash -x

NUM=$1:1

for n in `echo $NUM`
do
    DATE=`date`
    echo "Date=>$DATE" > .date
    git add . --all && git commit -m "Date=>$DATE" && git push
    sleep 1
done
