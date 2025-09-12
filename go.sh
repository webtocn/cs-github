#!/bin/bash -x

NUM=$1
NUM=${NUM:=1}  # 若参数为空则默认为1

# 使用C语言风格循环
for ((n=0; n<$NUM; n++))
do
    DATE=$(date)
    echo "Date=>$DATE" > .date
    git add . --all && git commit -m "Date=>$DATE" && git push
    sleep 5
done

SYNC_CHARTMUSEUM
SYNC_ARTIFACTHUB


ARGS=$1

generate_diff(){
    DATE=$(date)
    echo "Date=>$DATE" > .date
}

# 对参数进行判断
# 如果没有参数就输出 help
# 如果有参数就进行参数执行
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
        git add . --all && git commit -m "Date=>$DATE" && git push
        ;;
    *)
        echo "Usage: $0 {sync}"
        echo "sc: 将仓库中的所有版本chart同步到chartmuseum"
        echo "sa: 从artifacthub获取仓库信息"
        echo "task: 运行任务"
        ;;
esac