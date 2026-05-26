Alias: $itemControl = http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl
Alias: $qItemControl = http://hl7.org/fhir/questionnaire-item-control
Alias: $tiroItemControl = http://fhir.tiro.health/CodeSystem/tiro-item-control
Alias: $BCRForm = https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form
Alias: $VS = https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet

Instance: ExampleBCRDummyQuestionnaire
InstanceOf: Questionnaire
Title: "BCR Cancer Registration Form Questionnaire"
Description: "Example Questionnaire mirroring the BCR Cancer Registration Form (Bijlage 55). Item definitions point at the corresponding elements of the BCRCancerRegistrationForm logical model."
Usage: #example

* url = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/Questionnaire/ExampleBCRDummyQuestionnaire"
* version = "0.1.0"
* name = "ExampleBCRDummyQuestionnaire"
* title = "BCR Cancer Registration Form Questionnaire"
* status = #draft
* experimental = true
* subjectType = #Patient
* date = "2026-05-22"
* publisher = "eHealth Platform Belgium"

// ----------------------------------------------------------------------------
// 0. Patient identification
// ----------------------------------------------------------------------------
* item[+].linkId = "patient"
* item[=].text = "Patient identification"
* item[=].type = #group
* item[=].extension[+].url = $itemControl
* item[=].extension[=].valueCodeableConcept.coding[+].system = $qItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #tab
* item[=].extension[=].valueCodeableConcept.coding[+].system = $tiroItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #block

* item[=].item[+].linkId = "patient.name"
* item[=].item[=].text = "Patient name"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.patientName"

* item[=].item[+].linkId = "patient.birthDate"
* item[=].item[=].text = "Date of birth"
* item[=].item[=].type = #date
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.birthDate"

* item[=].item[+].linkId = "patient.ssin"
* item[=].item[=].text = "INSZ / Ziekenfondsnummer"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.nationalOrInsuranceNumber"

* item[=].item[+].linkId = "patient.sex"
* item[=].item[=].text = "Sex"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-sex-at-birth-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.sex"

// ----------------------------------------------------------------------------
// 1. Tumour identification and staging (sections 1–9 of the form)
// ----------------------------------------------------------------------------
* item[+].linkId = "tumour"
* item[=].text = "Tumour identification & staging"
* item[=].type = #group
* item[=].extension[+].url = $itemControl
* item[=].extension[=].valueCodeableConcept.coding[+].system = $qItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #tab
* item[=].extension[=].valueCodeableConcept.coding[+].system = $tiroItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #block

* item[=].item[+].linkId = "tumour.incidenceDate"
* item[=].item[=].text = "Incidence date"
* item[=].item[=].type = #date
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.incidenceDate"

* item[=].item[+].linkId = "tumour.basisOfDiagnosis"
* item[=].item[=].text = "Basis of diagnosis"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-basis-of-diagnosis-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.basisOfDiagnosis"

* item[=].item[+].linkId = "tumour.whoPerformanceScore"
* item[=].item[=].text = "WHO performance score at diagnosis"
* item[=].item[=].type = #coding
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-who-performance-score-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.whoPerformanceScore"

* item[=].item[+].linkId = "tumour.primaryTumourLocation"
* item[=].item[=].text = "Primary tumour localisation (ICD-O-3 topography)"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-topography-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.primaryTumourLocation"

* item[=].item[+].linkId = "tumour.laterality"
* item[=].item[=].text = "Laterality"
* item[=].item[=].type = #coding
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-laterality-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.laterality"

* item[=].item[+].linkId = "tumour.histologyMorphology"
* item[=].item[=].text = "Histology — morphology (ICD-O-3)"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-morphology-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.histologyMorphology"

* item[=].item[+].linkId = "tumour.histologyBehaviour"
* item[=].item[=].text = "Histology — behaviour"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-behaviour-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.histologyBehaviour"

* item[=].item[+].linkId = "tumour.differentiationGrade"
* item[=].item[=].text = "Differentiation grade"
* item[=].item[=].type = #coding
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-differentiation-grade-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.differentiationGrade"

// Clinical TNM
* item[=].item[+].linkId = "tumour.cTNM"
* item[=].item[=].text = "Clinical TNM (cTNM)"
* item[=].item[=].type = #group
* item[=].item[=].item[+].linkId = "tumour.clinicalT"
* item[=].item[=].item[=].text = "cT"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalT"
* item[=].item[=].item[+].linkId = "tumour.clinicalN"
* item[=].item[=].item[=].text = "cN"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalN"
* item[=].item[=].item[+].linkId = "tumour.clinicalM"
* item[=].item[=].item[=].text = "cM"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalM"

