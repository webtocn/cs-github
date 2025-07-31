#!/bin/bash -x

NUM=$1
NUM=${NUM:=1}  # 若参数为空则默认为1

# 使用C语言风格循环
for ((n=0; n<$NUM; n++))
do
    DATE=$(date)
    echo "Date=>$DATE" > .date
    git add . --all && git commit -m "Date=>$DATE" && git push
    sleep 1
done
