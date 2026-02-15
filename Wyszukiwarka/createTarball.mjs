import fs from 'node:fs';
import { PGlite } from './pglite/dist/index.js'
import { vector } from './pglite/dist/vector/index.js';
const db = new PGlite({
  extensions: { vector }
});
await db.exec(`CREATE TABLE IF NOT EXISTS transcriptions (date date, source text, transcription text);`);
await db.query(
          `COPY transcriptions FROM '/dev/blob' WITH DELIMITER '~' QUOTE E'\b' NULL AS '' CSV;`,
          [],
          {
            blob: new Blob([fs.readFileSync('./pliki', {encoding: 'utf8'})]),
          }
        );
await db.exec(`BEGIN;
      CREATE TEXT SEARCH CONFIGURATION public.polish ( COPY = pg_catalog.english );

      CREATE TEXT SEARCH DICTIONARY polish_ispell (
        TEMPLATE = ispell,
        DictFile = polish,
        AffFile = polish,
        StopWords = polish
      );

      ALTER TEXT SEARCH CONFIGURATION polish
        ALTER MAPPING FOR asciiword, asciihword, hword_asciipart, word, hword, hword_part
        WITH polish_ispell;
COMMIT;
`);
await db.exec(`alter table transcriptions add search tsvector generated always as (to_tsvector('polish', transcription)) STORED;`);
const file = await db.dumpDataDir();
fs.writeFileSync(file.name, Buffer.from(await file.arrayBuffer()));