// Pathological TNM
* item[=].item[+].linkId = "tumour.pTNM"
* item[=].item[=].text = "Pathological TNM (pTNM)"
* item[=].item[=].type = #group
* item[=].item[=].item[+].linkId = "tumour.pathologicalT"
* item[=].item[=].item[=].text = "pT"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalT"
* item[=].item[=].item[+].linkId = "tumour.pathologicalN"
* item[=].item[=].item[=].text = "pN"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalN"
* item[=].item[=].item[+].linkId = "tumour.pathologicalM"
* item[=].item[=].item[=].text = "pM"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalM"

// Post-neoadjuvant pathological TNM (ypTNM)
* item[=].item[+].linkId = "tumour.ypTNM"
* item[=].item[=].text = "Post-neoadjuvant pathological TNM (ypTNM)"
* item[=].item[=].type = #group
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantT"
* item[=].item[=].item[=].text = "ypT"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantT"
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantN"
* item[=].item[=].item[=].text = "ypN"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantN"
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantM"
* item[=].item[=].item[=].text = "ypM"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantM"

// Other classification (section 9)
* item[=].item[+].linkId = "tumour.otherClassification"
* item[=].item[=].text = "Other classification"
* item[=].item[=].type = #coding
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-other-classification-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.otherClassification"

* item[=].item[+].linkId = "tumour.otherStageGroup"
* item[=].item[=].text = "Other classification — stage value"
* item[=].item[=].type = #string
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.otherStageGroup"

// ----------------------------------------------------------------------------
// 2. Diagnosis and primary treatments (section 10)
// ----------------------------------------------------------------------------
* item[+].linkId = "treatment"
* item[=].text = "Diagnosis & treatments"
* item[=].type = #group
* item[=].extension[+].url = $itemControl
* item[=].extension[=].valueCodeableConcept.coding[+].system = $qItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #tab
* item[=].extension[=].valueCodeableConcept.coding[+].system = $tiroItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #block

* item[=].item[+].linkId = "treatment.clinicalTrial"
* item[=].item[=].text = "Clinical trial participation"
* item[=].item[=].type = #coding
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-clinical-trial-indicator-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalTrialParticipation"

* item[=].item[+].linkId = "treatment.eudraCt"
* item[=].item[=].text = "EudraCT number"
* item[=].item[=].type = #string
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.eudraCtNumber"
* item[=].item[=].enableWhen[+].question = "treatment.clinicalTrial"
* item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].enableWhen[=].answerCoding.code = #ja

// Treatment chronology table (repeating)
* item[=].item[+].linkId = "treatment.episode"
* item[=].item[=].text = "Treatment chronology"
* item[=].item[=].type = #group
* item[=].item[=].repeats = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode"

* item[=].item[=].item[+].linkId = "treatment.episode.code"
* item[=].item[=].item[=].text = "Diagnosis / treatment code"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].required = true
* item[=].item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-treatment-chronology-vs"
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode.code"

* item[=].item[=].item[+].linkId = "treatment.episode.campusId"
* item[=].item[=].item[=].text = "Campus / vestigingsnummer"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode.campusId"

* item[=].item[=].item[+].linkId = "treatment.episode.startDate"
* item[=].item[=].item[=].text = "Start date"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].required = true
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode.startDate"

* item[=].item[=].item[+].linkId = "treatment.episode.endDate"
* item[=].item[=].item[=].text = "End date"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode.endDate"

* item[=].item[=].item[+].linkId = "treatment.episode.comment"
* item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.treatmentEpisode.comment"

// ----------------------------------------------------------------------------
// 3. Attachments (section 11)
// ----------------------------------------------------------------------------
* item[+].linkId = "attachments"
* item[=].text = "Attachments"
* item[=].type = #group
* item[=].extension[+].url = $itemControl
* item[=].extension[=].valueCodeableConcept.coding[+].system = $qItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #tab
* item[=].extension[=].valueCodeableConcept.coding[+].system = $tiroItemControl
* item[=].extension[=].valueCodeableConcept.coding[=].code = #block

* item[=].item[+].linkId = "attachments.mocReport"
* item[=].item[=].text = "MOC report"
* item[=].item[=].type = #attachment
* item[=].item[=].repeats = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.mocReport"
