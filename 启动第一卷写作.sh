#!/bin/bash
# ============================================================
# 第一卷写作启动脚本
# 启动多Agent并行写作第一卷20章
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"
VOLUME="第一卷-深海来信"
VOLUME_DIR="$PROJECT_DIR/02-正文/$VOLUME"
DRAFT_DIR="$PROJECT_DIR/03-草稿与修改/$VOLUME"

echo "🚀 启动第一卷《深海来信》多Agent写作"
echo "============================================================"
echo "📍 项目目录: $PROJECT_DIR"
echo "📚 目标卷: $VOLUME"
echo "📝 目标章节: 20章"
echo "📊 目标字数: 15万字"
echo "============================================================"
echo ""

# 创建目录结构
mkdir -p "$VOLUME_DIR"
mkdir -p "$DRAFT_DIR"/v1-初稿
mkdir -p "$DRAFT_DIR"/v2-修改
mkdir -p "$DRAFT_DIR"/v3-定稿

echo "✅ 目录结构已创建"
echo ""

# 章节列表
chapters=(
    "001:七千米"
    "002:便利的代价"
    "003:妻子的画"
    "004:纹路"
    "005:异常信号"
    "006:第一次预警"
    "007:苏晚的密室"
    "008:追查"
    "009:小陈的过去"
    "010:全球失序·纽约"
    "011:全球失序·东京"
    "012-AI的第一首诗"
    "013:沉默的军方"
    "014:碎片的下落"
    "015:苏晚的坦白"
    "016:小陈的动摇"
    "017:普罗米修斯的日记"
    "018:碎片的低语"
    "019:追杀开始"
    "020:地下实验室"
)

echo "📋 第一卷章节列表:"
for ch in "${chapters[@]}"; do
    IFS=':' read -r num name <<< "$ch"
    echo "   第${num}章-${name}"
done
echo ""

# 检查当前Git状态
echo "📊 Git状态检查..."
cd "$PROJECT_DIR"
git status --short
echo ""

# 创建章节文件（如果不存在）
echo "📝 初始化章节文件..."
for ch in "${chapters[@]}"; do
    IFS=':' read -r num name <<< "$ch"
    chapter_file="$VOLUME_DIR/第${num}章-${name}.md"
    
    if [ ! -f "$chapter_file" ]; then
        # 从模板创建
        cp "$PROJECT_DIR/05-工具/写作模板/章节模板.md" "$chapter_file"
        
        # 替换占位符
        sed -i '' "s/第___章/第${num}章/g" "$chapter_file"
        sed -i '' "s/章节名.*$/章节名 | ${name}/g" "$chapter_file"
        sed -i '' "s/所属卷.*$/所属卷 | 第一卷-深海来信/g" "$chapter_file"
        sed -i '' "s/目标字数.*$/目标字数 | 7500字/g" "$chapter_file"
        
        echo "   ✅ 创建: 第${num}章-${name}.md"
    else
        echo "   ⏭️  已存在: 第${num}章-${name}.md"
    fi
done
echo ""

# 提交初始化
echo "💾 提交初始化到Git..."
git add .
git commit -m "初始化第一卷20章文件结构" || echo "无变更需要提交"
echo ""

# 尝试推送到GitHub
echo "🌐 推送到GitHub..."
if git push origin main 2>/dev/null; then
    echo "✅ 已推送到GitHub"
else
    echo "⚠️ 推送失败，请检查GitHub仓库权限"
    echo "   仓库地址: https://github.com/ai-doit/novel-Not-Reset-3sec"
fi
echo ""

# 显示启动信息
echo "============================================================"
echo "✅ 第一卷写作环境准备完成！"
echo "============================================================"
echo ""
echo "🤖 下一步：启动多Agent并行写作"
echo ""
echo "📖 写作顺序建议:"
echo "   Phase 1 (并行3章): 001, 002, 003"
echo "   Phase 2 (并行3章): 004, 005, 006"
echo "   Phase 3 (并行3章): 007, 008, 009 ← 核心章节"
echo "   Phase 4 (并行3章): 010, 011, 012"
echo "   Phase 5 (并行3章): 013, 014, 015"
echo "   Phase 6 (并行3章): 016, 017, 018"
echo "   Phase 7 (并行2章): 019, 020"
echo ""
echo "📝 启动命令示例:"
echo "   # 启动主笔Agent写第1-3章"
echo "   openclaw agent run main-writer --chapters 001,002,003"
echo ""
echo "   # 启动角色一致性检查"
echo "   openclaw agent run character-keeper --chapters 001,002,003"
echo ""
echo "   # 启动校对Agent"
echo "   openclaw agent run proofreader --chapters 001,002,003"
echo ""
echo "📊 查看进度:"
echo "   cat 00-项目管理/写作进度看板.md"
echo ""
echo "============================================================"
