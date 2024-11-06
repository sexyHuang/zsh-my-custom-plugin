#!/bin/zsh

# 获取当前日期
current_date=$(date +%Y-%m-%d)

# 检查输入参数
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <type> <input>"
  exit 1
fi

# 获取参数
type=$1
input=$2

# 读取配置项
name=$GIT_BRANCH_NAME
source_branch=$GIT_SOURCE_BRANCH

# 创建分支名
branch_name="${type}/${name}/${current_date}-${input}"

# 切换到指定的源分支并拉取最新代码
git checkout $source_branch
git pull origin $source_branch

# 创建并切换到新分支
git checkout -b $branch_name

echo "Switched to a new branch '$branch_name' from '$source_branch'"
