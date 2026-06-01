Alias: $itemControl = http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl
Alias: $qItemControl = http://hl7.org/fhir/questionnaire-item-control
Alias: $tiroItemControl = http://fhir.tiro.health/CodeSystem/tiro-item-control
Alias: $BCRForm = https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form
Alias: $VS = https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet

// UICC TNM top-level categories as coded quick-pick options for the T/N/M items.
// answerConstraint = #optionsOrType keeps subcategories (T1a, T1mi, N2b, M1c)
// enterable as additional codings.
RuleSet: TNMOptionsT
* item[=].item[=].item[=].answerConstraint = #optionsOrType
* item[=].item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-tnm-t-vs"

RuleSet: TNMOptionsN
* item[=].item[=].item[=].answerConstraint = #optionsOrType
* item[=].item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-tnm-n-vs"

RuleSet: TNMOptionsM
* item[=].item[=].item[=].answerConstraint = #optionsOrType
* item[=].item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-tnm-m-vs"

Instance: BCRCancerRegistrationFormQuestionnaire
InstanceOf: Questionnaire
Title: "BCR Cancer Registration Form Questionnaire"
Description: "Canonical data-entry Questionnaire for the BCR Cancer Registration Form (Bijlage 55). Item definitions point at the corresponding elements of the BCRCancerRegistrationForm logical model; a QuestionnaireResponse extracts into a bcr-cancer-registration-form instance (SDC definition-based extraction), and patient-identity items are pre-populated from a launched Patient (SDC expression-based population)."
Usage: #definition

* url = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/Questionnaire/BCRCancerRegistrationFormQuestionnaire"
* version = "0.1.0"
* name = "BCRCancerRegistrationFormQuestionnaire"
* title = "BCR Cancer Registration Form Questionnaire"
* status = #draft
* experimental = false
* subjectType = #Patient
* date = "2026-05-31"
* publisher = "eHealth Platform Belgium"

// ----------------------------------------------------------------------------
// SDC definition-based extraction: the whole response extracts into one
// bcr-cancer-registration-form logical-model instance. The per-item
// `definition` links below drive which element each answer populates.
// ----------------------------------------------------------------------------
* extension[+].url = $sdcExtract
* extension[=].valueExpression.language = #application/x-fhir-query
* extension[=].valueExpression.expression = $BCRForm

// ----------------------------------------------------------------------------
// SDC launch context: a Patient resource supplied at form launch, used by the
// population expressions on the patient-identity items below.
// ----------------------------------------------------------------------------
* extension[+].url = $sdcLaunchContext
* extension[=].extension[+].url = "name"
* extension[=].extension[=].valueCoding = $sdcLaunch#patient "Patient"
* extension[=].extension[+].url = "type"
* extension[=].extension[=].valueCode = #Patient
* extension[=].extension[+].url = "description"
* extension[=].extension[=].valueString = "The patient the registration form is about"

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
// Bind %patientRes to the launched Patient for the population expressions below.
* item[=].extension[+].url = $sdcItemPopCtx
* item[=].extension[=].valueExpression.name = #patientRes
* item[=].extension[=].valueExpression.language = #text/fhirpath
* item[=].extension[=].valueExpression.expression = "%patient"

* item[=].item[+].linkId = "patient.name"
* item[=].item[=].text = "Patient name"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.patientName"
* item[=].item[=].extension[+].url = $sdcInitial
* item[=].item[=].extension[=].valueExpression.language = #text/fhirpath
* item[=].item[=].extension[=].valueExpression.expression = "%patientRes.name.first().select(given.first() & ' ' & family)"

* item[=].item[+].linkId = "patient.birthDate"
* item[=].item[=].text = "Date of birth"
* item[=].item[=].type = #date
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.birthDate"
* item[=].item[=].extension[+].url = $sdcInitial
* item[=].item[=].extension[=].valueExpression.language = #text/fhirpath
* item[=].item[=].extension[=].valueExpression.expression = "%patientRes.birthDate"

* item[=].item[+].linkId = "patient.ssin"
* item[=].item[=].text = "INSZ / Ziekenfondsnummer"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.nationalOrInsuranceNumber"
* item[=].item[=].extension[+].url = $sdcInitial
* item[=].item[=].extension[=].valueExpression.language = #text/fhirpath
* item[=].item[=].extension[=].valueExpression.expression = "%patientRes.identifier.where(system = 'https://www.ehealth.fgov.be/standards/fhir/NamingSystem/ssin').value.first()"

