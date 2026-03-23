// اسکریپت دانلود با Node.js - اجرا: node download-node.js
const https = require('https');
const fs = require('fs');
const path = require('path');

const dir = __dirname;

function download(url, filepath) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(filepath);
    https.get(url, (res) => {
      res.pipe(file);
      file.on('finish', () => { file.close(); resolve(); });
    }).on('error', (err) => { fs.unlink(filepath, () => {}); reject(err); });
  });
}

async function main() {
  try {
    console.log('در حال دانلود three.min.js...');
    await download('https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js', path.join(dir, 'three.min.js'));
    console.log('three.min.js دانلود شد.');
    
    console.log('در حال دانلود tailwind.js...');
    await download('https://cdn.tailwindcss.com', path.join(dir, 'tailwind.js'));
    console.log('tailwind.js دانلود شد.');
    
    console.log('تمام شد.');
  } catch (e) {
    console.error('خطا:', e.message);
    process.exit(1);
  }
}

main();
