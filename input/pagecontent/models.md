### Models

This IG defines **9 logical models** in three groups. Each model maps to a specific BCR artefact (a form, a published dataset, or a screening-pathway sample feed).

### Form-level models — Bijlage 55

The four forms below collectively make up the standard cancer registration submission. The main form is universal; the three *vervolg* forms are appended only when the relevant condition holds (breast tumour / MOC convened / subsequent follow-up event).

| Model | Source | One row per | Documentation |
|---|---|---|---|
| `BCRCancerRegistrationForm` | Bijlage 55 main | Cancer case | [open](StructureDefinition-bcr-cancer-registration-form.html) |
| `BCRBreastTumourSupplement` | Bijlage 55 vervolg 1 | Breast cancer case | [open](StructureDefinition-bcr-breast-tumour-supplement.html) |
| `BCRMOCForm` | Bijlage 55 vervolg 2 | MOC convocation | [open](StructureDefinition-bcr-moc-form.html) |
| `BCRFollowUpForm` | Bijlage 55 vervolg 3 | Follow-up event | [open](StructureDefinition-bcr-follow-up-form.html) |

**Notable shape decisions:**
- `BCRCancerRegistrationForm.treatmentEpisode` is a repeating `BackboneElement` — the form has 5 chronology rows, but the model is unbounded so a HIS-derived submission can include the full timeline.
- `BCRBreastTumourSupplement.molecularMarker` carries `tumourIndex` (1 or 2) to capture the multifocal column on the source form.
- `BCRBreastTumourSupplement.molecularMarker.result` is a `CodeableConcept`, not a `code`, because each marker has its own result vocabulary (ER tri-state vs HER2 IHC 0/1+/2+/3+ vs gene-mutation 4-state).
- The MOC and follow-up forms have **different reason code lists** (`BCRMOCReasonVS` vs `BCRFollowUpMOCReasonVS`) — semantically distinct, deliberately not unified.

### Published research dataset

The "Cancer in Belgium" dataset is BCR's external-facing research export. It is a *derived view* over the form-level submissions plus registry-wide processing (pseudonymisation, vital-status reconciliation, age-category bucketing, tumour-sequence computation).

| Model | Source | One row per | Documentation |
|---|---|---|---|
| `BCRCancerCase` | *Cancer in Belgium - metadata* v2 (May 2025) | Cancer case | [open](StructureDefinition-bcr-cancer-case.html) |

**Coverage:** ~30% of the standard Bijlage 55 universe. The published dataset omits patient identity, full treatment chronology, MOC details, all Tier 2 disease-specific extensions, and all Tier 3 NIHDI project data. See [Data flow](dataflow.html) for why.

### Cyto-histopathology screening register

These four models cover the lab-side submissions for the breast / cervical / colorectal screening programmes. Granularity is **per sample**, not per case, and samples are submitted directly by pathology labs over sFTP — entirely separate from the hospital registration stream.

| Model | Source | One row per | Documentation |
|---|---|---|---|
| `BCRChpSample` (abstract) | Common core of the three CHP supplements | — (abstract) | [open](StructureDefinition-bcr-chp-sample.html) |
| `BCRChpBreastSample` | *Cyto-histopathology register breast - metadata* | Breast lab sample | [open](StructureDefinition-bcr-chp-breast-sample.html) |
| `BCRChpCervixSample` | *Cyto-histopathology register cervix - metadata* | Cervical lab sample | [open](StructureDefinition-bcr-chp-cervix-sample.html) |
| `BCRChpColonSample` | *Cyto-histopathology register colorectal - metadata* | Colorectal lab sample | [open](StructureDefinition-bcr-chp-colon-sample.html) |

**Why a shared abstract base:** all three CHP supplements share a 9-field core (sample-collection date / year, demographics, basis-of-diagnosis, histology+behaviour, sample location, lab region). The disease-specific children add only the differentiating fields:

- **Breast:** `sampleCategory`, `laterality`, `dataConfidenceLevel`
- **Cervix:** `hpvTestResult`, `hpvType` (0..*), `specimenQuality`
- **Colorectal:** `sampleCategory`, `dataConfidenceLevel`

### What's NOT modelled (and why)

| Tier 3 NIHDI project module | Why |
|---|---|
| Hadron therapy registration | A separate manual exists ([`rp_hadron_wbcr_manual_eng_2025.pdf`](https://kankerregister.org/sites/default/files/2025-02/rp_hadron_wbcr_manual_eng_2025.pdf)) but has not yet been processed for this IG. |
| GEP Breast | Field-level spec is not publicly available; lives inside WBCR. |
| NTRK inhibitors, SRT, BE-RFA, complex GI surgery, paediatric late effects | Same — internal to WBCR, no public field-level documentation. |

These modules are **out of scope** for v0.1.0 of this IG. They can be added if and when their specs are made available to BCR data partners.
