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

Wired up for every Questionnaire in the IG via a forked IG template
(`tiro-template/`). Adding a new Questionnaire in FSH is enough — the form
tab and form page appear automatically on the next build.

## How it's wired together

The IG uses a custom in-repo template at `tiro-template/` (referenced from
`ig.ini` as `template = #tiro-template`). It is a fork of
`fhir.base.template`, with four files added/replaced:

| File | Role |
|---|---|
| `tiro-template/layouts/layout-questionnaire-form.html` | Layout IGP instantiates per Questionnaire to produce `Questionnaire-{id}-form.html`. |
| `tiro-template/includes/fragment-base-navtabs.html` | Injects the *Form* tab in the resource page tab strip (only for `type='Questionnaire'`). |
| `tiro-template/liquid/Questionnaire.liquid` | Custom narrative — walks the item tree and emits structured HTML. |
| `tiro-template/content/assets/js/tiro-web-sdk.iife.js` | Vendored Tiro Web SDK. The template copies it to `output/assets/js/` automatically. |

Two changes are made to the forked `tiro-template/config.json`:

1. **Add** `{ "name": "form", "description": "Form" }` to `extraTemplates`
2. **Add** to `defaults.Questionnaire`:
   - `"template-form": "template/layouts/layout-questionnaire-form.html"`
   - `"form": "{{[type]}}-{{[id]}}-form.html"`

These two entries are what tell IG Publisher: "for every Questionnaire
resource, also generate a `-form.html` page using
`layout-questionnaire-form.html`." It's the same mechanism that produces
`-testing.html` for every resource today.

Build pipeline is now just:

1. **SUSHI** compiles FSH → `fsh-generated/resources/`.
2. **IG Publisher** sees `template = #tiro-template`, uses the forked
   template, iterates Questionnaire resources, instantiates the form
   layout per instance, and copies vendored static assets to `output/`.

No project-level overrides under `input/` are needed any more. No
generator scripts. No SDK fetch script. The form page references the SDK
via the same-origin relative URL `<script src="assets/js/tiro-web-sdk.iife.js"> </script>` —
inside the IG, exactly what the IG Publisher's HTMLInspector requires.

## Adding a new Questionnaire

1. Write a new `Instance: … InstanceOf: Questionnaire` in FSH.
2. Run `./_genonce.sh` (or push and let CI run).

That's it — the Form tab and form page appear automatically. No
`sushi-config.yaml` edits, no pagecontent files to hand-write.

## Adopting the template in another IG

1. Copy `tiro-template/` into the new IG project (or, once published, set
   `template = health.tiro.fhir.template#0.1.0` in `ig.ini`).
2. Set `template = #tiro-template` in `ig.ini`.
3. Add `* title = "..."` to your `Questionnaire` FSH instance so the form
   page picks up a human-readable page title.
4. Build.

## Maintaining the fork

Upstream `fhir.base.template` releases are infrequent (current release
dates back to 2025-10-01). To re-sync:

1. Note the four custom files listed above (and the two config.json
   additions).
2. `cp -R ~/.fhir/packages/fhir.base.template#<new-version>/* tiro-template/`
3. Re-apply the four file overrides and the two config.json additions.
4. Bump `tiro-template/package/package.json` version, build, verify.

A `BASED-ON.md` in `tiro-template/` records the current base version for
re-sync awareness.

## Custom narrative

`tiro-template/liquid/Questionnaire.liquid` overrides the default narrative
generator. It walks the resource via FHIRPath-aware Liquid (e.g.
`Questionnaire.item.required = true`, `sub.answerValueSet.exists()`) and
emits a structured `<ul>` of items with required markers and value-set
links. The override applies to **every** Questionnaire.

## Files involved

