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


case $ARGS in
    sc)
        generate_diff
        git add . --all && git commit -m "SYNC_CHARTMUSEUM" && git push
        ;;
    sa)
        generate_diff
        git add . --all && git commit -m "SYNC_ARTIFACTHUB" && git push
        ;;
    task)
        generate_diff
        run_task 1
        ;;
    task5)
        generate_diff
        run_task 5
        ;;
    task10)
        generate_diff
        run_task 10
        ;;
    *)
        echo "Usage: $0 {option}"
        echo "  sc: 将仓库中的所有版本chart同步到存储"
        echo "  sa: 从artifacthub获取仓库信息"
        echo "  task: 运行单次任务"
        echo "  task5: 运行5次任务"
        echo "  task10: 运行10次任务"
        ;;
esac