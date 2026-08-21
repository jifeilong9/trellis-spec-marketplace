# Trellis Spec Template Marketplace（本地）

给 Trellis 项目分发"Agent Workflow Boundary"边界规则的本地 marketplace。

## 内容

```
marketplace/
├── index.json                       # marketplace 合约（version 1）
└── specs/default/                   # template id = default
    ├── README.md
    ├── backend/                     # 默认后端规范占位（与官方默认脚手架一致）
    ├── frontend/                    # 默认前端规范占位（与官方默认脚手架一致）
    └── guides/                      # 安装后落在 .trellis/spec/guides/
        ├── index.md
        ├── agent-workflow-boundary.md
        ├── code-reuse-thinking-guide.md
        └── cross-layer-thinking-guide.md
apply-boundary.sh                    # 本地幂等注入脚本（旧项目/兜底用）
```

## 用哪个？

| 场景 | 方法 |
|---|---|
| **全新项目（推荐）**：模板已含 backend/frontend/guides 全套，和官方默认脚手架一致 | 一条命令：`trellis init -u your-name --claude --pi --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default` |
| **已有项目**（无 Trellis 或已有默认脚手架） | `--append` 只补缺失文件、不覆盖已有 `index.md`；补完跑 `bash apply-boundary.sh <项目>` 完成注册 |
| 纯本地、不依赖 git | `bash apply-boundary.sh <项目目录>`（幂等，补文件 + index 注册一把成） |

详见 `marketplace/specs/default/README.md`。

## 仓库

- 远端：`https://github.com/jifeilong9/trellis-spec-marketplace.git`（public）
- registry 源：`gh:jifeilong9/trellis-spec-marketplace/marketplace`（指向含 `index.json` 的目录）
