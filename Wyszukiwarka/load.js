const fs = require('fs');

const dir = fs.opendirSync('../transcriptions_txt')
let dirent
while ((dirent = dir.readSync()) !== null) {
  const text = fs.readFileSync(`../transcriptions_txt/${dirent.name}`, { encoding: 'utf8', flag: 'r' }).replace("'", "''");
  const date = dirent.name.substring(17, 21) + "-" + dirent.name.substring(14, 16) + "-" + dirent.name.substring(11, 13);
  console.log(`${date}~${dirent.name}~${text}`);
}
dir.closeSync()
