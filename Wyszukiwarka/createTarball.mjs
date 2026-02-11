import fs from 'node:fs';
import { PGlite } from '@electric-sql/pglite';
import { vector } from '@electric-sql/pglite/vector';
const db = new PGlite({
  extensions: { vector }
});
await db.exec(`CREATE TABLE IF NOT EXISTS transcriptions (date date, source text, transcription text);`);
await db.query(
          `COPY transcriptions FROM '/dev/blob' WITH DELIMITER '~' CSV;`,
          [],
          {
            blob: new Blob([fs.readFileSync('./pliki', {encoding: 'utf8'})]),
          }
        );
await db.exec(`alter table transcriptions add search tsvector generated always as (to_tsvector('english', transcription)) STORED;`);
const file = await db.dumpDataDir();
console.log(file);
fs.writeFileSync(file.name, Buffer.from(await file.arrayBuffer()));
