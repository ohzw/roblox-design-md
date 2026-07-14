import { defineConfig } from "astro/config";

// Static output; the repo's design-md/ directory is the data source
// (read at build time by src/lib/catalog.mjs, assets synced by scripts/sync-data.mjs).
// Deployed as a GitHub Pages project site, so every root-absolute URL in the
// app needs the /roblox-design-md base prefix — see BASE_URL usage across
// src/layouts and src/pages.
export default defineConfig({
  output: "static",
  site: "https://ohzw.github.io",
  base: "/roblox-design-md",
});
