#!/bin/bash
# ============================================================
# 《不可重置的3秒》百万字长篇小说
# 多Agent协作写作系统 - 主控脚本
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="不可重置的3秒"

echo "🐙 启动《${PROJECT_NAME}》多Agent写作系统"
echo "============================================================"
echo ""

# 显示菜单
show_menu() {
    echo "📚 主菜单:"
    echo ""
    echo "   [1] 🚀 启动第一卷写作 (20章)"
    echo "   [2] 📊 查看写作进度"
    echo "   [3] 👥 查看角色数据库"
    echo "   [4] ⚙️  查看Agent配置"
    echo "   [5] 💾 手动同步到GitHub"
    echo "   [6] 📝 创建新章节细纲"
    echo "   [7] 🔍 运行一致性检查"
    echo "   [8] 📖 查看项目统计"
    echo "   [0] ❌ 退出"
    echo ""
}

# 启动第一卷
start_volume1() {
    echo "🚀 启动第一卷《深海来信》..."
    bash "$SCRIPT_DIR/启动第一卷写作.sh"
}

# 查看进度
show_progress() {
    echo "📊 当前写作进度:"
    echo ""
    
    # 统计各卷完成情况
    for vol in 第一卷-深海来信 第二卷-失控边缘 第三卷-清零日 第四卷-北极对决 第五卷-深空幽暗 第六卷-反向入侵; do
        if [ -d "$SCRIPT_DIR/02-正文/$vol" ]; then
            count=$(find "$SCRIPT_DIR/02-正文/$vol" -name "*.md" 2>/dev/null | wc -l)
            words=$(find "$SCRIPT_DIR/02-正文/$vol" -name "*.md" -exec wc -m {} + 2>/dev/null | tail -1 | awk '{print $1}')
            echo "   📗 $vol: $count章 / ${words}字"
        fi
    done
    
    echo ""
    echo "📋 详细进度看板:"
    cat "$SCRIPT_DIR/00-项目管理/写作进度看板.md" 2>/dev/null | head -100 || echo "   进度看板未创建"
}

# 查看角色数据库
show_characters() {
    echo "👥 角色数据库:"
    cat "$SCRIPT_DIR/角色数据库.md" 2>/dev/null | head -150 || echo "   角色数据库未创建"
}

# 查看Agent配置
show_agents() {
    echo "⚙️ Agent配置:"
    cat "$SCRIPT_DIR/AGENT-CONFIG.yaml" 2>/dev/null | head -100 || echo "   Agent配置未创建"
}

# 同步到GitHub
sync_github() {
    echo "💾 同步到GitHub..."
    cd "$SCRIPT_DIR"
    
    git add .
    git commit -m "更新: $(date '+%Y-%m-%d %H:%M')" || echo "无变更需要提交"
    
    if git push origin main; then
        echo "✅ 同步成功"
        echo "   仓库地址: https://github.com/ai-doit/不可重置的3秒"
    else
        echo "❌ 同步失败"
        echo "   请检查网络连接和GitHub权限"
    fi
}

# 创建新章节细纲
create_outline() {
    echo "📝 创建新章节细纲..."
    read -p "请输入卷号 (1-6): " vol_num
    read -p "请输入章节号: " ch_num
    read -p "请输入章节名: " ch_name
    
    vol_names=("深海来信" "失控边缘" "清零日" "北极对决" "深空幽暗" "反向入侵")
    vol_name="${vol_names[$((vol_num-1))]}"
    
    outline_file="$SCRIPT_DIR/01-大纲/章节细纲/第${vol_num}卷-${vol_name}/第${ch_num}章-${ch_name}-细纲.md"
    mkdir -p "$(dirname "$outline_file")"
    
    cat > "$outline_file" << EOF
# 第${ch_num}章-${ch_name} - 章节细纲

## 基本信息
- **所属卷**: 第${vol_num}卷-${vol_name}
- **目标字数**: 7500字
- **主视角**: 
- **场景**: 

## 核心事件
1. 
2. 
3. 
4. 
5. 

## 3秒伏笔
- 

## 情感落点
- 

## 写作要点
- 

## 关联
- 前情: 
- 后续: 
EOF

    echo "✅ 细纲已创建: $outline_file"
}

# 运行一致性检查
run_checks() {
    echo "🔍 运行一致性检查..."
    echo "   此功能需要启动Agent，请使用OpenClaw命令:"
    echo "   openclaw agent run character-keeper"
    echo "   openclaw agent run proofreader"
}

# 项目统计
show_stats() {
    echo "📖 项目统计:"
    echo ""
    
    total_chapters=$(find "$SCRIPT_DIR/02-正文" -name "*.md" 2>/dev/null | wc -l)
    total_words=$(find "$SCRIPT_DIR/02-正文" -name "*.md" -exec wc -m {} + 2>/dev/null | tail -1 | awk '{print $1}')
    
    echo "   📚 已完成章节: $total_chapters / 137"
    echo "   📝 已完成字数: $total_words / 1000000"
    echo "   📊 完成进度: $((total_words * 100 / 1000000))%"
    echo ""
    
    # Git统计
    cd "$SCRIPT_DIR"
    commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    echo "   💾 Git提交次数: $commits"
    echo "   🌐 远程仓库: $(git remote get-url origin 2>/dev/null || echo '未配置')"
}

# 主循环
main() {
    while true; do
        show_menu
        read -p "请选择操作 [0-8]: " choice
        
        case $choice in
            1) start_volume1 ;;
            2) show_progress ;;
            3) show_characters ;;
            4) show_agents ;;
            5) sync_github ;;
            6) create_outline ;;
            7) run_checks ;;
            8) show_stats ;;
            0) echo "👋 再见！"; exit 0 ;;
            *) echo "❌ 无效选择，请重试" ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
        echo ""
    done
}

# 如果直接运行，显示菜单
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main
fi
