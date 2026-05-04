// Source: BCR Cyto-Histopathology (CHP) register metadata documents (Breast, Cervix, Colon).
// All three supplements share a common nine-field core capturing sample identification,
// patient demographics, basis of diagnosis, histology/behaviour, and provenance.
// This abstract base is specialised by the three disease-specific supplements.

Logical: BCRChpSample
Id: bcr-chp-sample
Title: "BCR CHP Sample (Abstract Base Logical Model)"
Description: """
Abstract base for the Belgian Cancer Registry cyto-histopathology (CHP) screening supplements.
One row per laboratory sample (not per patient or per cancer case).
"""
* ^status = #draft
* ^experimental = true
* ^abstract = true
* ^version = "0.1.0"

* sampleCollectionDate 1..1 date "Sample collection date (fld_ic)" "Date the sample was collected / taken."
* sampleCollectionYear 1..1 unsignedInt "Sample collection year (regist)" "Year the sample was collected."

* birthDate 0..1 date "Date of birth (fld_bi)" "Date of birth of the screened person."
* ageAtSampleCollection 0..1 unsignedInt "Age at sample collection (cls_ag)" "Age of the screened person at the time the sample was collected."
* sexAtBirth 1..1 code "Sex at birth (fld_sx)" "Sex assigned at birth."
* sexAtBirth from BCRSexAtBirthVS (required)

* basisOfDiagnosis 1..1 code "Basis of diagnosis (fld_dp / fld_ch)" "Most reliable method by which the diagnosis was made. Source variable is fld_dp in the breast and colorectal supplements and fld_ch in the cervix supplement."
* basisOfDiagnosis from BCRBasisOfDiagnosisVS (extensible)
* histologyBehaviour 1..1 code "Histology and behaviour (fld_ls)" "Histology and behaviour of the sample (ICD-O-3 morphology + behaviour, BCR-coded)."
* histologyBehaviour from BCRMorphologyVS (extensible)

* sampleLocation 0..1 code "Sample location (fld_or)" "Location at which the sample was collected / taken (BCR-coded site / facility category)."
* laboratoryRegion 0..1 code "Laboratory region (region_source)" "Region (Flanders / Wallonia / Brussels) where the pathology laboratory submitting the sample is situated."
* laboratoryRegion from BCRRegionVS (preferred)
