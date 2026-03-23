const fs = require('fs');
const path = require('path');
const Epub = require('epub-generator');

// 配置信息
const config = {
  title: '不可重置的3秒',
  author: '奔跑的蜗牛',
  cover: null, // 没有封面可以不设置
  output: './不可重置的3秒.epub'
};

// 按卷收集章节
const volumes = [
  {
    title: '第一卷 - 深海来信',
    dir: '02-正文/第一卷-深海来信'
  },
  {
    title: '第二卷 - 失控边缘',
    dir: '02-正文/第二卷-失控边缘'
  },
  {
    title: '第三卷 - 清零日',
    dir: '02-正文/第三卷-清零日'
  },
  {
    title: '第四卷 - 北极对决',
    dir: '02-正文/第四卷-北极对决'
  },
  {
    title: '第五卷 - 深空幽暗',
    dir: '02-正文/第五卷-深空幽暗'
  },
  {
    title: '第六卷 - 反向入侵',
    dir: '02-正文/第六卷-反向入侵'
  },
  {
    title: '终章 - 留下的线索',
    dir: '02-正文/终章-留下的线索'
  }
];

// 生成章节列表
function generateContent() {
  let content = [];
  
  // 添加封面/扉页
  content.push({
    title: '封面',
    data: `<h1>${config.title}</h1><p style="text-align: center;">作者：${config.author}</p>`
  });
  
  content.push({
    title: '前言',
    data: `<p>《不可重置的3秒》</p>
    <p>项目启动日期：2026-03-21</p>
    <p>完成日期：2026-03-23</p>
    <p>记住：每个人做决定前，停顿三秒，问自己：这真的是我想要的吗？</p>`
  });

  // 按卷添加章节
  volumes.forEach(volume => {
    // 添加卷标题
    content.push({
      title: volume.title,
      data: `<h1>${volume.title}</h1>`
    });

    // 读取该卷下所有markdown文件，按章节号排序
    const files = fs.readdirSync(volume.dir)
      .filter(file => file.endsWith('.md'))
      .sort((a, b) => {
        // 提取章节号排序
        const numA = parseInt(a.match(/第(\d+)章/)[1]);
        const numB = parseInt(b.match(/第(\d+)章/)[1]);
        return numA - numB;
      });

    files.forEach(file => {
      const filePath = path.join(volume.dir, file);
      const markdown = fs.readFileSync(filePath, 'utf8');
      // 简单转换markdown标题到html
      let html = markdown
        .replace(/^# (.*)$/gm, '<h1>$1</h1>')
        .replace(/^## (.*)$/gm, '<h2>$1</h2>')
        .replace(/^### (.*)$/gm, '<h3>$1</h3>')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/\n/g, '<br>');
      
      // 提取章节标题
      const titleMatch = file.match(/第\d+[章-](.*)\.md/);
      const chapterTitle = titleMatch ? titleMatch[1] : file.replace('.md', '');
      const fullTitle = `${volume.title} - ${file.replace('.md', '')}`;

      content.push({
        title: fullTitle,
        data: html
      });
    });
  });

  return content;
}

// 主函数
async function main() {
  console.log('开始生成epub...');
  console.log(`书名：${config.title}`);
  console.log(`作者：${config.author}`);

  const content = generateContent();
  console.log(`共 ${content.length} 个章节/部分`);

  const epub = new Epub({
    title: config.title,
    author: config.author,
    cover: config.cover,
    content: content
  });

  const buffer = await epub.generate();
  fs.writeFileSync(config.output, buffer);
  console.log(`epub已生成：${config.output}`);
  console.log('完成！');
}

main().catch(err => {
  console.error('生成失败：', err);
  process.exit(1);
});
