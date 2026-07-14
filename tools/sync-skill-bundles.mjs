// Syncs the canonical spec into each skill's references/spec/ bundle so the
// skills work STANDALONE when installed via `npx skills add` (users who
// install a skill don't have this repository). Run after editing SPEC.md or
// spec/spec-config.yaml, before committing:
//
//   node tools/sync-skill-bundles.mjs
//
// The repo-root files remain the single source of truth; the bundles are
// generated copies with a provenance header.
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const HEADER =
  "<!-- GENERATED BUNDLE — do not edit. Canonical source: repository root.\n" +
  "     Regenerate with: node tools/sync-skill-bundles.mjs -->\n\n";
const YAML_HEADER =
  "# GENERATED BUNDLE — do not edit. Canonical source: spec/spec-config.yaml.\n" +
  "# Regenerate with: node tools/sync-skill-bundles.mjs\n";

const SKILLS = ["skills/screenshot-to-designmd", "skills/designmd-to-react-lua"];

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
  console.log(`synced spec bundle -> ${skill}/references/spec/`);
}
