# Trellis Spec Template Marketplace（本地）

给 Trellis 项目分发 **Agent Workflow Boundary 边界规则**的 spec template marketplace。

> **边界规则一句话**：Trellis 决定流程与产物；极简类规则（ponytail / YAGNI）只管代码写法；冲突时以 Trellis 为准。

---

## 🚀 快速使用（复制即用，防忘）

### ① 全新项目（推荐）：一条命令，全从 git

> ⚠️ Windows cmd / PowerShell：**不要拆行**，下面整行复制（`\` 换行是 bash 语法，Windows 不认）：

```bash
cd <新项目目录>

trellis init -u your-name --claude --pi --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default
```

- `your-name` 换成你的开发者名（如 `jifeilong9`）
- 想用别的平台就去掉对应 flag，或改用 `trellis init --registry ... --template default` 交互式选
- 产出：`backend/` + `frontend/` + `guides/`（含边界规则注册）≈ 官方默认脚手架 + 边界
- 常见报错排查：`error: option '-t, --template <name>' argument missing` = 命令被截断/拆行，`--template` 后面必须带上 `default`

### ② 已有项目补边界（旧脚手架 / 无 Trellis 项目）

```bash
cd <已有项目>

# 若还没有 Trellis，先初始化（可选平台 flag）
trellis init -u your-name --claude --pi

# 补边界模板文件（只补缺失，不覆盖已有内容）
trellis init --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default --append

# ⚠️ --append 不会覆盖已有 guides/index.md，必须再跑一次脚本完成注册（本地兜底）
bash E:/code/_trellis-spec-marketplace/apply-boundary.sh .
```

### ③ 纯本地、不依赖 git（无网络时兜底）

```bash
bash E:/code/_trellis-spec-marketplace/apply-boundary.sh <项目目录>
```

幂等：guide 已存在 / 已注册则跳过，可反复执行。

---

## 装完怎么验证

```bash
# 边界规则文件在不在？
test -f .trellis/spec/guides/agent-workflow-boundary.md && echo "✔ 存在"

# index.md 注册了没？（表行 + 触发行应各有 1 处）
grep -c "\[Agent Workflow Boundary Guide\]" .trellis/spec/guides/index.md
```

---

## 内容结构

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

## 维护提醒

- 模板是**起点**，不是远程同步的 wiki。改动某项目里的 spec，不会回传本模板。
- 若要给一部分项目不同配置，建议开新 template id（如 `default-v2`），别原地改名。

## 仓库

- 远端：`https://github.com/jifeilong9/trellis-spec-marketplace.git`
- registry 源：`gh:jifeilong9/trellis-spec-marketplace/marketplace`（指向含 `index.json` 的目录）