| Path | Purpose |
|---|---|
| `input/fsh/instances/ExampleBCRDummyQuestionnaire.fsh` | Canonical questionnaire definition. ~30 items mirroring the Cancer Registration Form, with `definition` URIs pointing at the `bcr-cancer-registration-form` logical model. |
| `tiro-template/` | Forked IG template package (from `fhir.base.template`). Contains all build machinery. |
| `tiro-template/package/package.json` | Template identity: `health.tiro.fhir.template@0.1.0`, `based-on: fhir.base.template`. |
| `tiro-template/config.json` | Inherited from base + two additions: `extraTemplates.form` and Questionnaire `template-form` / `form` defaults. |
| `tiro-template/layouts/layout-questionnaire-form.html` | IGP instantiates this once per Questionnaire to produce the form page. |
| `tiro-template/includes/fragment-base-navtabs.html` | Overridden nav-tabs include — adds the Form tab for Questionnaire only. |
| `tiro-template/liquid/Questionnaire.liquid` | Custom narrative for Questionnaire resources. |
| `tiro-template/content/assets/js/tiro-web-sdk.iife.js` | Vendored Tiro Web SDK. Copied to `output/assets/js/` by IGP. |
| `ig.ini` | `template = #tiro-template`. |
| `sushi-config.yaml` | `fhirVersion: 5.0.0`, dependency `hl7.fhir.uv.extensions.r5`. |
| `input/ignoreWarnings.txt` | Suppresses `Unknown_Code_in_Version` for the `tab` itemControl code. |
| `_genonce.sh`, `.github/workflows/ig-publisher.yml` | Build orchestration: SUSHI → IG Publisher. (No more generator or fetcher steps.) |

## itemControl extensions

Each top-level group in the questionnaire carries a
`questionnaire-itemControl` extension with **two** codings:

| System | Code | Purpose |
|---|---|---|
| `http://hl7.org/fhir/questionnaire-item-control` | `tab` | Standard SDC hint — render as a tab in the form. |
| `http://fhir.tiro.health/CodeSystem/tiro-item-control` | `block` | Tiro-specific layout hint. |

The Tiro renderer reads both and displays the four top-level groups (Patient
identification, Tumour identification & staging, Diagnosis & treatments,
Attachments) as tabs.

## Known issues and caveats

1. **`Unknown_Code_in_Version` "errors".** The base R5 `questionnaire-item-control`
   codesystem does not include `tab` — it lives in the SDC IG, which we do not
   depend on. We suppress the warning in `ignoreWarnings.txt`; the matching
   message id attaches our editor comment but the IG Publisher still counts
   them in the QA total. Build still exits 0, so non-blocking.
2. **HL7 ci-build incompatibility.** The HTMLInspector flags:
   - The dynamic-script-injection block (any `<script>` containing JavaScript).
   - The inline FHIR JSON `<script type="application/fhir+json">`.
   - The custom element `<tiro-form-filler>` (unknown HTML tag).
   These are warnings on a private build but would become errors on
   `ci.fhir.org`. To make it publish-safe we'd need to vendor the SDK as a
   local `.js` file in a trusted template package.
3. **SDC `$populate` returns 422.** The Tiro SDC backend at
   `sdc.tiro.health/fhir/r5` does not recognize our canonical
   (`…/Questionnaire/ExampleBCRDummyQuestionnaire`) and rejects pre-population.
   The form still renders fully editable — only auto-population fails.
4. **Navtabs override drift.** If upstream `fhir.base.template` adds new tabs
   (history, examples, …) those changes won't appear until we re-sync the
   override at `input/includes/fragment-base-navtabs.html`.

## Things still to consider

- Rename `ExampleBCRDummyQuestionnaire` → something more accurate (e.g.
  `BCRCancerRegistrationFormQuestionnaire`). Cascades to filenames, navtabs
  override copy, FSH instance id.
- Pin a specific Tiro SDK version in `_fetchTiroSdk.sh` (currently follows
  `cdn.tiro.health/sdk/latest/`).
- Decide whether to register the Tiro item-control CodeSystem
  (`http://fhir.tiro.health/CodeSystem/tiro-item-control`) in this IG or treat
  it as external.
- Long-term: move the per-Questionnaire form generation into a custom IG
  template package (Option B from the original design discussion) so it
  works across IGs without per-project setup.
