# 《不可重置的3秒》多Agent写作系统 - 标准操作程序(SOP)

> 版本: v1.0  
> 创建日期: 2026-03-21  
> 最后更新: 2026-03-21  
> 状态: 准备就绪，待执行

---

## 📋 SOP使用说明

### 谁应该阅读此文档
- 项目发起人（你）
- 负责执行环境搭建的操作员
- 后期维护和优化人员

### 如何更新此SOP
1. 在每次重大变更后，更新"最后更新"日期
2. 在"变更历史"章节记录变更内容
3. 如果新增步骤，使用新的编号
4. 如果删除步骤，保留编号并标注"已废弃"

---

## 🎯 项目概述

### 项目目标
创作100万字长篇科幻小说《不可重置的3秒》，使用OpenClaw多Agent协作系统，结合Obsidian本地知识库管理，实现：
- 剧情连贯、细节可改
- 创作过程全保存
- 多Agent并行高效写作

### 核心技术栈
| 组件 | 用途 | 版本要求 |
|------|------|----------|
| OpenClaw | 多Agent协作中枢 | 最新版 |
| Obsidian | 本地知识库管理 | v1.0+ |
| Git | 版本控制 | v2.30+ |
| GitHub | 云端备份 | - |

### 项目结构
```
novel-Not-Reset-3sec/
├── 00-项目管理/          # 进度看板、工作日志
├── 01-大纲/              # 分卷大纲、章节细纲
├── 02-正文/              # 六卷正文（Git版本控制）
├── 03-草稿与修改/        # v1-初稿、v2-修改、v3-定稿
├── 04-素材/              # 研究资料、参考文档
├── 05-工具/              # 模板、检查清单、脚本
├── AGENT-CONFIG.yaml     # Agent配置
├── 角色数据库.md        # 人物设定
└── *.sh                  # 启动脚本
```

---

## 🔧 第一阶段：环境搭建（预计1-2天）

### 步骤1.1: 创建项目目录结构

**执行条件**: 在macOS上执行，需要写入权限到 `/Users/zhangliqin/Documents/`

**操作步骤**:
```bash
# 1. 创建主目录
mkdir -p /Users/zhangliqin/Documents/novel-Not-Reset-3sec
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 2. 创建一级目录
mkdir -p 00-项目管理
mkdir -p 01-大纲/分卷大纲 01-大纲/章节细纲
mkdir -p 02-正文
mkdir -p 03-草稿与修改
mkdir -p 04-素材/科学研究 04-素材/历史参考 04-素材/诗歌文学 04-素材/视觉参考
mkdir -p 05-工具/写作模板 05-工具/检查清单 05-工具/导出脚本

# 3. 创建六卷正文目录
for vol in 第一卷-深海来信 第二卷-失控边缘 第三卷-清零日 第四卷-北极对决 第五卷-深空幽暗 第六卷-反向入侵; do
    mkdir -p "02-正文/$vol"
    mkdir -p "03-草稿与修改/$vol/v1-初稿"
    mkdir -p "03-草稿与修改/$vol/v2-修改"
    mkdir -p "03-草稿与修改/$vol/v3-定稿"
done

# 4. 创建软链接到workspace
ln -sf /Users/zhangliqin/Documents/novel-Not-Reset-3sec /Users/zhangliqin/.openclaw/workspace/novel-Not-Reset-3sec

# 5. 验证创建结果
tree -L 2 -d || find . -maxdepth 2 -type d | sort
echo "✅ 目录结构创建完成"
```

**预期输出**:
```
./00-项目管理
./01-大纲
./01-大纲/分卷大纲
./01-大纲/章节细纲
./02-正文
./02-正文/第一卷-深海来信
...
✅ 目录结构创建完成
```

**故障排除**:
- 如果 `tree` 命令不存在，使用 `find` 替代
- 如果软链接创建失败，检查目标目录是否存在
- 如果权限不足，使用 `sudo` 或检查目录权限

**验证方法**:
```bash
# 检查目录是否存在
ls -la /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 检查软链接
ls -la /Users/zhangliqin/.openclaw/workspace/novel
```

---

### 步骤1.2: 初始化Git版本控制

**执行条件**: 已安装Git，Git版本 >= 2.30

**操作步骤**:
```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 1. 初始化Git仓库
git init

# 2. 配置Git用户信息（使用ai-doit作为用户名）
git config user.name "ai-doit"
git config user.email "ai@doit.ai"

# 3. 创建.gitignore文件
cat > .gitignore << 'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride

# Obsidian
.obsidian/workspace*
.obsidian/cache
.trash/

# 临时文件
*.tmp
*.temp
*.swp
*~

# 备份文件
*.bak
*.backup

# 输出文件（导出时生成）
output/
export/
dist/
EOF

# 4. 创建README.md
cat > README.md << 'EOF'
# 《不可重置的3秒》

> 100万字长篇科幻小说创作项目

## 项目简介

- **小说名称**: 《不可重置的3秒》
- **目标字数**: 100万字
- **预计卷数**: 6卷 + 终章
- **预计章节**: 137章
- **创作工具**: OpenClaw多Agent协作 + Obsidian知识库管理

## 核心设定

- **三层真相**: 文明循环 → 碎片陷阱 → 实验真相
- **核心意象**: 3秒（打破循环的钥匙）
- **三源线索**: 金属碎片、三源树、小陈的音频

## 目录结构

```
.
├── 00-项目管理/          # 进度看板、工作日志
├── 01-大纲/              # 分卷大纲、章节细纲
├── 02-正文/              # 六卷正文（Git版本控制）
├── 03-草稿与修改/        # v1-初稿、v2-修改、v3-定稿
├── 04-素材/              # 研究资料、参考文档
└── 05-工具/              # 模板、检查清单、脚本
```

## 创作进度

| 卷号 | 卷名 | 目标字数 | 进度 |
|------|------|----------|------|
| 第一卷 | 深海来信 | 15万 | 🟡 准备中 |
| 第二卷 | 失控边缘 | 20万 | ⚪ 未开始 |
| 第三卷 | 清零日 | 20万 | ⚪ 未开始 |
| 第四卷 | 北极对决 | 15万 | ⚪ 未开始 |
| 第五卷 | 深空幽暗 | 10万 | ⚪ 未开始 |
| 第六卷 | 反向入侵 | 20万 | ⚪ 未开始 |

## 使用说明

### 启动写作
```bash
# 查看主菜单
./小说写作主控.sh

