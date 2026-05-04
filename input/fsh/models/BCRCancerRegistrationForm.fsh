// Source: Bijlage 55 of the RIZIV Verordening of 28 July 2003, in the version
// replaced by the Verordening of 15 December 2025 (B.St. 23-12-2025).
// Canonical PDF: https://www.riziv.fgov.be/SiteCollectionDocuments/formulier_verordening20030728_bijlage_55.pdf
// This is the form-level model. The published research subset is BCRCancerCase.

Logical: BCRCancerRegistrationForm
Id: bcr-cancer-registration-form
Title: "BCR Cancer Registration Form — Bijlage 55 (Logical Model)"
Description: """
Logical model of the Belgian standard cancer registration form
(*Kankerregistratieformulier voor een nieuwe diagnose*).
This is what hospitals submit to the Belgian Cancer Registry through WBCR
or via batch extraction for every new cancer diagnosis.

Distinct from `BCRCancerCase`, which models the *published research dataset*
derived from these submissions plus registry follow-up.

Source (canonical): Bijlage 55 to the RIZIV Verordening of 28 July 2003,
as amended by the Verordening of 15 December 2025 (Belgisch Staatsblad
23-12-2025, p. 96356).
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

// ----------------------------------------------------------------------------
// Patient identification (top of the form)
// ----------------------------------------------------------------------------
* patientName 1..1 string "Patient name" "Free-text patient name as entered on the form."
* birthDate 1..1 date "Date of birth" "Patient date of birth."
* nationalOrInsuranceNumber 1..1 string "INSZ / Ziekenfondsnummer" "Belgian national number (INSZ/NISS) or, when unavailable, the insurance fund number."
* sex 1..1 code "Sex" "Sex of the patient."
* sex from BCRSexAtBirthVS (required)

// ----------------------------------------------------------------------------
// Section 1–9: tumour identification and staging
// ----------------------------------------------------------------------------
* incidenceDate 1..1 date "Incidence date" "Date of incidence (DD-MM-YYYY) per ENCR/IACR international guidelines."

* basisOfDiagnosis 1..1 code "Basis for diagnosis" """
Most reliable method by which the diagnosis was established. Codes:
2 = histology of primary tumour, 3 = histology of metastasis,
4 = cytology / haematology, 5 = technical investigation (RX, endoscopy, …),
6 = clinical, 7 = tumour marker (PSA, hCG, AFP, Ig, …),
8 = cytogenetic / molecular tests, 9 = unknown.
"""
* basisOfDiagnosis from BCRBasisOfDiagnosisVS (required)

* whoPerformanceScore 0..1 code "WHO performance score at diagnosis" """
Score at incidence date. Codes:
0 = asymptomatic, normal activity; 1 = symptomatic but ambulatory;
2 = symptomatic, bedridden <50% per day; 3 = symptomatic, bedridden >50% per day;
4 = fully dependent, 100% bedridden.
"""
* whoPerformanceScore from BCRWHOPerformanceScoreVS (required)

* primaryTumourLocation 1..1 code "Primary tumour localisation" "ICD-O-3 topography of the primary tumour."
* primaryTumourLocation from BCRTopographyVS (extensible)

* laterality 0..1 code "Laterality" "Laterality of the primary tumour. Codes: 1 = left, 2 = right, 3 = unpaired organ, NK = unknown."
* laterality from BCRLateralityVS (required)

* histologyMorphology 1..1 code "Histology — morphology" "ICD-O-3 morphology code (the part before the slash on the form)."
* histologyMorphology from BCRMorphologyVS (extensible)
* histologyBehaviour 1..1 code "Histology — behaviour" "ICD-O-3 behaviour code (the part after the slash on the form: benign / borderline / in situ / malignant primary / malignant metastatic / unknown)."
* histologyBehaviour from BCRBehaviourVS (required)

* differentiationGrade 0..1 code "Differentiation grade" """
Grade of differentiation. Codes:
1 = well, 2 = moderate, 3 = poor, 4 = undifferentiated / anaplastic,
5 = T-cell, 6 = B-cell, 7 = null-cell (not T / not B),
8 = NK cell, 9 = unknown.
"""
* differentiationGrade from BCRDifferentiationGradeVS (required)

// TNM (most recent UICC edition)
* clinicalT 0..1 string "Clinical T (cT)" "Clinical T category (UICC TNM)."
* clinicalN 0..1 string "Clinical N (cN)" "Clinical N category (UICC TNM)."
* clinicalM 0..1 string "Clinical M (cM)" "Clinical M category (UICC TNM)."

* pathologicalT 0..1 string "Pathological T (pT)" "Pathological T category (UICC TNM)."
* pathologicalN 0..1 string "Pathological N (pN)" "Pathological N category (UICC TNM)."
* pathologicalM 0..1 string "Pathological M (pM)" "Pathological M category (UICC TNM)."

* postNeoadjuvantT 0..1 string "Post-neoadjuvant pathological T (ypT)" "Pathological T after neoadjuvant therapy."
* postNeoadjuvantN 0..1 string "Post-neoadjuvant pathological N (ypN)" "Pathological N after neoadjuvant therapy."
* postNeoadjuvantM 0..1 string "Post-neoadjuvant pathological M (ypM)" "Pathological M after neoadjuvant therapy."

// Section 9 — alternative classification
* otherClassification 0..1 code "Other classification" """
Alternative staging classification used when applicable. Codes:
1 = Childhood Cancer Stage, 2 = FIGO, 3 = Lugano,
4 = Breslow (in mm), 5 = other.
"""
* otherClassification from BCROtherClassificationVS (required)
* otherStageGroup 0..1 string "Other classification — stage" "Stage value within the chosen alternative classification (e.g. Breslow depth in mm, FIGO stage)."

// ----------------------------------------------------------------------------
// Section 10: diagnosis and primary treatments
// ----------------------------------------------------------------------------
* clinicalTrialParticipation 0..1 code "Clinical trial participation" "Whether the cancer treatment is part of a clinical study (Ja / Nee / Onbekend)."
* clinicalTrialParticipation from BCRClinicalTrialIndicatorVS (required)
* eudraCtNumber 0..1 string "EudraCT number" "EudraCT identifier of the trial when clinical trial participation is *Ja*."

* treatmentEpisode 0..* BackboneElement "Treatment chronology row" "One row of the chronology table, filled in chronologically from incidence date and first treatment."
  * code 1..1 code "Diagnosis / treatment code" """
