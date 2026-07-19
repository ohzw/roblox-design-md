// Syncs canonical documents into standalone skill reference bundles. The
// screenshot extraction and react-lua implementation skills receive the
// DESIGN.roblox.md spec and zero-dependency linter. The visual-design skill
// receives the evidence-backed design rulebook, registry, and source index.
// Users who install one skill do not have the rest of this repository.
//
// Run after editing the canonical spec, linter, or design-rule documents:
//
//   node tools/sync-skill-bundles.mjs
//
// Repository-root files remain the single sources of truth; the bundles are
// generated copies with provenance headers.
import fs from "node:fs";
import path from "node:path";
import { execSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const HEADER =
  "<!-- GENERATED BUNDLE — do not edit. Canonical source: repository root.\n" +
  "     Regenerate with: node tools/sync-skill-bundles.mjs -->\n\n";
const YAML_HEADER =
  "# GENERATED BUNDLE — do not edit. Canonical source: spec/spec-config.yaml.\n" +
  "# Regenerate with: node tools/sync-skill-bundles.mjs\n";

const SKILLS = ["skills/screenshot-to-designmd", "skills/designmd-to-react-lua"];
const DESIGN_SKILL = "skills/roblox-ui-design";

// Single-file linter bundle (js-yaml inlined by esbuild) so standalone skill
// installs can lint with plain `node lint.bundle.mjs <file>` — it resolves
// the bundled spec at ../spec/spec-config.yaml automatically (see lint.mjs
// SPEC_CANDIDATES).
const linterDir = path.join(ROOT, "tools", "linter");
const bundleOut = path.join(linterDir, "lint.bundle.mjs");
execSync(
  `npx esbuild lint.mjs --bundle --platform=node --format=esm --outfile=${JSON.stringify(bundleOut)} --banner:js="// GENERATED BUNDLE - do not edit. Source: tools/linter/lint.mjs. Regenerate: node tools/sync-skill-bundles.mjs"`,
  { cwd: linterDir, stdio: "pipe" }
);

for (const skill of SKILLS) {
  const dest = path.join(ROOT, skill, "references", "spec");
  fs.mkdirSync(dest, { recursive: true });
  fs.writeFileSync(
    path.join(dest, "SPEC.md"),
    HEADER + fs.readFileSync(path.join(ROOT, "SPEC.md"), "utf8")
  );
  fs.writeFileSync(
    path.join(dest, "spec-config.yaml"),
    YAML_HEADER + fs.readFileSync(path.join(ROOT, "spec", "spec-config.yaml"), "utf8")
  );
  const linterDest = path.join(ROOT, skill, "references", "linter");
  fs.mkdirSync(linterDest, { recursive: true });
  fs.copyFileSync(bundleOut, path.join(linterDest, "lint.bundle.mjs"));
  console.log(`synced spec + linter bundle -> ${skill}/references/`);
}
const designReferences = path.join(ROOT, DESIGN_SKILL, "references");
fs.mkdirSync(designReferences, { recursive: true });
const designRulesBundle = fs
  .readFileSync(
    path.join(ROOT, "docs", "roblox-ui-rules", "design-rules.md"),
    "utf8"
  )
  .replace("./design-sources.md", "./sources.md")
  .replace(
    "、実装・engine側のルールは [`rules.md`](./rules.md) を参照する。",
    "。"
  );
fs.writeFileSync(
  path.join(designReferences, "design-rules.md"),
  HEADER + designRulesBundle
);
fs.copyFileSync(
  path.join(ROOT, "docs", "roblox-ui-rules", "design-registry.json"),
  path.join(designReferences, "design-registry.json")
);
fs.writeFileSync(
  path.join(designReferences, "sources.md"),
  HEADER +
    fs.readFileSync(
      path.join(ROOT, "docs", "roblox-ui-rules", "design-sources.md"),
      "utf8"
    )
);
console.log(`synced design rule bundle -> ${DESIGN_SKILL}/references/`);
fs.rmSync(bundleOut); // intermediate; the shipped copies live in the skills
