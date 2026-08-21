# Template: default

Spec 模板，安装后落在 `.trellis/spec/`，与官方默认脚手架内容对齐（外加边界规则）：

- `backend/`、`frontend/` — 默认规范占位（与默认 `trellis init` 一致）
- `guides/` — thinking guides + `agent-workflow-boundary.md`（**边界规则**：Trellis 决定流程与产物，极简类规则（ponytail / YAGNI）只管实现细节，冲突时以 Trellis 为准）
- `guides/index.md` — 已注册边界规则的发现入口

## 前提（重要）

Trellis CLI 的 `--registry` 只支持 git 托管源（`gh`/`github`/`gitlab`/`bitbucket` + 自托管 GitLab），**本机目录不能直接当 registry**（实测 `--registry E:/...` 报 `Unsupported provider "E"`）。所以使用分两种：

### 方式一：推到 git 托管后（官方正式路径）

仓库已推送到 `https://github.com/jifeilong9/trellis-spec-marketplace`。

```bash
# ✅ 全新项目（推荐）：模板已含 backend/frontend/guides 全套，一条命令自动装，无需本地脚本
trellis init -u your-name --claude --pi --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default
```

已有项目（默认脚手架/旧 Trellis 项目）想补边界规则：

```bash
# --append 会补缺失文件，但不会覆盖已有的 guides/index.md → 需再跑一次 apply 脚本完成注册
cd <项目>
trellis init --registry gh:jifeilong9/trellis-spec-marketplace/marketplace --template default --append
bash E:/code/_trellis-spec-marketplace/apply-boundary.sh <项目>
```

> 探测/下载走的是网络，可能需要能访问 GitHub 的网络环境（本机有代理时自动走代理）。
> registry 源格式：`provider:user/repo[/subdir][#ref]`，path 指向含 `index.json` 的目录。

### 方式二：还没推 git、纯本地（幂等脚本，一条命令）

```bash
bash E:/code/_trellis-spec-marketplace/apply-boundary.sh <项目目录> [更多项目...]
```

该脚本幂等：项目已有 guide / 已注册则跳过，可重复执行。等价于手动拷贝 guide + 更新 `guides/index.md`。

## 注意

- 模板只是起点。边界规则通过 `guides/index.md` 在会话启动时被发现，**项目级持续生效**；要调整时直接改项目内文件，不要改模板后指望已有项目自动同步（Trellis 的 spec 不是远程同步的 wiki）。
- 未来若有破坏性改动，建议开新 template id（如 `default-v2`）而非原地改动。
