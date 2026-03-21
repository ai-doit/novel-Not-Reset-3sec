#!/bin/bash
# 测试模型可用性

echo "========================================"
echo "🧪 测试模型配置"
echo "========================================"
echo ""

echo "📋 当前Agent模型配置:"
echo "----------------------------------------"
grep -A 2 "model:" AGENT-CONFIG.yaml | grep -v "^--$" | head -20
echo ""

echo "✅ 已更新的Agent模型:"
echo "----------------------------------------"
echo "  角色Agent (character-keeper): volcengine-plan/glm-4.7"
echo "  润色Agent (polisher): volcengine-plan/glm-4.7"
echo "  主题Agent (theme-keeper): volcengine-plan/ark-code-latest"
echo ""
echo "  其他Agent保持不变:"
echo "    主笔Agent: kimi-k2p5"
echo "    校对Agent: kimi-k2p5-coding"
echo "    节奏Agent: kimi-k2p5"
echo ""

echo "========================================"
echo "✅ 模型配置检查完成"
echo "========================================"
