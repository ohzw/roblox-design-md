// Copies build-time assets from the canonical data source (../design-md) into
// public/: real-device preview images and raw DESIGN.roblox.md files (for the
// download button and machine-readable access). Runs via predev/prebuild.
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const DATA = path.resolve(__dirname, "../../design-md");
const PUB = path.resolve(__dirname, "../public");

fs.rmSync(path.join(PUB, "previews"), { recursive: true, force: true });
fs.rmSync(path.join(PUB, "raw"), { recursive: true, force: true });

let entries = 0;
for (const slug of fs.readdirSync(DATA)) {
  const dir = path.join(DATA, slug);
  const md = path.join(dir, "DESIGN.roblox.md");
  if (!fs.statSync(dir).isDirectory() || !fs.existsSync(md)) continue;
  entries++;

  fs.mkdirSync(path.join(PUB, "raw"), { recursive: true });
  fs.copyFileSync(md, path.join(PUB, "raw", `${slug}.md`));

  const previews = path.join(dir, "previews");
  if (fs.existsSync(previews)) {
    const out = path.join(PUB, "previews", slug);
    fs.mkdirSync(out, { recursive: true });
    for (const f of fs.readdirSync(previews)) {
      if (/\.(png|jpg|jpeg|webp)$/i.test(f)) {
        fs.copyFileSync(path.join(previews, f), path.join(out, f));
      }
    }
  }
}
console.log(`synced ${entries} entries from design-md/`);
