#!/bin/bash

ARGS=$1

generate_diff(){
    DATE=$(date)
    echo "Date=>$DATE" > .date
}

run_task(){
    NUM=$1
    DATE=$(date)

    for ((n=0; n<$NUM; n++))
    do
        echo "Date=>$DATE , Task=> $NUM" > .date
        git add . --all && git commit -m "Date=>$DATE , Task=> $NUM" && git push
        sleep 5
    done
}



generate_diff

git add . --all && git commit -m "$ARGS" && git push