* item[=].item[+].linkId = "patient.sex"
* item[=].item[=].text = "Sex"
* item[=].item[=].type = #coding
* item[=].item[=].required = true
* item[=].item[=].answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/ValueSet/bcr-sex-at-birth-vs"
* item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.sex"
* item[=].item[=].extension[+].url = $sdcInitial
* item[=].item[=].extension[=].valueExpression.language = #text/fhirpath
* item[=].item[=].extension[=].valueExpression.expression = "%patientRes.gender"

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
// ICD-O-3 cannot be expanded (only a fragment is on the terminology server), so
// the most common primary sites are inlined as answerOption. answerConstraint
// keeps any other ICD-O-3 topography code (C00–C80) enterable.
* item[=].item[=].answerConstraint = #optionsOrType
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C50.9 "Breast, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C34.9 "Lung / bronchus, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C61.9 "Prostate gland"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C18.9 "Colon, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C20.9 "Rectum, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C44.9 "Skin, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C67.9 "Bladder, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C16.9 "Stomach, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C25.9 "Pancreas, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C56.9 "Ovary"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C53.9 "Cervix uteri"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C54.1 "Endometrium"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C64.9 "Kidney, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C73.9 "Thyroid gland"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C22.0 "Liver"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C71.9 "Brain, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C15.9 "Esophagus, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C32.9 "Larynx, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C77.9 "Lymph nodes, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#C42.1 "Bone marrow"
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
// ICD-O-3 cannot be expanded (only a fragment is on the terminology server), so
// the most common histologies are inlined as answerOption. answerConstraint
// keeps any other ICD-O-3 morphology code enterable. Behaviour is captured
// separately on histologyBehaviour.
* item[=].item[=].answerConstraint = #optionsOrType
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8000 "Neoplasm, malignant"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8010 "Carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8070 "Squamous cell carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8140 "Adenocarcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8500 "Infiltrating duct carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8520 "Lobular carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8480 "Mucinous adenocarcinoma"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8260 "Papillary adenocarcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8720 "Malignant melanoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8090 "Basal cell carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8041 "Small cell carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8240 "Carcinoid tumour, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8120 "Urothelial (transitional cell) carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8312 "Renal cell carcinoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8211 "Tubular adenocarcinoma"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#9680 "Diffuse large B-cell lymphoma, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#9732 "Plasma cell myeloma"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#9861 "Acute myeloid leukaemia, NOS"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#9823 "B-cell chronic lymphocytic leukaemia / SLL"
* item[=].item[=].answerOption[+].valueCoding = $ICDO3#8046 "Non-small cell carcinoma"
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
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalT"
* insert TNMOptionsT
* item[=].item[=].item[+].linkId = "tumour.clinicalN"
* item[=].item[=].item[=].text = "cN"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalN"
* insert TNMOptionsN
* item[=].item[=].item[+].linkId = "tumour.clinicalM"
* item[=].item[=].item[=].text = "cM"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.clinicalM"
* insert TNMOptionsM

// Pathological TNM
* item[=].item[+].linkId = "tumour.pTNM"
* item[=].item[=].text = "Pathological TNM (pTNM)"
* item[=].item[=].type = #group
* item[=].item[=].item[+].linkId = "tumour.pathologicalT"
* item[=].item[=].item[=].text = "pT"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalT"
* insert TNMOptionsT
* item[=].item[=].item[+].linkId = "tumour.pathologicalN"
* item[=].item[=].item[=].text = "pN"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalN"
* insert TNMOptionsN
* item[=].item[=].item[+].linkId = "tumour.pathologicalM"
* item[=].item[=].item[=].text = "pM"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.pathologicalM"
* insert TNMOptionsM

// Post-neoadjuvant pathological TNM (ypTNM)
* item[=].item[+].linkId = "tumour.ypTNM"
* item[=].item[=].text = "Post-neoadjuvant pathological TNM (ypTNM)"
* item[=].item[=].type = #group
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantT"
* item[=].item[=].item[=].text = "ypT"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantT"
* insert TNMOptionsT
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantN"
* item[=].item[=].item[=].text = "ypN"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantN"
* insert TNMOptionsN
* item[=].item[=].item[+].linkId = "tumour.postNeoadjuvantM"
* item[=].item[=].item[=].text = "ypM"
* item[=].item[=].item[=].type = #coding
* item[=].item[=].item[=].definition = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/StructureDefinition/bcr-cancer-registration-form#bcr-cancer-registration-form.postNeoadjuvantM"
* insert TNMOptionsM

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
