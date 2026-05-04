// Source: Bijlage 55 (vervolg 1) — "Aanvullende karakteristieken die specifiek zijn voor borsttumoren".
// Canonical PDF: https://www.riziv.fgov.be/SiteCollectionDocuments/formulier_verordening20030728_bijlage_55.pdf
// Appended to the main Bijlage 55 form for every breast tumour registration.

Logical: BCRBreastTumourSupplement
Id: bcr-breast-tumour-supplement
Title: "BCR Breast Tumour Supplement — Bijlage 55 vervolg 1 (Logical Model)"
Description: """
Logical model of the breast-tumour-specific supplement to the standard cancer
registration form (Bijlage 55, *vervolg 1*). Contains menopausal status,
molecular markers (with separate values for tumour 1 and, when multifocal,
tumour 2), and surgical / lymph node data.

Source: Bijlage 55 (vervolg 1) of the RIZIV Verordening of 28 July 2003,
amended 15 December 2025.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

// ----------------------------------------------------------------------------
// 1. Menopausal status at diagnosis
// ----------------------------------------------------------------------------
* menopausalStatus 0..1 code "Menopausal status at diagnosis" "Menopausal status. Codes: ja / nee / onduidelijk / niet gekend / niet van toepassing (mannelijke patiënt)."
* menopausalStatus from BCRMenopausalStatusVS (required)

// ----------------------------------------------------------------------------
// 2. Molecular markers — one row per (marker × tumour). Up to 2 tumours when multifocal.
// ----------------------------------------------------------------------------
* molecularMarker 0..* BackboneElement "Molecular marker result" "One molecular-marker measurement on tumour 1, or on tumour 2 in the case of multifocal disease."
  * marker 1..1 code "Marker" """
Molecular marker. Form-listed markers:
ER (oestrogen receptor), PR (progesterone receptor),
HER2-IHC (HER2 IHC score), HER2-IHC-ISH (combined HER2 status),
BRCA1-2, CHEK2, PALB2, ATM, PIK3CA (PIKCA3 on the form),
KI67 (Ki-67 before systemic therapy), OTHER (free-text marker name).
"""
  * marker from BCRMolecularMarkerVS (required)
  * otherMarkerName 0..1 string "Other marker name" "Free-text marker name when `marker = OTHER`."
  * tumourIndex 1..1 unsignedInt "Tumour index" "Tumour to which the result applies: 1 (primary tumour) or 2 (second tumour, only in multifocal disease)."
  * testDate 0..1 date "Test date" "Date the marker was measured."
  * result 0..1 CodeableConcept "Result" """
Result of the marker. Permitted codings depend on the marker:
- ER, PR: positief / gering positief / negatief.
- HER2-IHC: 0 / 1+ / 2+ / 3+.
- HER2-IHC-ISH: positief / HER2 low (provisional) / negatief.
- BRCA1-2, CHEK2, PALB2, ATM, PIK3CA: niet getest / geen mutatie / somatische mutatie / kiembaanmutatie.
- KI67: see `resultPercentage` (or `niet getest`).
"""
  * result from BCRMolecularMarkerResultVS (extensible)
  * resultPercentage 0..1 decimal "Result percentage" "Numeric percentage result. Used for Ki-67 (`marker = KI67`)."

// ----------------------------------------------------------------------------
// 3a. Surgical data — primary tumour (only if surgery was performed). Units: mm.
// ----------------------------------------------------------------------------
* surgeryPerformed 0..1 boolean "Surgery performed" "Indicates whether section 3 (surgical data) is in scope. When false or absent, the surgery fields below are not applicable."

* maxPathDiameterInvasiveMm 0..1 decimal "Max pathological diameter, invasive component, before systemic therapy (mm)" "Maximale pathologische doormeter invasieve component vóór systemische therapie."
* maxPathDiameterInSituMm 0..1 decimal "Max pathological diameter, in situ component, before systemic therapy (mm)" "Maximale pathologische doormeter in situ component vóór systemische therapie."
* minMarginDistanceInvasiveMm 0..1 decimal "Min distance, invasive component to surgical margin (mm)" "Minimale afstand van de invasieve component tot de snijrand."
* minMarginDistanceInSituMm 0..1 decimal "Min distance, in situ component to surgical margin (mm)" "Minimale afstand van de in situ component tot snijrand."

// ----------------------------------------------------------------------------
// 3b. Surgical data — lymph nodes
// ----------------------------------------------------------------------------
* lymphNodeAssessment 0..* BackboneElement "Lymph node assessment" "One row of the sentinel / axillary / other-nodes table."
  * location 1..1 code "Node location" "Lymph node group. Codes: SENTINEL (Sentinelklieren), AXILLARY (Axillaire klieren), OTHER (Andere klieren)."
  * location from BCRLymphNodeLocationVS (required)
  * examined 0..1 unsignedInt "Number examined" "Aantal onderzocht."
  * positive 0..1 unsignedInt "Number positive" "Aantal positief."
  * assessmentDate 0..1 date "Assessment date" "Date of the lymph node assessment."
