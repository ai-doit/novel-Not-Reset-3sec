const fs = require('fs');
const path = require('path');

// 定义卷的顺序
const volumes = [
  '第一卷-深海来信',
  '第二卷-失控边缘', 
  '第三卷-清零日',
  '第四卷-北极对决',
  '第五卷-深空幽暗',
  '第六卷-反向入侵',
  '终章-留下的线索'
];

let allContent = '';

volumes.forEach(volume => {
  const volumePath = path.join('02-正文', volume);
  if (fs.existsSync(volumePath)) {
    const files = fs.readdirSync(volumePath)
      .filter(f => f.endsWith('.md'))
      .sort((a, b) => {
        const numA = parseInt(a.match(/第(\d+)章/)[1]);
        const numB = parseInt(b.match(/第(\d+)章/)[1]);
        return numA - numB;
      });
    
    files.forEach(file => {
      const filePath = path.join(volumePath, file);
      const content = fs.readFileSync(filePath, 'utf8');
      allContent += content + '\n\n';
      console.log(`Added: ${file}`);
    });
  }
});

fs.writeFileSync('不可重置的3秒-完整.md', allContent, 'utf8');
console.log('Merged completed!');
