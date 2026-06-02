# Tiro Form Filler integration

Status of the `<tiro-form-filler>` web-component integration on Questionnaire
resource pages in this IG.

## What it does

Every `Questionnaire` resource page in the IG gets an extra **Form** tab next
to the standard Narrative / XML / JSON / TTL tabs. The Form tab renders the
questionnaire live in the browser using the
[Tiro.health Web SDK](https://sdk.tiro.health), so reviewers can interact with
the form (enter values, navigate tabs, see validation) without leaving the IG
site.

Wired up for every Questionnaire in the IG via a shared external IG
template — [`Tiro-health/ig-template-fhir`](https://github.com/Tiro-health/ig-template-fhir)
(package `tiro-health.fhir.template`). Adding a new Questionnaire in FSH is
enough; the form tab and form page appear automatically on the next build.

## How it's wired together

`ig.ini` references the shared template by GitHub URL:

```
template = https://github.com/Tiro-health/ig-template-fhir
```

That template is a **thin overlay** on `fhir.base.template` (declared via
`"base": "fhir.base.template"` in its `package/package.json`). It adds Tiro
branding plus the Form-tab feature; everything else is inherited from the
base template at build time. The relevant overlay files (in the *template*
repo, not this IG):

| File (in ig-template-fhir) | Role |
|---|---|
| `config.json` | Full base config + `extraTemplates.form` + Questionnaire `template-form`/`form` defaults. |
| `layouts/layout-questionnaire-form.html` | Instantiated per Questionnaire → `Questionnaire-{id}-form.html`. |
| `includes/fragment-base-navtabs.html` | Form tab in the resource tab strip (Questionnaire only). |
| `liquid/Questionnaire.liquid` | Custom narrative. |
| `content/assets/js/tiro-web-sdk.iife.js` | Vendored Tiro Web SDK → copied to `output/assets/js/`. |

The `extraTemplates.form` + Questionnaire `template-form` entries are what
tell IG Publisher: "for every Questionnaire resource, also generate a
`-form.html` page." It's the same mechanism that produces `-testing.html`
for every resource.

Build pipeline:

1. **SUSHI** compiles FSH → `fsh-generated/resources/`.
2. **IG Publisher** fetches the template from GitHub, iterates Questionnaire
   resources, instantiates the form layout per instance, and copies
   vendored static assets to `output/`.

No project-level overrides under `input/` are needed. No generator scripts.
No SDK fetch script. The form page references the SDK via the same-origin
relative URL `<script src="assets/js/tiro-web-sdk.iife.js"> </script>` —
exactly what the IG Publisher's HTMLInspector requires.

> **Why the template ships the *full* config (not just the two additions):**
> IG Publisher merges a `base` template's `config.json` into the overlay's
> for **local-directory** templates, but **not** for **github-fetched**
> templates (the overlay config replaces the base's). Shipping the complete
> config makes the result correct regardless of fetch mode.

## Adding a new Questionnaire

1. Write a new `Instance: … InstanceOf: Questionnaire` in FSH (add
   `* title = "..."` so the form page gets a readable title).
2. Run `./_genonce.sh` (or push and let CI run).

That's it — the Form tab and form page appear automatically. No
`sushi-config.yaml` edits, no pagecontent files to hand-write.

## The shared template

The template lives at `Tiro-health/ig-template-fhir` and is maintained
separately (see its `README.md`). It's consumed by this IG and others
(e.g. atticus) by the same `ig.ini` GitHub-URL reference. Updating the
template benefits all consumers on their next build.

## Custom narrative

The template's `liquid/Questionnaire.liquid` overrides the default narrative
generator. It walks the resource via FHIRPath-aware Liquid (e.g.
`Questionnaire.item.required = true`, `sub.answerValueSet.exists()`) and
emits a structured `<ul>` of items with required markers and value-set
links. Applies to **every** Questionnaire.

## Files involved

| Path | Purpose |
|---|---|
| `input/fsh/questionnaires/BCRCancerRegistrationFormQuestionnaire.fsh` | Canonical questionnaire definition. ~30 items mirroring the Cancer Registration Form, with `definition` URIs pointing at the `bcr-cancer-registration-form` logical model. Carries SDC extraction (`itemExtractionContext`) and population (`launchContext` + `initialExpression`) extensions. |
| `tiro-template/` | Forked IG template package (from `fhir.base.template`). Contains all build machinery. |
| `tiro-template/package/package.json` | Template identity: `health.tiro.fhir.template@0.1.0`, `based-on: fhir.base.template`. |
| `ig.ini` | `template = https://github.com/Tiro-health/ig-template-fhir`. |
| `sushi-config.yaml` | `fhirVersion: 4.0.1`, dependency `hl7.fhir.uv.extensions.r4`; `special-url` whitelists the Tiro CodeSystem canonical. |
| `input/fsh/codesystems/TiroItemControl.fsh` | Defines the `tiro-item-control` CodeSystem (`tab`, `block`) so the renderer's itemControl codes validate. |
| `input/ignoreWarnings.txt` | No suppressions needed (the former `tab` suppression is obsolete). |
| `_genonce.sh`, `.github/workflows/ig-publisher.yml` | Build orchestration: SUSHI → IG Publisher. |

All the template machinery (layout, navtabs override, narrative, SDK,
config) lives in the **`Tiro-health/ig-template-fhir`** repo — not in this
IG. This IG just references it.

## itemControl extensions

Each top-level group in the questionnaire carries a
`questionnaire-itemControl` extension with **two** codings:

| System | Code | Purpose |
|---|---|---|
| `http://fhir.tiro.health/CodeSystem/tiro-item-control` | `tab` | Render this group as a tab in the form. |
| `http://fhir.tiro.health/CodeSystem/tiro-item-control` | `block` | Tiro-specific layout hint. |

The Tiro renderer reads both and displays the four top-level groups (Patient
identification, Tumour identification & staging, Diagnosis & treatments,
Attachments) as tabs.

Both codes live on the Tiro `tiro-item-control` CodeSystem
(`input/fsh/codesystems/TiroItemControl.fsh`). `tab` previously sat on the core
`http://hl7.org/fhir/questionnaire-item-control` system as a "standard SDC hint",
but that code does not exist in FHIR R4 (R4 core defines only
`group`/`question`/`text`), so on R4 it is hosted on the Tiro system instead.

## Known issues and caveats

1. **HL7 ci-build incompatibility.** The HTMLInspector flags the inline FHIR
   JSON `<script type="application/fhir+json">` and the custom element
   `<tiro-form-filler>` (unknown HTML tag). These are warnings on a private
   build but would become errors on `ci.fhir.org`. The SDK itself is now
   vendored same-origin so it no longer triggers a script-src error.
2. **SDC `$populate` returns 422.** The Tiro SDC backend at
   `sdc.tiro.health/fhir/r5` does not recognize our canonical
   (`…/Questionnaire/BCRCancerRegistrationFormQuestionnaire`) and rejects pre-population.
   The form still renders fully editable — only auto-population fails.
3. **Template version pinning.** `ig.ini` references the template by plain
   GitHub URL, which resolves to the default branch (`master`). Builds float
   on whatever's on `master`. Pin to a tag/release if reproducibility matters.

## Things still to consider

- Migrate the extraction extension from `itemExtractionContext` (STU4) to
  `definitionExtract` once `hl7.fhir.uv.sdc` ships a FHIR R5 / STU5 release,
  and drop the corresponding `ignoreWarnings.txt` suppressions.
- Decide where the Tiro item-control CodeSystem
  (`http://fhir.tiro.health/CodeSystem/tiro-item-control`) should live: keep it
  defined per-IG (as today), treat it as an external dependency, or move it into
  the shared `Tiro-health/ig-template-fhir` template so every IG that uses the
  template inherits it.
- The template ships the full `fhir.base.template` config (not a partial
  overlay) because github-fetched templates don't merge base config. When
  `fhir.base.template` releases a new config, the template's `config.json`
  needs re-syncing — see the template repo's README.
