// CodeSystems for fields that BCR's published metadata documents *describe*
// in natural language but do not enumerate. Codes here are best-effort
// reconstructions and MUST be confirmed with BCR before any production use.
// All resources are marked draft and experimental.
// Sources: "Cancer in Belgium - metadata" v2 (2025-05-05) and the three
// Cyto-Histopathology register supplements (Breast / Cervix / Colon).

// ----------------------------------------------------------------------------
// fld_vs (BCRCancerCase) — vital status
// ----------------------------------------------------------------------------
CodeSystem: BCRVitalStatus
Id: bcr-vital-status
Title: "BCR Vital Status"
Description: """
Vital-status flag from the published research dataset (variable `fld_vs`).
The metadata describes three states; codes below are reconstructions —
**confirm with BCR before production use**.
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #alive "Alive" "Patiënt is levend."
* #deceased "Deceased" "Patiënt is overleden."
* #lost-to-followup "Lost to follow-up" "Patiënt is verloren in follow-up."

// ----------------------------------------------------------------------------
// borsttelling (BCRCancerCase) — breast tumour sequence indicator
// ----------------------------------------------------------------------------
CodeSystem: BCRBreastTumourSequence
Id: bcr-breast-tumour-sequence
Title: "BCR Breast Tumour Sequence"
Description: """
Indicates whether a breast tumour is the patient's first primary breast tumour
or a subsequent breast tumour (variable `borsttelling`). **Draft —
confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #first-primary "First primary breast tumour" "Eerste primaire borsttumor van de patiënt."
* #subsequent "Subsequent breast tumour" "Daaropvolgende borsttumor."

// ----------------------------------------------------------------------------
// region / region_source — Belgian regions
// ----------------------------------------------------------------------------
CodeSystem: BCRRegion
Id: bcr-region
Title: "BCR Belgian Region"
Description: """
Region of official residence (research dataset `region`) or laboratory location
(CHP supplements `region_source`). The metadata does not enumerate codes;
the three Belgian regions plus an explicit unknown placeholder are used here.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #flanders "Flanders" "Vlaams Gewest."
* #wallonia "Wallonia" "Waals Gewest."
* #brussels "Brussels-Capital" "Brussels Hoofdstedelijk Gewest."
* #unknown "Unknown" "Niet gekend."

// ----------------------------------------------------------------------------
// fld_ca (CHP breast / colon) — sample category
// ----------------------------------------------------------------------------
CodeSystem: BCRSampleCategory
Id: bcr-sample-category
Title: "BCR CHP Sample Category"
Description: """
Grouping of cyto-histopathology samples into BCR-defined categories
(`fld_ca` in the breast and colorectal CHP supplements). The metadata does
not enumerate codes; common screening-pathway categories are listed here.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #screening "Screening" "Sample taken in the screening pathway."
* #diagnostic "Diagnostic" "Sample taken for diagnostic work-up."
* #followup "Follow-up" "Sample taken at follow-up."
* #surveillance "Surveillance" "Sample taken for post-treatment surveillance."
* #other "Other" "Other context."

// ----------------------------------------------------------------------------
// fld_ge (CHP breast / colon) — data confidence level
// ----------------------------------------------------------------------------
CodeSystem: BCRDataConfidenceLevel
Id: bcr-data-confidence-level
Title: "BCR CHP Data Confidence Level"
Description: """
Level of confidence in the registered data or result (`fld_ge` in the breast
and colorectal CHP supplements). The metadata does not enumerate codes.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #high "High" "High confidence."
* #medium "Medium" "Medium confidence."
* #low "Low" "Low confidence."
* #unknown "Unknown" "Confidence level unknown."

// ----------------------------------------------------------------------------
// fld_hr (CHP cervix) — HPV test result
// ----------------------------------------------------------------------------
CodeSystem: BCRHPVTestResult
Id: bcr-hpv-test-result
Title: "BCR HPV Test Result"
Description: """
Result of the HPV test (`fld_hr` in the CHP cervix supplement). The metadata
does not enumerate codes; conventional HPV-test outcome codes are listed here.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #positive "Positive" "HPV test positive."
* #negative "Negative" "HPV test negative."
* #inconclusive "Inconclusive" "HPV test inconclusive."
* #not-done "Not done" "HPV test not performed."

// ----------------------------------------------------------------------------
// fld_qs (CHP cervix) — specimen quality
// ----------------------------------------------------------------------------
CodeSystem: BCRSpecimenQuality
Id: bcr-specimen-quality
Title: "BCR Specimen Quality"
Description: """
Assessment of the specimen's quality / adequacy for diagnosis (`fld_qs` in the
CHP cervix supplement). The metadata does not enumerate codes; common
adequacy categories are listed here. **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #adequate "Adequate" "Specimen is adequate for diagnosis."
* #adequate-with-limitations "Adequate with limitations" "Specimen is adequate but with limitations noted."
* #inadequate "Inadequate" "Specimen is inadequate for diagnosis."

// ----------------------------------------------------------------------------
// fld_ht (CHP cervix) — HPV genotypes detected
// ----------------------------------------------------------------------------
CodeSystem: BCRHPVType
Id: bcr-hpv-type
Title: "BCR HPV Genotype"
Description: """
HPV genotypes detected when the HPV test is positive (`fld_ht` in the CHP
cervix supplement). Multiple genotypes may be reported per sample.
The metadata does not enumerate codes; the WHO/IARC high- and low-risk HPV
genotypes are listed here. **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #16 "HPV-16" "High-risk HPV genotype 16."
* #18 "HPV-18" "High-risk HPV genotype 18."
* #31 "HPV-31" "High-risk HPV genotype 31."
* #33 "HPV-33" "High-risk HPV genotype 33."
* #35 "HPV-35" "High-risk HPV genotype 35."
* #39 "HPV-39" "High-risk HPV genotype 39."
* #45 "HPV-45" "High-risk HPV genotype 45."
* #51 "HPV-51" "High-risk HPV genotype 51."
* #52 "HPV-52" "High-risk HPV genotype 52."
* #56 "HPV-56" "High-risk HPV genotype 56."
* #58 "HPV-58" "High-risk HPV genotype 58."
* #59 "HPV-59" "High-risk HPV genotype 59."
* #66 "HPV-66" "High-risk HPV genotype 66."
* #68 "HPV-68" "High-risk HPV genotype 68."
* #6 "HPV-6" "Low-risk HPV genotype 6."
* #11 "HPV-11" "Low-risk HPV genotype 11."
* #other "Other genotype" "Other HPV genotype not in this list."
