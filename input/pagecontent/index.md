### Belgian Cancer Registry on FHIR

This Implementation Guide models the data structures of the Belgian Cancer Registry (BCR / *Stichting Kankerregister*) as FHIR Logical Models, with code systems and value sets derived directly from the published source documents.

The IG is intentionally bounded by what the **publicly-available BCR documents** specify — the registration form `Bijlage 55`, the three cyto-histopathology screening supplements, and the `Cancer in Belgium` research-dataset metadata. NIHDI-linked project modules (Hadron, GEP Breast, NTRK, etc.) are out of scope until their specs are made public.

### Quick navigation

| If you want to … | Start here |
|---|---|
| Understand the high-level data pipeline | [Data flow](dataflow.html) |
| Browse the logical models grouped by purpose | [Models](models.html) |
| See how value sets were derived and bound | [Terminology](terminology.html) |
| Get the legal / institutional background | [Background](background.html) |
| Pull every artefact this IG defines | [Artifacts](artifacts.html) |
| Install the IG package locally | [Downloads](downloads.html) |

### What's modelled

| Layer | Models | Source |
|---|---|---|
| **Form-level** (Bijlage 55) | `BCRCancerRegistrationForm` + 3 supplements (Vervolg 1 breast, Vervolg 2 MOC, Vervolg 3 follow-up) | RIZIV Verordening 28-07-2003 (amended 15-12-2025) |
| **Published research dataset** | `BCRCancerCase` | *Cancer in Belgium - metadata* v2, May 2025 |
| **Cyto-histopathology screening** | `BCRChpSample` (abstract) + `BCRChpBreastSample` / `BCRChpCervixSample` / `BCRChpColonSample` | The three CHP supplement metadata documents |
| **Terminology** | 23 CodeSystems, 33 ValueSets | Three derivation patterns — see [Terminology](terminology.html) |

### Status

- Version: **0.1.0**, draft, experimental.
- All artefacts marked `^status = #draft` until BCR review.
- Coded fields where BCR has not published an enumeration are bound at `preferred` strength to **draft** ValueSets explicitly labelled "*confirm with BCR before production use*".
