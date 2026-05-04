### Terminology

The IG defines **23 CodeSystems** and **33 ValueSets**. Each coded element on each logical model is bound to a ValueSet from one of three derivation patterns, with binding strength chosen to reflect how confident we are in the source.

### Pattern 1 — Form-defined enumerations (binding: `required`)

These ValueSets are derived directly from numbered code lists on Bijlage 55 (often in form footnotes). Each code preserves the numeric or short alphanumeric value as it appears on the form, so the IG round-trips cleanly with BCR data feeds.

| ValueSet | Source | # codes |
|---|---|---|
| [`BCRBasisOfDiagnosisVS`](ValueSet-bcr-basis-of-diagnosis-vs.html) | Bijlage 55 footnote 2 | 8 |
| [`BCRWHOPerformanceScoreVS`](ValueSet-bcr-who-performance-score-vs.html) | Bijlage 55 footnote 3 | 5 |
| [`BCRLateralityVS`](ValueSet-bcr-laterality-vs.html) | Bijlage 55 footnote 4 | 4 (incl. `NK`) |
| [`BCRDifferentiationGradeVS`](ValueSet-bcr-differentiation-grade-vs.html) | Bijlage 55 footnote 5 | 9 |
| [`BCROtherClassificationVS`](ValueSet-bcr-other-classification-vs.html) | Bijlage 55 footnote 6 | 5 |
| [`BCRClinicalTrialIndicatorVS`](ValueSet-bcr-clinical-trial-indicator-vs.html) | Bijlage 55 §10A | 3 |
| [`BCRTreatmentChronologyVS`](ValueSet-bcr-treatment-chronology-vs.html) | Bijlage 55 footnote 8 | 24 |
| [`BCRIntendedTreatmentVS`](ValueSet-bcr-intended-treatment-vs.html) | Vervolg 3 §II | 12 |
| [`BCRMenopausalStatusVS`](ValueSet-bcr-menopausal-status-vs.html) | Vervolg 1 footnote 9 | 5 |
| [`BCRMolecularMarkerVS`](ValueSet-bcr-molecular-marker-vs.html) | Vervolg 1 table headers | 11 |
| [`BCRLymphNodeLocationVS`](ValueSet-bcr-lymph-node-location-vs.html) | Vervolg 1 §3b | 3 |
| [`BCRMOCReasonVS`](ValueSet-bcr-moc-reason-vs.html) | Vervolg 2 | 5 |
| [`BCRRecurrenceTypeVS`](ValueSet-bcr-recurrence-type-vs.html) | Vervolg 3 §I | 3 |
| [`BCRFollowUpMOCReasonVS`](ValueSet-bcr-follow-up-moc-reason-vs.html) | Vervolg 3 §III | 6 |
| [`BCRBehaviourVS`](ValueSet-bcr-behaviour-vs.html) | ICD-O-3 behaviour digits | 6 |

#### Molecular marker results — six related ValueSets

The Vervolg 1 molecular-marker table assigns *different* result vocabularies to different markers (ER/PR is tri-state; HER2 IHC is 0/1+/2+/3+; gene mutations are tested/not-tested/somatic/germline; Ki-67 is a percentage). Per-marker subsets are published; `BCRBreastTumourSupplement.molecularMarker.result` binds to the **union**.

| ValueSet | Applies to marker(s) |
|---|---|
| [`BCRMolecularMarkerResultERPRVS`](ValueSet-bcr-molecular-marker-result-er-pr-vs.html) | ER, PR |
| [`BCRMolecularMarkerResultHER2IHCVS`](ValueSet-bcr-molecular-marker-result-her2-ihc-vs.html) | HER2 IHC score |
| [`BCRMolecularMarkerResultHER2CombinedVS`](ValueSet-bcr-molecular-marker-result-her2-combined-vs.html) | HER2 status (IHC + ISH combined) |
| [`BCRMolecularMarkerResultMutationVS`](ValueSet-bcr-molecular-marker-result-mutation-vs.html) | BRCA1/2, CHEK2, PALB2, ATM, PIK3CA |
| [`BCRMolecularMarkerResultKi67VS`](ValueSet-bcr-molecular-marker-result-ki67-vs.html) | Ki-67 (categorical sentinel only — percentage uses `resultPercentage`) |
| [`BCRMolecularMarkerResultVS`](ValueSet-bcr-molecular-marker-result-vs.html) | Union — bound on the element |

