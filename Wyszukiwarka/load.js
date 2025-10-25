const fs = require('fs');

const dir = fs.opendirSync('../transcriptions_txt')
let dirent
while ((dirent = dir.readSync()) !== null) {
  const data = fs.readFileSync(`../transcriptions_txt/${dirent.name}`, { encoding: 'utf8', flag: 'r' }).replace("'", "''");;
  console.log(`${dirent.name};${data}`);
}
dir.closeSync()
