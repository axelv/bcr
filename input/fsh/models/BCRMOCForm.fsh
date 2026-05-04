// Source: Bijlage 55 (vervolg 2) — Multidisciplinair Oncologisch Consult (MOC) form.
// Canonical PDF: https://www.riziv.fgov.be/SiteCollectionDocuments/formulier_verordening20030728_bijlage_55.pdf
// Submitted alongside the cancer registration form when the case was discussed at an MOC.

Logical: BCRMOCForm
Id: bcr-moc-form
Title: "BCR MOC Form — Bijlage 55 vervolg 2 (Logical Model)"
Description: """
Logical model of the Multidisciplinair Oncologisch Consult (MOC) attestation
attached to a Belgian cancer registration. Captures the reason for convening
the MOC, the coordinator, and the participants. Per RIZIV nomenclature
350276-350280 / 350291-350302 / 350372-350383, the coordinator confirms that
both the MOC report and the registration form have been completed.

Source: Bijlage 55 (vervolg 2) of the RIZIV Verordening of 28 July 2003,
amended 15 December 2025.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

// ----------------------------------------------------------------------------
// Patient identification (slim — DOB and sex not on this sub-form)
// ----------------------------------------------------------------------------
* patientName 1..1 string "Patient name" "Free-text patient name."
* nationalOrInsuranceNumber 1..1 string "INSZ / Ziekenfondsnummer" "Belgian national number (INSZ/NISS) or insurance fund number."

// ----------------------------------------------------------------------------
// Reason for the MOC
// ----------------------------------------------------------------------------
* mocReason 0..* code "Reason for MOC" """
Reason(s) for convening the MOC. Codes:
NEW_DIAGNOSIS = patient with a new cancer diagnosis;
GUIDELINE_DEVIATION = before oncological treatment that deviates from accepted written guidelines;
REPEAT_RADIATION = before a repeat irradiation of the same target area within twelve months;
CTG_DRUG = before chemotherapy with a drug flagged for MOC monitoring by the Commissie Tegemoetkoming Geneesmiddelen;
OTHER = other (specify in `mocOtherReason`).
"""
* mocReason from BCRMOCReasonVS (required)
* mocOtherReason 0..1 string "Other MOC reason" "Free-text reason when `mocReason` includes OTHER."

// ----------------------------------------------------------------------------
// Coordinator and participants
// ----------------------------------------------------------------------------
* requester 0..1 BackboneElement "MOC requester" "Physician requesting the MOC (Aanvrager MOC)."
  * name 1..1 string "Name" "Free-text name."
  * rizivNumber 1..1 string "RIZIV number" "RIZIV/INAMI identifier of the requester."

* coordinator 1..1 BackboneElement "MOC coordinator" "Coordinating physician for the MOC (Coördinator MOC)."
  * name 1..1 string "Name" "Free-text name."
  * rizivNumber 1..1 string "RIZIV number" "RIZIV/INAMI identifier of the coordinator."
  * institution 1..1 string "Institution" "Coordinator's institution."
  * mocDate 1..1 date "MOC date" "Date the MOC was held."

* participant 0..* BackboneElement "MOC participant" "Other physicians attending the MOC. The form provides four numbered slots plus one optional extramuros participant."
  * name 1..1 string "Name" "Free-text name."
  * rizivNumber 1..1 string "RIZIV number" "RIZIV/INAMI identifier of the participant."
  * extramuros 0..1 boolean "Extramuros participant" "True if this participant was the extramuros (extra-muros, non-hospital-staff) participant."

// ----------------------------------------------------------------------------
// Coordinator confirmation that nomenclature articles were respected and that
// the registration form was completed.
// ----------------------------------------------------------------------------
* coordinatorConfirmation 0..1 boolean "Coordinator confirmation" "Coordinator's signed confirmation that nomenclature articles 350276-350280, 350291-350302 and 350372-350383 were respected and that the cancer registration form was filled in."
