# Obsidian 插件配置指南

> 本指南介绍如何配置Obsidian以支持《不可重置的3秒》小说创作项目

---

## 📦 必备插件清单

### 核心插件（必须安装）

| 插件名称                | 用途     | 安装方式     | 配置建议     |
| ------------------- | ------ | -------- | -------- |
| **Git**             | 版本控制同步 | 社区插件     | 启用自动备份   |
| **Version History** | 文件版本历史 | 社区插件     | 保留所有历史版本 |
| **Backlinks**       | 反向链接   | 核心插件（内置） | 自动启用     |
| **File Explorer**   | 文件管理   | 核心插件（内置） | 启用文件夹排序  |

### 辅助插件（强烈推荐）

| 插件名称                | 用途        | 安装方式 | 配置建议           |
| ------------------- | --------- | ---- | -------------- |
| **Advanced Tables** | 制作伏笔表/人物表 | 社区插件 | 启用Markdown表格支持 |
| **Templater**       | 创建章节模板    | 社区插件 | 设置模板文件夹        |
| **Dataview**        | 查询小说数据    | 社区插件 | 启用JS查询         |
| **Kanban**          | 写作进度看板    | 社区插件 | 创建看板视图         |
| **Style Settings**  | 自定义文字格式   | 社区插件 | 设置阅读字体/字号      |
| **Admonition**      | 标注章节细节    | 社区插件 | 启用自定义样式        |

---

## 🔧 详细配置步骤

### 步骤1: 启用核心插件

1. 打开 Obsidian
2. 点击左下角的 **设置（齿轮图标）**
3. 选择 **核心插件**
4. 启用以下插件：
   - ☑️ 反向链接（Backlinks）
   - ☑️ 文件列表（File Explorer）
   - ☑️ 搜索（Search）
   - ☑️ 快速切换（Quick Switcher）
   - ☑️ 命令面板（Command Palette）

### 步骤2: 安装社区插件

#### 安装 Git 插件

1. 进入 **设置 → 社区插件**
2. 点击 **浏览**，搜索 "Git"
3. 安装 **Obsidian Git** 插件
4. 启用插件
5. 配置 Git 插件：
   ```yaml
   # 设置 → 社区插件 → Obsidian Git → Options
   
   Vault backup interval (minutes): 30
   Auto backup after file change: true
   Auto pull on startup: true
   Auto pull interval (minutes): 60
   Commit message: "backup: {{date}}"
   ```

#### 安装 Version History 插件

1. 在社区插件中搜索 "Version History"
2. 安装并启用
3. 配置保留策略：
   ```yaml
   # 保留所有版本，不自动清理
   Retention policy: Keep all versions
   ```

#### 安装 Templater 插件（用于章节模板）

1. 在社区插件中搜索 "Templater"
2. 安装并启用
3. 配置模板文件夹：
   ```yaml
   # 设置 → 社区插件 → Templater → Template folder location
   Template folder: 05-工具/写作模板
   ```

#### 安装其他推荐插件

重复上述步骤，安装以下插件：
- Advanced Tables
- Dataview
- Kanban
- Style Settings
- Admonition

### 步骤3: 配置 Vault 设置

1. **文件与链接**
   ```yaml
   # 设置 → 文件与链接
   
   Confirm line deletion: true
   Strict line breaks: false
   Convert 
   
   to <br>: false
   Use \n instead of spaces: false
   Default view for new tabs: Editing view
   Open internal links in new tabs: false
   Use Wikilinks: true
   New link format: Shortest path when possible
   Automatically update internal links: true
   ```

2. **外观**
   ```yaml
   # 设置 → 外观
   
   Base color scheme: Dark (推荐深色模式，更适合长时间写作)
   Accent color: #007AFF (蓝色，适合科幻主题)
   Interface font: system-ui
   Text font: "Noto Serif SC", "Source Han Serif SC", serif (中文字体)
   Monospace font: "JetBrains Mono", "Fira Code", monospace (代码字体)
   Font size: 18px
   Line height: 1.8
   ```

3. **热键（快捷键）**
   ```yaml
   # 设置 → 热键
   
   推荐配置的快捷键:
   - Ctrl/Cmd + N: 新建笔记
   - Ctrl/Cmd + Shift + N: 从模板新建笔记
   - Ctrl/Cmd + O: 快速切换
   - Ctrl/Cmd + Shift + F: 全局搜索
   - Ctrl/Cmd + E: 切换编辑/预览模式
   - Ctrl/Cmd + G: 打开Git面板（需安装Git插件）
   ```

### 步骤4: 创建核心笔记模板

1. **章节模板**（已创建: `05-工具/写作模板/章节模板.md`）

2. **人物卡片模板**
   在 `05-工具/写作模板/` 创建 `人物卡片.md`:
   ```markdown
   ---
   name: {{姓名}}
   role: {{角色定位}}
   volume: {{首次出场卷}}
   ---

   # {{姓名}}

   ## 基本信息
   - **年龄**: 
   - **职业**: 
   - **外貌**: 

   ## 核心设定
   
   ## 性格特征
   
   ## 人物弧光
   
   ## 关系网络
   
   ## 关键台词
   
   ## 备注
   ```

3. **伏笔记录模板**
   在 `05-工具/写作模板/` 创建 `伏笔记录.md`:
   ```markdown
   ---
   clue_id: {{线索编号}}
   type: {{类型: 3秒伏笔/三源线索/三层真相}}
   status: {{状态: 已埋置/已回收/待回收}}
   ---

   # 伏笔: {{标题}}

   ## 埋置位置
   - **卷**: 
   - **章节**: 
   - **场景**: 

   ## 回收位置
   - **卷**: 
   - **章节**: 
   - **方式**: 

   ## 描述

   ## 关联线索

   ## 备注
   ```

---

## 🚀 快速启动检查清单

安装完所有插件并配置后，使用此检查清单验证环境是否就绪：

- [ ] Obsidian已打开《不可重置的3秒》Vault
- [ ] Git插件已启用并配置自动备份（30分钟）
- [ ] Version History插件已启用
- [ ] Templater插件已配置模板文件夹（05-工具/写作模板）
- [ ] 目录结构完整（检查00-05文件夹都存在）
- [ ] 章节模板、人物卡片模板、伏笔记录模板已创建
- [ ] GitHub远程仓库已配置并可正常push
- [ ] 外观设置已调整（深色模式、中文字体、行高1.8）
- [ ] 热键已配置（新建、搜索、Git面板等）

**全部勾选后，环境搭建完成，可以开始创作！**

---

## 📚 进阶配置（可选）

### 使用 Dataview 查询创作进度

在 `00-项目管理/` 创建 `Dataview查询示例.md`:

```markdown
# 创作进度Dataview查询

## 各卷章节数量
```dataview
TABLE length(file.inlinks) as "章节数"
FROM "02-正文"
GROUP BY file.folder
```

## 待审核章节
```dataview
TABLE file.mtime as "修改时间"
FROM "03-草稿与修改"
WHERE status = "待审核"
```

## 3秒伏笔统计
```dataview
TABLE type, status, 埋置位置, 回收位置
FROM "03-伏笔线索追踪"
WHERE type = "3秒伏笔"
```
```

### 使用 Kanban 管理写作流程

1. 安装 Kanban 插件
2. 在 `00-项目管理/` 创建 `写作看板.md`:

```markdown
---

kanban-plugin: basic

---

## 待创作

- [ ] 第001章-七千米
- [ ] 第002章-便利的代价
- [ ] 第003章-妻子的画

## 创作中

- [ ] 

## 审核中

- [ ] 

## 已完成

- [ ] 

## 待修改

- [ ] 

---
```

---

## 🆘 故障排除

### 常见问题

#### Q1: Git插件无法自动备份
**A**: 检查Git是否正确安装，以及Vault是否在Git仓库中
```bash
cd /Users/zhangliqin/Documents/novel-Not-Reset-3sec
git status
```

#### Q2: Templater模板不生效
**A**: 检查模板文件夹路径设置，确保路径为 `05-工具/写作模板`

#### Q3: 中文显示不正常
**A**: 在外观设置中选择支持中文的字体，如 "Noto Serif SC" 或 "Source Han Serif SC"

#### Q4: Obsidian启动慢
**A**: 禁用不用的社区插件，定期清理 `.obsidian/cache` 文件夹

---

*本指南最后更新: 2026-03-21*
