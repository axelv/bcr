// Pattern 2 — bindings to external standard vocabularies.
// Each ValueSet is a thin wrapper that selects all codes from the canonical
// system. Wrappers are kept so that future filters or restrictions can be
// applied without changing the binding URL.

ValueSet: BCRTopographyVS
Id: bcr-topography-vs
Title: "BCR ICD-O-3 Topography"
Description: """
ICD-O-3 codes used to express the primary tumour location (`fld_tp` in the
research dataset, `primaryTumourLocation` on Bijlage 55).
**Note:** ICD-O-3 has no published topography-only subset in FHIR; this
ValueSet includes the full system. Conformant data SHOULD use only ICD-O-3
*topography* codes (`C00`–`C80`) for this binding.
"""
* ^status = #draft
* ^experimental = true
* include codes from system $ICDO3

ValueSet: BCRMorphologyVS
Id: bcr-morphology-vs
Title: "BCR ICD-O-3 Morphology"
Description: """
ICD-O-3 morphology codes (without behaviour suffix). Conformant data SHOULD
use only the four-digit morphology portion (e.g. `8500`); the behaviour digit
is captured separately on `histologyBehaviour` (bound to `BCRBehaviourVS`).
"""
* ^status = #draft
* ^experimental = true
* include codes from system $ICDO3

ValueSet: BCRICD10VS
Id: bcr-icd10-vs
Title: "BCR ICD-10"
Description: "ICD-10 codes used to express cancer histology codes derived by BCR (`icd10` on the research dataset)."
* ^status = #draft
* ^experimental = true
* include codes from system http://hl7.org/fhir/sid/icd-10

ValueSet: BCRSexAtBirthVS
Id: bcr-sex-at-birth-vs
Title: "BCR Sex at Birth"
Description: "Administrative gender codes used for the BCR `sex` / `sexAtBirth` fields."
* ^status = #draft
* ^experimental = true
* include codes from system http://hl7.org/fhir/administrative-gender
