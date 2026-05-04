// Source: "Cancer in Belgium - metadata", Belgian Cancer Registry, v2 (2025-05-05).
// Element names use semantic FHIR-style camelCase; the original BCR variable
// name is preserved between parentheses in each short description so the
// logical model can be mapped 1:1 onto the BCR dataset.

Logical: BCRCancerCase
Id: bcr-cancer-case
Title: "BCR Cancer Case (Logical Model)"
Description: """
Logical model of a single cancer case as published in the Belgian Cancer Registry (BCR) **research dataset** ("Cancer in Belgium").

This is the *exported, derived* dataset — patient demographics are pseudonymised, several fields are derived (numeric ICD-10, age categories, region, vital-status dates), and tumour-sequence variables are computed registry-wide.

For the **submission form** that hospitals fill in for every new diagnosis, see `BCRCancerRegistrationForm` (Bijlage 55), which is the upstream source of most of the variables here.

Source: BCR — *Cancer in Belgium - metadata*, version 2, 2025-05-05.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

// ----------------------------------------------------------------------------
// Patient demographics
// ----------------------------------------------------------------------------
* birthDate 0..1 date "Date of birth (fld_bi)" "Date of birth of the patient."
* ageAtIncidence 0..1 unsignedInt "Age at incidence (cls_ag)" "Age of the patient at the time of incidence of the tumour, expressed in completed years."
* ageCategory 0..1 code "Age category at incidence (cls_ap)" "Specific age category of the patient at incidence (BCR-defined classification)."
* region 0..1 code "Region of residence (region)" "Region of the official residence of the patient at the time of incidence of the tumour."
* region from BCRRegionVS (preferred)
* sexAtBirth 1..1 code "Sex at birth (fld_sx)" "Sex assigned at birth."
* sexAtBirth from BCRSexAtBirthVS (required)

// ----------------------------------------------------------------------------
// Tumour incidence
// ----------------------------------------------------------------------------
* incidenceDate 1..1 date "Date of incidence (fld_ic)" "Date of incidence of the tumour."
* incidenceYear 1..1 unsignedInt "Year of incidence (regist)" "Year of incidence of the tumour."

// ----------------------------------------------------------------------------
// Diagnosis basis & coding
// ----------------------------------------------------------------------------
* basisOfDiagnosis 1..1 code "Basis of diagnosis (fld_dp)" "Most reliable method by which the diagnosis was made."
* basisOfDiagnosis from BCRBasisOfDiagnosisVS (required)
* icd10 0..1 code "ICD-10 code (icd10)" "ICD-10 code of the histology, as a string."
* icd10 from BCRICD10VS (extensible)
* icd10Numeric 0..1 string "ICD-10 (numeric, BCR-derived) (cls_dg)" "ICD-10 expressed as a numeric code, derived by BCR from the registered topography/morphology combination because ICD-10 is not registered by the sources."
* topography 1..1 code "Topography (fld_tp)" "Organ or tissue from which the primary tumour originated (ICD-O-3 topography)."
* topography from BCRTopographyVS (extensible)
* morphology 1..1 code "Morphology (fld_mp)" "Histology of the tumour (ICD-O-3 morphology)."
* morphology from BCRMorphologyVS (extensible)
* behaviour 1..1 code "Behaviour (fld_bh)" "Behaviour of the tumour (ICD-O-3 behaviour code: benign, borderline, in situ, malignant, etc.)."
* behaviour from BCRBehaviourVS (required)
* differentiationGrade 0..1 code "Differentiation grade (fld_df)" "Degree of resemblance of the tumour cells to the original tissue (differentiation grade)."
* differentiationGrade from BCRDifferentiationGradeVS (required)
* laterality 0..1 code "Laterality (fld_lt)" "Laterality of the tumour (e.g. left, right, bilateral, midline, not applicable)."
* laterality from BCRLateralityVS (required)

// ----------------------------------------------------------------------------
// Clinical TNM stage
// ----------------------------------------------------------------------------
* clinicalT 0..1 code "Clinical T (fld_ct)" "Extent of the primary tumour based on evidence acquired before treatment (cT)."
* clinicalN 0..1 code "Clinical N (fld_cn)" "Absence or presence and extent of regional lymph node metastasis based on evidence acquired before treatment (cN)."
* clinicalM 0..1 code "Clinical M (fld_cm)" "Absence or presence of distant metastasis based on evidence acquired before treatment (cM)."
* clinicalStageGroup 0..1 code "Clinical prognostic stage group (cls_cg)" "Combination of clinical TNM categories into prognostic groups."
* clinicalStageMain 0..1 code "Clinical main prognostic stage (cStadkort)" "Combination of clinical TNM categories into main prognostic groups."

// ----------------------------------------------------------------------------
// Pathological TNM stage
// ----------------------------------------------------------------------------
* neoadjuvantTherapyIndicator 0..1 code "Neoadjuvant therapy indicator (ypTNM)" "Indicates whether the patient has received neoadjuvant therapy prior to surgical / pathological staging."
* pathologicalT 0..1 code "Pathological T (fld_pt)" "Extent of the primary tumour based on evidence acquired before treatment, supplemented or modified by additional evidence acquired from surgery and pathological examination (pT)."
* pathologicalN 0..1 code "Pathological N (fld_pn)" "Absence or presence and extent of regional lymph node metastasis based on evidence acquired before treatment, supplemented or modified by additional evidence acquired from surgery and pathological examination (pN)."
* pathologicalM 0..1 code "Pathological M (fld_pm)" "Absence or presence of distant metastasis based on evidence acquired before treatment, supplemented or modified by additional evidence acquired from surgery and pathological examination (pM)."
* pathologicalStageGroup 0..1 code "Pathological prognostic stage group (cls_pg)" "Combination of pathological TNM categories into prognostic groups."
* pathologicalStageMain 0..1 code "Pathological main prognostic stage (pStadkort)" "Combination of pathological TNM categories into main prognostic groups."

// ----------------------------------------------------------------------------
// Combined (consolidated) stage
// ----------------------------------------------------------------------------
* combinedStage 0..1 code "Combined stage (combstad)" "Final, consolidated stage based on the clinical stage and the pathological stage."
* combinedStageMain 0..1 code "Combined main stage (combStadkort)" "Final, consolidated stage based on the first-level clinical stage and the first-level pathological stage."

// ----------------------------------------------------------------------------
// Childhood cancer classification
// ----------------------------------------------------------------------------
* iccc3 0..1 code "ICCC-3 (repbm)" "International Classification of Childhood Cancer, third edition (Birch-Marsden categorical code)."
* birchMarsdenNumeric 0..1 unsignedInt "Birch-Marsden numeric (cls_bm)" "Birch-Marsden classification expressed in numeric format."

// ----------------------------------------------------------------------------
// Tumour sequence (multiple primaries)
// ----------------------------------------------------------------------------
* totalTumours 0..1 unsignedInt "Total malignant tumours of patient (totaltum)" "Total number of malignant tumours of this patient."
* tumourSequenceNumber 0..1 unsignedInt "Sequence place of this tumour (multiple)" "Place of this tumour in the sequence of malignant tumours of the patient."
* breastTumourSequence 0..1 code "Breast tumour sequence indicator (borsttelling)" "Indicates if the breast tumour is the first primary breast tumour of this patient or a subsequent breast tumour."
* breastTumourSequence from BCRBreastTumourSequenceVS (preferred)

// ----------------------------------------------------------------------------
// Vital status & follow-up
// ----------------------------------------------------------------------------
* vitalStatus 1..1 code "Vital status (fld_vs)" "Indicates whether the patient is alive, deceased, or lost to follow-up."
* vitalStatus from BCRVitalStatusVS (preferred)
* lastObservationDate 0..1 date "Most recent vital-status date (cls_lod)" "Most recent date among the patient's vital-status dates (last alive date, date of death, lost-to-follow-up date)."
* lastAliveDate 0..1 date "Last alive date (fld_la)" "Date on which it was last confirmed that the patient was alive."
* dateOfDeath 0..1 date "Date of death (fld_cd)" "Confirmed date of death of the patient."
* lostToFollowUpDate 0..1 date "Lost-to-follow-up date (fld_lf)" "Most recent value of the sample date(s), or the date the patient moved abroad."
