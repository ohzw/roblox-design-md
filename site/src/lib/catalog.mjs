// Build-time loader: parses every design-md/<slug>/DESIGN.roblox.md into a
// catalog entry. The YAML front matter doubles as the site's metadata source
// (no separate manifest — same architecture as getdesign.md).
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import yaml from "js-yaml";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const DATA = path.resolve(__dirname, "../../../design-md");

export function loadCatalog() {
  const entries = [];
  for (const slug of fs.readdirSync(DATA)) {
    const dir = path.join(DATA, slug);
    const mdPath = path.join(dir, "DESIGN.roblox.md");
    if (!fs.statSync(dir).isDirectory() || !fs.existsSync(mdPath)) continue;

    const raw = fs.readFileSync(mdPath, "utf8");
    const m = raw.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?/);
    const fm = m ? yaml.load(m[1]) : {};
    const body = m ? raw.slice(m[0].length) : raw;

    const previewsDir = path.join(dir, "previews");
    const previews = fs.existsSync(previewsDir)
      ? fs.readdirSync(previewsDir).filter((f) => /\.(png|jpg|jpeg|webp)$/i.test(f)).sort()
      : [];

    entries.push({
      slug,
      name: fm.name ?? slug,
      description: (fm.description ?? "").trim(),
      taste: fm.taste ?? [],
      genre: fm.genre ?? [],
      colors: fm.colors ?? {},
      typography: fm.typography ?? {},
      componentCount: Object.keys(fm.components ?? {}).length,
      confidence: fm.extraction?.confidence ?? null,
      raw,
      body,
      previews,
      published: previews.length > 0, // publish gate: no real-device preview, no listing badge
    });
  }
  return entries.sort((a, b) => a.slug.localeCompare(b.slug));
}
