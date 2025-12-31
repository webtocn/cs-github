#!/bin/bash -x
# 设置变量
REPO_OWNER="webtocn"
REPO_NAME="cs-github"
# 替换为你的 Personal Access Token
# export GH_TOKEN="ghp_hT*********v70Q8XLQ"
# 获取所有进行中的工作流运行ID 
for i in {1..100}
do
    RUN_IDS=$(curl -s -H "Authorization: token $GH_TOKEN" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs?status=queued&per_page=5000" \
    | jq '.workflow_runs[].id')
    # 循环取消每一个运行
    for RUN_ID in $RUN_IDS; do
    echo "Canceling run ID: $RUN_ID"
    curl -s -X POST -H "Authorization: token $GH_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/cancel"
    done
    echo $i
done
echo "Done."

# 获取所有状态为 queued (排队) 或 in_progress (进行中) 的工作流运行ID
# 注意：API 不支持单次查询用OR组合状态，这里分别查询然后合并。
# echo "正在获取排队中和进行中的工作流运行..."
# QUEUED_IDS=$(curl -s -H "Authorization: token $GH_TOKEN" \
#   "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs?status=queued" \
#   | jq '.workflow_runs[].id')
# IN_PROGRESS_IDS=$(curl -s -H "Authorization: token $GH_TOKEN" \
#   "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs?status=in_progress" \
#   | jq '.workflow_runs[].id')

# # 合并ID列表（处理可能的空值）
# ALL_IDS=$(echo "$QUEUED_IDS $IN_PROGRESS_IDS" | tr '\n' ' ')

# if [ -z "$ALL_IDS" ]; then
#   echo "没有找到需要取消的运行。"
#   exit 0
# fi

# echo "找到以下运行ID: $ALL_IDS"

# # 循环取消每一个运行
# for RUN_ID in $ALL_IDS; do
#   echo "正在取消运行 ID: $RUN_ID"
#   curl -s -X POST -H "Authorization: token $GH_TOKEN" \
#     -H "Accept: application/vnd.github.v3+json" \
#     "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/cancel"
# done

# echo "批量取消操作完成。"