### Pattern 2 — External standard vocabularies (binding: `extensible`)

For elements that reference internationally-standardised vocabularies, the IG binds to the canonical published system. ValueSet wrappers are kept thin so future filters can be applied without breaking the binding URL.

| ValueSet | Code system | Used on |
|---|---|---|
| [`BCRTopographyVS`](ValueSet-bcr-topography-vs.html) | ICD-O-3 (`http://terminology.hl7.org/CodeSystem/icd-o-3`) | `primaryTumourLocation`, `topography` |
| [`BCRMorphologyVS`](ValueSet-bcr-morphology-vs.html) | ICD-O-3 | `histologyMorphology`, `morphology` |
| [`BCRICD10VS`](ValueSet-bcr-icd10-vs.html) | ICD-10 (`http://hl7.org/fhir/sid/icd-10`) | `BCRCancerCase.icd10` |
| [`BCRSexAtBirthVS`](ValueSet-bcr-sex-at-birth-vs.html) | FHIR `administrative-gender` | `sex`, `sexAtBirth` |

**Caveat on ICD-O-3:** FHIR's published ICD-O-3 system mixes topography and morphology. Conformant data should use only the topography codes (`C00`–`C80`) for `BCRTopographyVS` and only morphology codes for `BCRMorphologyVS`. The behaviour digit is captured separately on `histologyBehaviour` (bound `required` to `BCRBehaviourVS`) since the form splits morphology and behaviour even though ICD-O-3 represents them as `8500/3` style joined codes.

### Pattern 3 — Draft, awaiting BCR confirmation (binding: `preferred`)

These ValueSets cover fields that BCR's metadata describes in natural language but does **not** enumerate. The codes are best-effort reconstructions; descriptions explicitly say "**Draft — confirm with BCR before production use**". Bindings are `preferred` so downstream systems can override until BCR ratifies a canonical list.

| ValueSet | Source field | What we drafted |
|---|---|---|
| [`BCRVitalStatusVS`](ValueSet-bcr-vital-status-vs.html) | `BCRCancerCase.vitalStatus` (`fld_vs`) | alive, deceased, lost-to-followup |
| [`BCRBreastTumourSequenceVS`](ValueSet-bcr-breast-tumour-sequence-vs.html) | `BCRCancerCase.breastTumourSequence` (`borsttelling`) | first-primary, subsequent |
| [`BCRRegionVS`](ValueSet-bcr-region-vs.html) | `BCRCancerCase.region`, `BCRChpSample.laboratoryRegion` | flanders, wallonia, brussels, unknown |
| [`BCRSampleCategoryVS`](ValueSet-bcr-sample-category-vs.html) | `BCRChpBreastSample.sampleCategory`, `BCRChpColonSample.sampleCategory` | screening, diagnostic, followup, surveillance, other |
| [`BCRDataConfidenceLevelVS`](ValueSet-bcr-data-confidence-level-vs.html) | `dataConfidenceLevel` (breast, colon CHP) | high, medium, low, unknown |
| [`BCRHPVTestResultVS`](ValueSet-bcr-hpv-test-result-vs.html) | `BCRChpCervixSample.hpvTestResult` | positive, negative, inconclusive, not-done |
| [`BCRSpecimenQualityVS`](ValueSet-bcr-specimen-quality-vs.html) | `BCRChpCervixSample.specimenQuality` | adequate, adequate-with-limitations, inadequate |
| [`BCRHPVTypeVS`](ValueSet-bcr-hpv-type-vs.html) | `BCRChpCervixSample.hpvType` (0..*) | 14 high-risk + 2 low-risk WHO/IARC genotypes + other |

### Binding-strength summary

| Strength | Used for | Behaviour |
|---|---|---|
| `required` | Pattern 1 + the small custom `BCRBehaviourVS` + `BCRSexAtBirthVS` | Any code outside the VS fails validation. |
| `extensible` | Pattern 2 (external vocabularies) + the molecular-marker result union | Codes outside the VS are allowed if no equivalent code exists in the VS. |
| `preferred` | Pattern 3 (draft) | Codes outside the VS are explicitly permitted; the VS expresses intent, not a rule. |

### Provenance

Every CodeSystem `description` cites the exact source (Bijlage 55 footnote, metadata variable name, or external system URL). The full Bijlage 55 PDF is preserved in this repository under `docs/source-metadata/Bijlage55-form.pdf` for round-trip auditing.
