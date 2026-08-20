# Trellis Spec Template Marketplace（本地）

给 Trellis 项目分发"Agent Workflow Boundary"边界规则的本地 marketplace。

## 内容

```
marketplace/
├── index.json                       # marketplace 合约（version 1）
└── specs/default/                   # template id = default
    ├── README.md
    └── guides/                      # 安装后落在 .trellis/spec/guides/
        ├── index.md
        ├── agent-workflow-boundary.md
        ├── code-reuse-thinking-guide.md
        └── cross-layer-thinking-guide.md
apply-boundary.sh                    # 本地幂等注入脚本（git 托管前用）
```

## 用哪个？

| 场景 | 方法 |
|---|---|
| 已推到 GitHub，想新项目自动装 | `trellis init --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default` |
| 纯本地、不依赖 git | `bash apply-boundary.sh <项目目录>` |

详见 `marketplace/specs/default/README.md`。

## 仓库

- 远端：`https://github.com/jifeilong9/trellis-spec-marketplace.git`（public）
- registry 源：`gh:jifeilong9/trellis-spec-marketplace/marketplace`（指向含 `index.json` 的目录）
