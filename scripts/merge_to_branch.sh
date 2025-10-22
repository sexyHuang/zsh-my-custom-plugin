#!/bin/zsh

# 检查输入参数
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <target_branch>"
  echo "Example: $0 main"
  exit 1
fi

# 获取参数
target_branch=$1

# 获取当前分支名
current_branch=$(git branch --show-current)

if [ -z "$current_branch" ]; then
  echo "Error: Unable to determine current branch"
  exit 1
fi

echo "Current branch: $current_branch"
echo "Target branch: $target_branch"

# 检查是否有未提交的更改
echo "Checking for uncommitted changes..."
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: You have uncommitted changes. Please commit or stash them before merging."
  git status --short
  exit 1
fi

echo "No uncommitted changes detected"

# 确认是否继续
read "confirm?Are you sure you want to merge '$current_branch' into '$target_branch'? (y/n): "
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Merge cancelled"
  exit 0
fi

# 推送当前分支到远程
echo "Pushing current branch to remote..."
git push origin $current_branch
if [ $? -ne 0 ]; then
  echo "Warning: Failed to push current branch to remote"
fi

# 切换到目标分支
echo "Switching to target branch '$target_branch'..."
git checkout $target_branch
if [ $? -ne 0 ]; then
  echo "Error: Failed to checkout branch '$target_branch'"
  exit 1
fi

# 拉取目标分支最新代码
echo "Pulling latest code from '$target_branch'..."
git pull origin $target_branch
if [ $? -ne 0 ]; then
  echo "Error: Failed to pull latest code from '$target_branch'"
  exit 1
fi

# 合并当前分支到目标分支
echo "Merging '$current_branch' into '$target_branch'..."
git merge $current_branch
if [ $? -ne 0 ]; then
  echo "Error: Merge conflict detected. Please resolve conflicts manually."
  exit 1
fi

echo "Successfully merged '$current_branch' into '$target_branch'"
echo ""
echo "To push the merged code to remote, run:"
echo "  git push origin $target_branch"
