# GitHub Actions 自动同步配置

> 配置GitHub Actions实现自动备份和同步

---

## 📋 配置步骤

### 步骤1: 创建GitHub Actions工作流

在项目中创建 `.github/workflows/sync.yml`:

```bash
mkdir -p /Users/derek/Documents/novel-不可重置的3秒/.github/workflows
cat > /Users/derek/Documents/novel-不可重置的3秒/.github/workflows/sync.yml << 'EOF'
name: Auto Sync to GitHub

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    # 每6小时自动备份一次
    - cron: '0 */6 * * *'
  workflow_dispatch:  # 允许手动触发

jobs:
  sync:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3
      with:
        fetch-depth: 0
    
    - name: Set up Git
      run: |
        git config --global user.name 'github-actions[bot]'
        git config --global user.email 'github-actions[bot]@users.noreply.github.com'
    
    - name: Sync to backup branch
      run: |
        # 创建备份分支
        git checkout -b backup/$(date +%Y%m%d-%H%M%S) || true
        git push origin backup/$(date +%Y%m%d-%H%M%S) || true
        
    - name: Update stats
      run: |
        # 生成统计信息
        echo "# 创作统计" > stats.md
        echo "" >> stats.md
        echo "- 最后更新: $(date)" >> stats.md
        echo "- 总文件数: $(find . -type f -name '*.md' | wc -l)" >> stats.md
        echo "- 总字数: $(find . -type f -name '*.md' -exec cat {} \; | wc -m)" >> stats.md
        
        git add stats.md
        git commit -m "Update stats [skip ci]" || true
        git push || true
    
    - name: Notify (optional)
      if: failure()
      run: |
        echo "::warning:: Sync failed, please check manually"
EOF
```

### 步骤2: 提交GitHub Actions配置

```bash
cd /Users/derek/Documents/novel-不可重置的3秒
git add .github/workflows/sync.yml
git commit -m "添加GitHub Actions自动同步工作流"
git push origin main
```

### 步骤3: 验证Actions工作流

1. 访问 GitHub 仓库: `https://github.com/ai-doit/不可重置的3秒`
2. 点击 **Actions** 标签
3. 确认工作流 **Auto Sync to GitHub** 已显示
4. 点击 **Run workflow** 手动触发一次测试

---

## ⚙️ 高级配置

### 配置自动部署到备份仓库（可选）

如果需要同步到第二个备份仓库：

```yaml
# 在 .github/workflows/sync.yml 中添加:

    - name: Sync to backup repository
      uses: wearerequired/git-mirror-action@master
      env:
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
      with:
        source-repo: "git@github.com:ai-doit/不可重置的3秒.git"
        destination-repo: "git@github.com:ai-doit-backup/不可重置的3秒.git"
```

### 配置Slack/飞书通知（可选）

```yaml
# 在 workflow 末尾添加:

    - name: Send notification to Feishu
      if: always()
      run: |
        curl -X POST -H "Content-Type: application/json" \
          -d '{
            "msg_type": "text",
            "content": {
              "text": "小说项目同步状态: ${{ job.status }}\n时间: ${{ github.event.head_commit.timestamp }}\n提交: ${{ github.event.head_commit.message }}"
            }
          }' \
          ${{ secrets.FEISHU_WEBHOOK_URL }}
```

---

## 🐛 故障排除

### 常见问题

#### Q1: Actions工作流没有触发
**解决方案**:
```bash
# 检查workflow文件语法
cd /Users/derek/Documents/novel-不可重置的3秒
.github/workflows/sync.yml

# 确保文件已提交
git log --oneline .github/workflows/
```

#### Q2: 权限错误
**解决方案**:
1. 检查GitHub仓库的Actions权限:
   - Settings → Actions → General → Workflow permissions
   - 选择 "Read and write permissions"

2. 如果是私有仓库，确保有足够的Actions运行时间

#### Q3: 同步到备份仓库失败
**解决方案**:
```bash
# 检查SSH密钥配置
git remote -v

# 测试SSH连接
ssh -T git@github.com
```

---

## 📊 监控和日志

### 查看Actions运行日志

1. 访问 GitHub 仓库
2. 点击 **Actions** 标签
3. 选择最近的一次运行
4. 点击具体的工作步骤查看详细日志

### 本地查看同步状态

```bash
cd /Users/derek/Documents/novel-不可重置的3秒

# 查看最近的提交
git log --oneline -10

# 查看当前状态
git status

# 查看与远程的差异
git diff origin/main --stat
```

---

*本配置最后更新: 2026-03-22*
