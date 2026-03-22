#!/bin/bash
# ============================================================
# 《不可重置的3秒》多Agent写作系统启动脚本
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "🚀 启动多Agent写作系统..."
echo "📍 项目目录: $SCRIPT_DIR"
echo ""

# 检查Git状态
echo "📋 检查Git状态..."
if [ -d ".git" ]; then
    git status --short
    echo ""
else
    echo "⚠️ 未初始化Git仓库，正在初始化..."
    git init
    git config user.name "ai-doit"
    git config user.email "ai@doit.ai"
    echo "✅ Git初始化完成"
fi

# 创建今日工作日志
TODAY=$(date +%Y-%m-%d)
LOG_FILE="00-项目管理/工作日志/${TODAY}.md"
mkdir -p "00-项目管理/工作日志"

if [ ! -f "$LOG_FILE" ]; then
cat > "$LOG_FILE" << EOF
# 工作日志 - ${TODAY}

## 今日目标
- [ ] 

## 已完成章节
- 

## Agent运行状态
| Agent | 状态 | 负责章节 |
|-------|------|----------|
| main-writer | 待机 | - |
| character-keeper | 待机 | - |
| polisher | 待机 | - |
| proofreader | 待机 | - |
| theme-keeper | 待机 | - |

## 问题与阻塞
- 

## 明日计划
- 
EOF
fi

echo "📝 今日工作日志: $LOG_FILE"
echo ""

# 显示项目统计
echo "📊 项目统计..."
echo "总章节数: $(find 02-正文 -name "*.md" 2>/dev/null | wc -l)"
echo "总字数: $(find 02-正文 -name "*.md" -exec wc -m {} + 2>/dev/null | tail -1 | awk '{print $1}')"
echo ""

# GitHub推送检查
echo "🌐 检查GitHub远程仓库..."
if git remote -v > /dev/null 2>&1; then
    echo "✅ 已配置远程仓库:"
    git remote -v
else
    echo "⚠️ 未配置远程仓库"
    echo "请运行: git remote add origin https://github.com/ai-doit/novel-Not-Reset-3sec.git"
fi

echo ""
echo "============================================================"
echo "✅ 多Agent写作系统启动完成！"
echo "============================================================"
echo ""
echo "📚 快速开始:"
echo "   1. 查看今日日志: open \"$LOG_FILE\""
echo "   2. 启动第一卷写作: 执行第一卷-写作计划.md"
echo "   3. 查看Agent配置: cat AGENT-CONFIG.yaml"
echo ""
echo "🤖 可用Agent命令:"
echo "   - 开始写作: openclaw agent run main-writer"
echo "   - 角色检查: openclaw agent run character-keeper"
echo "   - 润色: openclaw agent run polisher"
echo ""
echo "📖 项目文档:"
echo "   - 角色数据库: 角色数据库.md"
echo "   - 六卷大纲: 01-大纲/分卷大纲/"
echo "   - 写作模板: 05-工具/写作模板/"
echo ""
echo "============================================================"