Chronology code. Codes:
5 = diagnosis; 10 = surgery; 11 = excision biopsy;
16 = HSCT autologous; 17 = HSCT allogeneic;
20 = external radiotherapy / brachytherapy; 21 = IORT; 22 = hadron therapy;
25 = concurrent chemoradiotherapy; 26 = concurrent radio-immunotherapy;
30 = radio-isotopes; 35 = phototherapy; 36 = topical therapy;
40 = chemotherapy / systemic therapy; 45 = targeted therapy (not 26, 60);
50 = hormonal therapy; 60 = immunotherapy (not 26, 66);
66 = concurrent chemo-immunotherapy;
70 = symptomatic / palliative; 75 = active surveillance / watchful waiting;
80 = other treatment (free-text comment required);
90 = no therapy; 95 = treatment refusal; 99 = unknown.
"""
  * code from BCRTreatmentChronologyVS (required)
  * campusId 0..1 string "Campus / vestigingsnummer" "Hospital site identifier where the episode took place."
  * startDate 1..1 date "Start date" "Episode start date."
  * endDate 0..1 date "End date" "Episode end date when known."
  * comment 0..1 string "Comment" "Free-text comment, required only for code 80 (other treatment)."

// ----------------------------------------------------------------------------
// Section 11: attached MOC report(s) — only for breast tumours per footnote 7.
// ----------------------------------------------------------------------------
* mocReport 0..* Attachment "Attached MOC report(s)" "MOC report(s) attached to the form. Only required for breast tumours per footnote 7 of Bijlage 55."
