// Pattern 3 — draft ValueSets for fields described but not enumerated in the
// public BCR metadata. All bind at `preferred` strength so downstream
// implementers can override until the BCR data dictionary is canonical.

ValueSet: BCRVitalStatusVS
Id: bcr-vital-status-vs
Title: "BCR Vital Status"
Description: "All codes from BCRVitalStatus. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRVitalStatus

ValueSet: BCRBreastTumourSequenceVS
Id: bcr-breast-tumour-sequence-vs
Title: "BCR Breast Tumour Sequence"
Description: "All codes from BCRBreastTumourSequence. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRBreastTumourSequence

ValueSet: BCRRegionVS
Id: bcr-region-vs
Title: "BCR Belgian Region"
Description: "All codes from BCRRegion. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRRegion

ValueSet: BCRSampleCategoryVS
Id: bcr-sample-category-vs
Title: "BCR CHP Sample Category"
Description: "All codes from BCRSampleCategory. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRSampleCategory

ValueSet: BCRDataConfidenceLevelVS
Id: bcr-data-confidence-level-vs
Title: "BCR CHP Data Confidence Level"
Description: "All codes from BCRDataConfidenceLevel. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRDataConfidenceLevel

ValueSet: BCRHPVTestResultVS
Id: bcr-hpv-test-result-vs
Title: "BCR HPV Test Result"
Description: "All codes from BCRHPVTestResult. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRHPVTestResult

ValueSet: BCRSpecimenQualityVS
Id: bcr-specimen-quality-vs
Title: "BCR Specimen Quality"
Description: "All codes from BCRSpecimenQuality. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRSpecimenQuality

ValueSet: BCRHPVTypeVS
Id: bcr-hpv-type-vs
Title: "BCR HPV Genotype"
Description: "All codes from BCRHPVType. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRHPVType
