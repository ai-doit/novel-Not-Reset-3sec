# Agent操作手册

> OpenClaw多Agent协作系统的详细操作指南

---

## 1. 启动和停止Agent

### 启动单个Agent
```bash
openclaw agent run main-writer
openclaw agent run main-writer --chapters 001,002,003
```

### 停止Agent
```bash
openclaw agent stop main-writer
openclaw agent stop-all
```

## 2. 监控Agent状态

```bash
openclaw agent list
openclaw agent status main-writer
openclaw agent logs main-writer --tail 100
```

## 3. 常见问题

### Q: Agent卡住怎么办？
```bash
openclaw agent stop main-writer --force
openclaw agent restart main-writer
```

### Q: 如何重新生成不满意的章节？
```bash
openclaw agent run main-writer --chapter 001 --temperature 0.9
```

---
*完整文档请参考项目Wiki*
