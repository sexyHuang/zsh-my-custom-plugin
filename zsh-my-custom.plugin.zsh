# zsh-my-custom

# 获取当前脚本的目录路径
SCRIPT_DIR=$(dirname "${0:A}")

# 为脚本添加执行权限
chmod +x "$SCRIPT_DIR/scripts/create_branch.sh"

# 配置项
export GIT_BRANCH_NAME="huangjianyong"
export GIT_SOURCE_BRANCH="main"

# 别名配置
alias gcbr="$SCRIPT_DIR/scripts/create_branch.sh"
alias gcbf="gcbr feature"
alias gcbhf="gcbr hotfix"
alias gcbfix="gcbr fix"

# 其他配置项...
