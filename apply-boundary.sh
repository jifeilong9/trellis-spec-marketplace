#!/usr/bin/env bash
# apply-boundary.sh — 给任意 Trellis 项目本地补齐"Agent Workflow Boundary"规范
#
# 用途: Trellis CLI 的 --registry 只支持 git 托管源（gh/gitlab/bitbucket），
#       本地目录不能直接当 registry。在推到 GitHub/GitLab 之前，用本脚本
#       给新/旧项目注入边界规则（幂等，可重复执行）。
#
# 用法:
#   bash apply-boundary.sh <项目目录> [更多项目目录...]
#   bash apply-boundary.sh "E:/code/我的新项目"
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUIDE_DIR="$SCRIPT_DIR/marketplace/specs/default/guides"
GUIDE_FILE="agent-workflow-boundary.md"

TABLE_ROW='| [Agent Workflow Boundary Guide](./agent-workflow-boundary.md) | Trellis owns the workflow; minimization rules only shape implementation code | Whenever a minimization ruleset prompts you to skip a Trellis task or artifact |'
TRIGGER_BLOCK='### When Deciding Workflow vs. Implementation

- [ ] A rule like "does this need to exist?" makes you want to skip a Trellis task / artifact
- [ ] You'"'"'re considering deleting design.md / implement.md / check.jsonl as "over-engineering"
- [ ] Two instructions conflict: one says skip, Trellis says create
- [ ] Any minimization ruleset (ponytail / YAGNI) is active in this session

→ Read [Agent Workflow Boundary Guide](./agent-workflow-boundary.md)'

fail() { echo "✗ $*" >&2; exit 1; }

apply_one() {
  local proj="$1"
  [ -d "$proj" ] || fail "项目目录不存在: $proj"
  [ -d "$proj/.trellis" ] || fail "不是 Trellis 项目（缺 .trellis/）: $proj"

  local dest_guides="$proj/.trellis/spec/guides"
  local idx="$dest_guides/index.md"
  [ -d "$dest_guides" ] || fail "缺 .trellis/spec/guides/（先跑 trellis init）: $proj"

  # 1) 复制规范文件（存在则跳过）
  if [ -f "$dest_guides/$GUIDE_FILE" ]; then
    echo "· $proj: $GUIDE_FILE 已存在，跳过"
  else
    cp "$GUIDE_DIR/$GUIDE_FILE" "$dest_guides/$GUIDE_FILE"
    echo "· $proj: 已写入 $GUIDE_FILE"
  fi

  # 2) 幂等注册进 index.md
  local changed=0
  if grep -qF 'Agent Workflow Boundary Guide](./agent-workflow-boundary.md)' "$idx"; then
    echo "· $proj: index.md 已注册，跳过表格"
  else
    # 插在 Cross-Layer 表格行之后
    sed -i '/| \[Cross-Layer Thinking Guide\](\.\/cross-layer-thinking-guide\.md) |/a\| [Agent Workflow Boundary Guide](./agent-workflow-boundary.md) | Trellis owns the workflow; minimization rules only shape implementation code | Whenever a minimization ruleset prompts you to skip a Trellis task or artifact |' "$idx"
    changed=1
  fi
  if grep -qF 'When Deciding Workflow vs. Implementation' "$idx"; then
    echo "· $proj: index.md 已有触发段落，跳过"
  else
    # 插在 Code Reuse 触发行之后
    sed -i '/^→ Read \[Code Reuse Thinking Guide\](\.\/code-reuse-thinking-guide\.md)$/a\
\
### When Deciding Workflow vs. Implementation\
\
- [ ] A rule like "does this need to exist?" makes you want to skip a Trellis task / artifact\
- [ ] You'"'"'re considering deleting design.md / implement.md / check.jsonl as "over-engineering"\
- [ ] Two instructions conflict: one says skip, Trellis says create\
- [ ] Any minimization ruleset (ponytail / YAGNI) is active in this session\
\
→ Read [Agent Workflow Boundary Guide](./agent-workflow-boundary.md)' "$idx"
    changed=1
  fi
  [ "$changed" = 1 ] && echo "· $proj: index.md 已更新"
  echo "✔ $proj 完成"
}

[ $# -ge 1 ] || { echo "用法: bash apply-boundary.sh <项目目录> [...]"; exit 1; }
for p in "$@"; do apply_one "$p"; done
echo "全部完成。"
