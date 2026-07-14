// Conformance tests: fixtures in spec/fixtures must produce exactly the
// expected rule hits. Run with `npm test`.
import path from "node:path";
import { fileURLToPath } from "node:url";
import { loadSpec, lintFile } from "./lint.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const fixture = (name) => path.resolve(__dirname, "../../spec/fixtures", name);
const spec = loadSpec();

let failed = 0;
const check = (label, cond, detail) => {
  if (cond) {
    console.log(`  ok - ${label}`);
  } else {
    failed++;
    console.error(`  FAIL - ${label}${detail ? `: ${detail}` : ""}`);
  }
};

{
  console.log("valid-minimal.md");
  const findings = lintFile(fixture("valid-minimal.md"), spec);
  const errors = findings.filter((f) => f.severity === "error");
  const warnings = findings.filter((f) => f.severity === "warning");
  check("zero errors", errors.length === 0, JSON.stringify(errors));
  check("zero warnings", warnings.length === 0, JSON.stringify(warnings));
}

{
  console.log("invalid-multi.md");
  const findings = lintFile(fixture("invalid-multi.md"), spec);
  const rules = (id, sev) => findings.filter((f) => f.rule === id && (!sev || f.severity === sev));
  check("duplicate-section error", rules("duplicate-section", "error").length === 1);
  check("section-order warning", rules("section-order", "warning").length === 1);
  check("broken-ref error ({colors.primary})", rules("broken-ref", "error").some((f) => f.message.includes("colors.primary")));
  check("invalid color value", rules("invalid-value", "error").some((f) => f.message.includes("colors.secondary")));
  check("banned font family", rules("invalid-value", "error").some((f) => f.message.includes("GothamBold")));
  check("bad textSize", rules("invalid-value", "error").some((f) => f.message.includes("textSize")));
  check("bad duration (150ms)", rules("invalid-value", "error").some((f) => f.message.includes("150ms")));
  check("bad easing style", rules("invalid-value", "error").some((f) => f.message.includes("Swoosh")));
  check("bad easing direction", rules("invalid-value", "error").some((f) => f.message.includes("Sideways")));
  check("typo key colours", rules("unknown-key", "warning").some((f) => f.message.includes('"colours"')));
  check("missing-primary warning", rules("missing-primary", "warning").length === 1);
  check("unknown component property", rules("unknown-component-property", "warning").some((f) => f.message.includes("bordercolor")));
  check("css-vocabulary warning (box-shadow)", rules("css-vocabulary", "warning").some((f) => f.message.includes("box-shadow")));
  check("css-vocabulary warning (margins)", rules("css-vocabulary", "warning").some((f) => f.message.includes("margins")));
}

console.log(failed === 0 ? "\nall tests passed" : `\n${failed} test(s) failed`);
process.exit(failed === 0 ? 0 : 1);
