### Data flow

The BCR data ecosystem is fed by **two parallel streams** with different sources, granularities, and submission channels. The published research dataset is a **derived view** over both, with pseudonymisation and aggregation applied.

### Stream 1 — Clinical registration (one row per cancer case)

```
Hospital MOC discusses a patient
        │
        ▼
Coordinating physician fills in Bijlage 55
        │
        ├──── Section 1-11 (universal)              ──► BCRCancerRegistrationForm
        ├──── Vervolg 1 (only if breast tumour)     ──► BCRBreastTumourSupplement
        ├──── Vervolg 2 (MOC attestation)           ──► BCRMOCForm
        └──── Vervolg 3 (subsequent follow-up MOCs) ──► BCRFollowUpForm
        │
        ▼
Submission via WBCR
        │
        ├── manual entry (web UI), OR
        └── batch extraction from HIS
        │
        ▼
BCR internal database
```

- **Who submits:** hospitals with oncological care programmes (legally obliged).
- **Submission window:** within 4–6 months of incidence date.
- **Channel:** [WBCR](https://www.kankerregistratie.be/wbcr/) — manual web entry or HIS batch.
- **Authentication:** eHealth portal (eID / itsme).
- **Patient identity:** INSZ / NISS via eHealth `IdentifyPerson` lookup.

### Stream 2 — Pathology screening submissions (one row per lab sample)

```
Pathology / clinical biology / haematology lab
        │
        │ Processes a screening sample (breast / cervix / colorectal)
        │
        ▼
Structured dataset + pathology report
        │
        ▼
sFTP transfer to BCR
        │
        ├── monthly cadence (cervical samples)
        └── quarterly cadence (breast, colorectal, general)
        │
        ▼
CHP (cyto-histopathology) register      ──► BCRChpSample
                                            ├── BCRChpBreastSample
                                            ├── BCRChpCervixSample
                                            └── BCRChpColonSample
```

- **Who submits:** every Belgian pathological anatomy / clinical biology / haematology lab (legally obliged since 2025 to use sFTP exclusively).
- **Codes used:** ICD-O-3 morphology + topography + CODAP-2017 (BCR-specific lesion-type codes).
- **Granularity:** **one row per sample**, not per patient. Same patient and same tumour can appear across multiple rows.

### Stream 3 — Published research dataset (derived)

```
BCR internal database (streams 1 + 2 + registry-wide processing)
        │
        │ Pseudonymisation
        │ Field derivation (numeric ICD-10, age categories, vital-status dates)
        │ Aggregation (totaltum, multiple, borsttelling)
        │ Filtering to non-identifiable variables
        │
        ▼
"Cancer in Belgium" research dataset      ──► BCRCancerCase
```

- **What's in it:** ~38 variables, see [`BCRCancerCase`](StructureDefinition-bcr-cancer-case.html).
- **What's NOT in it:** patient name, INSZ, treatment chronology, MOC details, all Tier 2 disease-specific extensions, all Tier 3 NIHDI project data.
- **Released to:** external researchers and institutions on formal data request.

### Why the model split matters

The three streams are deliberately modelled as separate logical structures rather than a single unified model:

| Difference | Form (stream 1) | CHP (stream 2) | Research dataset (stream 3) |
|---|---|---|---|
| Granularity | Per cancer case | Per lab sample | Per cancer case |
| Patient identity | Plaintext name + INSZ | Plaintext (then pseudonymised) | Pseudonymised |
| Treatment data | Full chronology in `treatmentEpisode` | Absent | Absent |
| Vital status dates | Captured per follow-up event | Absent | Computed registry-wide |
| Source | Hospital | Lab | BCR processing pipeline |

Trying to use a single resource for all three would either lose information from streams 1 and 2 or pollute the research-dataset shape with form-level concerns. Separation is honest.
