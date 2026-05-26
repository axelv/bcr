# Tiro FHIR IG template — fork basis

This template is a fork of **fhir.base.template** with four file overrides
and two `config.json` additions on top.

## Current base

| | |
|---|---|
| Package | `fhir.base.template` |
| Version | `current` (snapshot dated `2025-10-01`) |
| Forked on | `2026-05-26` |

## Custom overlay (anything outside this is base verbatim)

- `package/package.json` — replaced with `health.tiro.fhir.template` identity
- `config.json` — base verbatim *plus*:
  - `extraTemplates += [ { "name": "form", "description": "Form" } ]`
  - `defaults.Questionnaire["template-form"] = "template/layouts/layout-questionnaire-form.html"`
  - `defaults.Questionnaire["form"] = "{{[type]}}-{{[id]}}-form.html"`
- `includes/fragment-base-navtabs.html` — replaced (adds Form tab for Questionnaire)
- `liquid/Questionnaire.liquid` — new file (custom narrative)
- `layouts/layout-questionnaire-form.html` — new file (form-tab layout)
- `content/assets/js/tiro-web-sdk.iife.js` — new file (vendored Tiro Web SDK)

## Re-syncing with upstream

When upstream `fhir.base.template` releases a new version:

```bash
# 1. Save our overlay
mkdir -p /tmp/tiro-overlay
cp tiro-template/config.json                                 /tmp/tiro-overlay/
cp tiro-template/package/package.json                        /tmp/tiro-overlay/
cp tiro-template/includes/fragment-base-navtabs.html         /tmp/tiro-overlay/
cp tiro-template/liquid/Questionnaire.liquid                 /tmp/tiro-overlay/
cp tiro-template/layouts/layout-questionnaire-form.html      /tmp/tiro-overlay/
cp tiro-template/content/assets/js/tiro-web-sdk.iife.js      /tmp/tiro-overlay/

# 2. Re-fork
rm -rf tiro-template
cp -R ~/.fhir/packages/fhir.base.template#<new-version> tiro-template

# 3. Restore the overlay
cp /tmp/tiro-overlay/fragment-base-navtabs.html         tiro-template/includes/
cp /tmp/tiro-overlay/Questionnaire.liquid               tiro-template/liquid/
cp /tmp/tiro-overlay/layout-questionnaire-form.html     tiro-template/layouts/
cp /tmp/tiro-overlay/package.json                       tiro-template/package/
mkdir -p tiro-template/content/assets/js
cp /tmp/tiro-overlay/tiro-web-sdk.iife.js               tiro-template/content/assets/js/

# 4. Re-apply the config.json additions (jq):
jq '
  .extraTemplates += [{"name":"form","description":"Form"}]
  | .defaults.Questionnaire["template-form"] = "template/layouts/layout-questionnaire-form.html"
  | .defaults.Questionnaire.form = "{{[type]}}-{{[id]}}-form.html"
' tiro-template/config.json > tiro-template/config.json.new
mv tiro-template/config.json.new tiro-template/config.json

# 5. Bump tiro-template/package/package.json version + update this file's
#    "Current base" version line, then rebuild.
```
