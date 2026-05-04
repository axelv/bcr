// Source: Bijlage 55 (vervolg 3) — Kankerregistratieformulier voor het registreren van follow-up.
// Canonical PDF: https://www.riziv.fgov.be/SiteCollectionDocuments/formulier_verordening20030728_bijlage_55.pdf
// Submitted at each subsequent MOC or disease event after the initial registration.

Logical: BCRFollowUpForm
Id: bcr-follow-up-form
Title: "BCR Follow-Up Form — Bijlage 55 vervolg 3 (Logical Model)"
Description: """
Logical model of the cancer registration follow-up form. Submitted to BCR
at each follow-up MOC or disease event after the initial registration.
Captures the primary tumour reference, recurrence information, the planned
treatment for the current problem, and the reason for the follow-up MOC.

Source: Bijlage 55 (vervolg 3) of the RIZIV Verordening of 28 July 2003,
amended 15 December 2025.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

// ----------------------------------------------------------------------------
// Patient identification
// ----------------------------------------------------------------------------
* patientName 1..1 string "Patient name" "Free-text patient name."
* birthDate 1..1 date "Date of birth" "Patient date of birth."
* nationalOrInsuranceNumber 1..1 string "INSZ / Ziekenfondsnummer" "Belgian national number (INSZ/NISS) or insurance fund number."
* sex 1..1 code "Sex" "Sex of the patient."
* sex from BCRSexAtBirthVS (required)

// ----------------------------------------------------------------------------
// I) Primary tumour reference
// ----------------------------------------------------------------------------
* primaryTumourLocation 1..1 code "Primary tumour localisation" "ICD-O-3 topography of the primary tumour."
* primaryTumourLocation from BCRTopographyVS (extensible)
* primaryTumourHistology 1..1 code "Primary tumour histology" "ICD-O-3 morphology / behaviour of the primary tumour."
* primaryTumourHistology from BCRMorphologyVS (extensible)
* primaryTumourIncidenceDate 0..1 date "Primary tumour incidence date" "Date of incidence (DD-MM-YYYY). The form notes that *the year alone is sufficient if the full date is not traceable*."

* diseaseFreeInterval 0..1 boolean "Disease-free interval" "Indicates whether a disease-free interval was present (Ja / Nee)."
* firstRecurrenceDate 0..1 date "Date of first recurrence" "Date of first recurrence — recorded only when a disease-free interval was present."
* recurrenceType 0..* code "Recurrence type" "Type(s) of recurrence (multiple allowed). Codes: LOCAL, REGIONAL, METASTATIC."
* recurrenceType from BCRRecurrenceTypeVS (required)

// ----------------------------------------------------------------------------
// II) Treatment plan for the current problem (intent-to-treat, chronological)
// ----------------------------------------------------------------------------
* intendedTreatment 0..* code "Intended treatment" """
Intent-to-treat code(s), filled in chronologically. Codes:
10 = surgery; 15 = bone marrow transplant;
20 = external radiotherapy / brachytherapy;
25 = concurrent chemoradiotherapy;
30 = radio-isotopes;
40 = chemotherapy; 50 = hormonal therapy; 60 = immunotherapy;
70 = symptomatic; 80 = other treatment (specify in `intendedOtherTreatment`);
90 = no therapy; 95 = treatment refusal.
"""
* intendedTreatment from BCRIntendedTreatmentVS (required)
* intendedOtherTreatment 0..1 string "Other intended treatment" "Free-text description of the treatment when code 80 is selected."

// ----------------------------------------------------------------------------
// III) Reason for the follow-up MOC
// ----------------------------------------------------------------------------
* followUpMocReason 0..* code "Follow-up MOC reason" """
Reason(s) for convening the follow-up MOC. Codes:
RECURRENCE = treatment of a patient with a recurrence;
PROGRESSION = treatment of a patient with progressive disease;
GUIDELINE_DEVIATION = before oncological treatment deviating from accepted guidelines;
REPEAT_RADIATION = before a repeat irradiation of the same target area within twelve months;
CTG_DRUG = before chemotherapy with a drug flagged for MOC monitoring by the Commissie Tegemoetkoming Geneesmiddelen;
OTHER = other (specify in `followUpMocOtherReason`).
"""
* followUpMocReason from BCRFollowUpMOCReasonVS (required)
* followUpMocOtherReason 0..1 string "Other follow-up MOC reason" "Free-text reason when `followUpMocReason` includes OTHER."

// ----------------------------------------------------------------------------
// Coordinator (signature block at bottom of form)
// ----------------------------------------------------------------------------
* coordinator 0..1 BackboneElement "Coordinating physician" "Arts coordinator (signature block)."
  * name 1..1 string "Name" "Free-text name."
  * rizivNumber 1..1 string "RIZIV number" "RIZIV/INAMI identifier."
  * institution 1..1 string "Institution" "Coordinator's institution."
  * signatureDate 1..1 date "Signature date" "Date of the coordinator's signature."
