// ValueSets that bind 1:1 to the Bijlage 55-derived CodeSystems.
// All bindings on the logical models use these as the binding target, never
// the CodeSystem URL directly, so that future sub-setting / extension is
// non-breaking.

ValueSet: BCRBasisOfDiagnosisVS
Id: bcr-basis-of-diagnosis-vs
Title: "BCR Basis of Diagnosis"
Description: "All codes from BCRBasisOfDiagnosis."
* ^status = #draft
* ^experimental = true
* include codes from system BCRBasisOfDiagnosis

ValueSet: BCRWHOPerformanceScoreVS
Id: bcr-who-performance-score-vs
Title: "BCR WHO Performance Score"
Description: "All codes from BCRWHOPerformanceScore."
* ^status = #draft
* ^experimental = true
* include codes from system BCRWHOPerformanceScore

ValueSet: BCRLateralityVS
Id: bcr-laterality-vs
Title: "BCR Laterality"
Description: "All codes from BCRLaterality."
* ^status = #draft
* ^experimental = true
* include codes from system BCRLaterality

ValueSet: BCRDifferentiationGradeVS
Id: bcr-differentiation-grade-vs
Title: "BCR Differentiation Grade"
Description: "All codes from BCRDifferentiationGrade."
* ^status = #draft
* ^experimental = true
* include codes from system BCRDifferentiationGrade

ValueSet: BCROtherClassificationVS
Id: bcr-other-classification-vs
Title: "BCR Other Stage Classification"
Description: "All codes from BCROtherClassification."
* ^status = #draft
* ^experimental = true
* include codes from system BCROtherClassification

ValueSet: BCRClinicalTrialIndicatorVS
Id: bcr-clinical-trial-indicator-vs
Title: "BCR Clinical Trial Indicator"
Description: "All codes from BCRClinicalTrialIndicator."
* ^status = #draft
* ^experimental = true
* include codes from system BCRClinicalTrialIndicator

ValueSet: BCRTreatmentChronologyVS
Id: bcr-treatment-chronology-vs
Title: "BCR Treatment Chronology Code"
Description: "Treatment chronology codes accepted on the main Bijlage 55 form (footnote 8). Excludes code 15 (bone marrow transplant), which is only used on Bijlage 55 vervolg 3."
* ^status = #draft
* ^experimental = true
* include codes from system BCRTreatmentCode where concept is-not-a #15

ValueSet: BCRIntendedTreatmentVS
Id: bcr-intended-treatment-vs
Title: "BCR Intended Treatment Code"
Description: "Intent-to-treat codes accepted on Bijlage 55 vervolg 3 (§II)."
* ^status = #draft
* ^experimental = true
* BCRTreatmentCode#10
* BCRTreatmentCode#15
* BCRTreatmentCode#20
* BCRTreatmentCode#25
* BCRTreatmentCode#30
* BCRTreatmentCode#40
* BCRTreatmentCode#50
* BCRTreatmentCode#60
* BCRTreatmentCode#70
* BCRTreatmentCode#80
* BCRTreatmentCode#90
* BCRTreatmentCode#95

ValueSet: BCRMenopausalStatusVS
Id: bcr-menopausal-status-vs
Title: "BCR Menopausal Status"
Description: "All codes from BCRMenopausalStatus."
* ^status = #draft
* ^experimental = true
* include codes from system BCRMenopausalStatus

ValueSet: BCRMolecularMarkerVS
Id: bcr-molecular-marker-vs
Title: "BCR Molecular Marker"
Description: "All codes from BCRMolecularMarker."
* ^status = #draft
* ^experimental = true
* include codes from system BCRMolecularMarker

ValueSet: BCRLymphNodeLocationVS
Id: bcr-lymph-node-location-vs
Title: "BCR Lymph Node Location"
Description: "All codes from BCRLymphNodeLocation."
* ^status = #draft
* ^experimental = true
* include codes from system BCRLymphNodeLocation

ValueSet: BCRMOCReasonVS
Id: bcr-moc-reason-vs
Title: "BCR MOC Reason"
Description: "All codes from BCRMOCReason."
* ^status = #draft
* ^experimental = true
* include codes from system BCRMOCReason

ValueSet: BCRRecurrenceTypeVS
Id: bcr-recurrence-type-vs
Title: "BCR Recurrence Type"
Description: "All codes from BCRRecurrenceType."
* ^status = #draft
* ^experimental = true
* include codes from system BCRRecurrenceType

ValueSet: BCRFollowUpMOCReasonVS
Id: bcr-follow-up-moc-reason-vs
Title: "BCR Follow-Up MOC Reason"
Description: "All codes from BCRFollowUpMOCReason."
* ^status = #draft
* ^experimental = true
* include codes from system BCRFollowUpMOCReason

ValueSet: BCRBehaviourVS
Id: bcr-behaviour-vs
Title: "BCR ICD-O-3 Behaviour (digit only)"
Description: "All codes from BCRBehaviour."
* ^status = #draft
* ^experimental = true
* include codes from system BCRBehaviour