# 直接启动第一卷
./启动第一卷写作.sh
```

### 同步到GitHub
```bash
./同步到GitHub.sh
```

## 版权说明

- **作者**: ai-doit
- **创作日期**: 2026-03-21
- **许可证**: 保留所有权利

---

*本项目使用 OpenClaw 多Agent协作系统创作*
EOF

# 5. 提交初始版本
git add .
git commit -m "Initial commit: 项目初始化

- 创建项目目录结构
- 初始化Git版本控制
- 添加.gitignore和README.md"

# 6. 检查状态
git status
git log --oneline novel-Not-Reset-3sec=-

echo "✅ Git初始化完成"
```

**预期输出**:
```
Initialized empty Git repository in /Users/zhangliqin/Documents/novel-Not-Reset-3sec/.git/
[main (root-commit) xxxxxxx] Initial commit: 项目初始化
...
✅ Git初始化完成
```

**故障排除**:
- 如果 `git config` 失败，检查Git是否正确安装: `git --version`
- 如果提交失败，检查是否有文件被修改: `git status`
- 如果需要修改提交信息，使用 `git commit --amend`

---

### 步骤1.3: 配置GitHub远程仓库

**执行条件**: 已在GitHub创建仓库 `https://github.com/ai-doit/novel-Not-Reset-3sec`

**操作步骤**:
```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 1. 添加远程仓库
git remote add origin https://github.com/ai-doit/novel-Not-Reset-3sec.git

# 2. 验证远程仓库
git remote -v

# 3. 推送到GitHub
git push -u origin main

# 4. 验证推送成功
echo "查看GitHub仓库: https://github.com/ai-doit/novel-Not-Reset-3sec"

echo "✅ GitHub配置完成"
```

**预期输出**:
```
origin  https://github.com/ai-doit/novel-Not-Reset-3sec.git (fetch)
origin  https://github.com/ai-doit/novel-Not-Reset-3sec.git (push)
Enumerating objects: XX, done.
...
✅ GitHub配置完成
```

**故障排除**:
- 如果推送失败，检查GitHub仓库是否已创建
- 如果需要认证，使用GitHub Token或个人访问令牌
- 如果远程已存在，使用 `git remote set-url origin <url>` 修改

---

### 步骤1.4: 创建Agent配置文件

**执行条件**: 已完成步骤1.1-1.3，项目目录已创建

**操作步骤**:

由于Agent配置文件已在之前创建，这里提供验证和更新步骤：

```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 1. 检查Agent配置文件是否存在
ls -la AGENT-CONFIG.yaml

# 2. 验证配置内容
cat AGENT-CONFIG.yaml | head -50

# 3. 如果有更新，修改后提交
# git add AGENT-CONFIG.yaml
# git commit -m "更新Agent配置"
# git push

echo "✅ Agent配置文件已验证"
```

**预期输出**:
```
-rw-r--r--  1 user  staff  XXXX Mar 21 XX:XX AGENT-CONFIG.yaml
models:
  kimi-k2p5:
    id: "volcengine-plan/kimi-k2p5"
    ...
✅ Agent配置文件已验证
```

---

### 步骤1.5: 创建角色数据库

**执行条件**: 已完成步骤1.1-1.4

**操作步骤**:

角色数据库已在之前创建，这里提供验证步骤：

```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 1. 检查角色数据库是否存在
ls -la 角色数据库.md

# 2. 验证内容结构
cat 角色数据库.md | head -100

# 3. 检查字数统计
wc -l 角色数据库.md

echo "✅ 角色数据库已验证"
```

---

### 步骤1.6: 创建第一卷写作计划

**执行条件**: 已完成步骤1.1-1.5

**操作步骤**:

```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec

# 1. 检查第一卷写作计划
ls -la "01-大纲/分卷大纲/第一卷-深海来信-写作计划.md"

# 2. 验证章节细纲数量
find "01-大纲" -name "*.md" | wc -l

# 3. 检查第一卷章节文件是否已创建
ls "02-正文/第一卷-深海来信/" | head -10

echo "✅ 第一卷写作计划已验证"
```

---

## 📝 变更历史

| 版本 | 日期 | 变更内容 | 变更人 |
|------|------|----------|--------|
| v1.0 | 2026-03-21 | 初始版本，完成环境搭建SOP | ai-doit |

---

## 🔗 相关文档

- [README.md](./README.md) - 项目概述
- [AGENT-CONFIG.yaml](./AGENT-CONFIG.yaml) - Agent配置
- [角色数据库.md](./角色数据库.md) - 人物设定
- [写作进度看板.md](./00-项目管理/写作进度看板.md) - 进度追踪

---

*本文档由 OpenClaw 自动生成，最后更新时间: 2026-03-21*
