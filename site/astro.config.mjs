import { defineConfig } from "astro/config";

// Static output; the repo's design-md/ directory is the data source
// (read at build time by src/lib/catalog.mjs, assets synced by scripts/sync-data.mjs).
export default defineConfig({
  output: "static",
});
