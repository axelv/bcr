// Worked example of the asynchronous FHIR submission & validation flow.
// Story: Hospital X submits a cancer registration. Attempt 1 fails validation
// (topography missing); the physician corrects the form and resubmits;
// attempt 2 is accepted and the registry issues a registration id. The
// long-lived registration Task never rewinds its status — it tracks progress
// via businessStatus and points at the assigned id on acceptance.

// ----------------------------------------------------------------------------
// Supporting actors
// ----------------------------------------------------------------------------
Instance: BCRExamplePatient
InstanceOf: Patient
Title: "Example BCR Patient"
Description: "Illustrative patient for the async-validation worked example."
Usage: #example
* identifier.system = $ssin
* identifier.value = "62032100123"
* name.text = "Example Patient"
* gender = #female
* birthDate = "1962-03-21"

Instance: BCRExampleRegistry
InstanceOf: Organization
Title: "Belgian Cancer Registry (example)"
Description: "The registry that imposes the registration obligation and runs validation."
Usage: #example
* name = "Stichting Kankerregister / Fondation Registre du Cancer"

Instance: BCRExampleHospital
InstanceOf: Organization
Title: "Example Oncology Hospital"
Description: "The submitting hospital, legally obliged to register cancer cases."
Usage: #example
* name = "Example Oncology Hospital"

Instance: BCRExampleValidationService
InstanceOf: Organization
Title: "BCR FHIR Validation Service"
Description: "The national server endpoint that performs asynchronous validation."
Usage: #example
* name = "BCR FHIR Validation Service"

// ----------------------------------------------------------------------------
// The submitted QuestionnaireResponse (attempt 1 — topography omitted)
// ----------------------------------------------------------------------------
Instance: ExampleBCRSubmittedQuestionnaireResponse
InstanceOf: QuestionnaireResponse
Title: "Example Submitted Cancer Registration (QuestionnaireResponse)"
Description: "An attempt-1 BCR cancer-registration form submitted for validation. Status is in-progress: it is an incomplete submission (topography and other required items are still missing) which is exactly why validation fails."
Usage: #example
* questionnaire = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/Questionnaire/ExampleBCRDummyQuestionnaire"
* status = #in-progress
* subject = Reference(BCRExamplePatient) "Example Patient"
* author = Reference(BCRExampleHospital) "Example Oncology Hospital"
* authored = "2026-05-20T10:15:00+02:00"
* item[+].linkId = "tumour"
* item[=].text = "Tumour identification & staging"
* item[=].item[+].linkId = "tumour.incidenceDate"
* item[=].item[=].answer.valueDate = "2025-09-14"
* item[=].item[+].linkId = "tumour.histologyBehaviour"
* item[=].item[=].answer.valueCoding = https://www.ehealth.fgov.be/standards/fhir/registries/bcr/CodeSystem/bcr-behaviour#3 "Malignant, primary"

// ----------------------------------------------------------------------------
// Validation outcomes
// ----------------------------------------------------------------------------
Instance: ExampleBCRValidationOutcomeFailed
InstanceOf: BCRValidationOutcome
Title: "Example Validation Outcome — failed"
Description: "Blocking validation errors returned for attempt 1."
Usage: #example
* issue[0].severity = #error
* issue[0].code = #required
* issue[0].details.text = "Primary tumour topography (section 7) is mandatory when the behaviour code indicates a malignant tumour."
* issue[0].expression[0] = "QuestionnaireResponse.item.where(linkId='tumour').item.where(linkId='tumour.primaryTumourLocation')"
* issue[1].severity = #warning
* issue[1].code = #business-rule
* issue[1].details.text = "Incidence date is more than 6 months before the submission date; please confirm the incidence date is correct."
* issue[1].expression[0] = "QuestionnaireResponse.item.where(linkId='tumour').item.where(linkId='tumour.incidenceDate')"

Instance: ExampleBCRValidationOutcomeAccepted
InstanceOf: BCRValidationOutcome
Title: "Example Validation Outcome — accepted"
Description: "Successful validation result for attempt 2."
Usage: #example
* issue[0].severity = #information
* issue[0].code = #informational
* issue[0].details.text = "Submission validated successfully. The cancer case has been registered."

// ----------------------------------------------------------------------------
// Validation attempts (sub-tasks of the registration obligation)
// ----------------------------------------------------------------------------
Instance: ExampleBCRValidationTaskFailed
InstanceOf: BCRValidationTask
Title: "Example Validation Task — attempt 1 (failed)"
Description: "First submission attempt; validation found a blocking error."
Usage: #example
* status = #failed
* statusReason = BCRTaskStatusReason#validation-failed
* intent = #order
* code = BCRTaskCode#validate-submission
* authoredOn = "2026-05-20T10:16:00+02:00"
* lastModified = "2026-05-20T10:31:00+02:00"
* partOf[0] = Reference(ExampleBCRRegistrationTask)
* focus = Reference(ExampleBCRSubmittedQuestionnaireResponse) "Submitted QuestionnaireResponse"
* for = Reference(BCRExamplePatient) "Example Patient"
* requester = Reference(BCRExampleHospital) "Example Oncology Hospital"
* owner = Reference(BCRExampleValidationService) "BCR FHIR Validation Service"
* input[questionnaireResponse].type = BCRTaskIO#questionnaire-response
* input[questionnaireResponse].valueReference = Reference(ExampleBCRSubmittedQuestionnaireResponse)
* output[validationOutcome].type = BCRTaskIO#validation-outcome
* output[validationOutcome].valueReference = Reference(ExampleBCRValidationOutcomeFailed)

Instance: ExampleBCRValidationTaskAccepted
InstanceOf: BCRValidationTask
Title: "Example Validation Task — attempt 2 (completed)"
Description: "Corrected resubmission; validation passed and a registration id was issued."
Usage: #example
* status = #completed
* intent = #order
* code = BCRTaskCode#validate-submission
* authoredOn = "2026-05-22T09:00:00+02:00"
* lastModified = "2026-05-22T09:12:00+02:00"
* partOf[0] = Reference(ExampleBCRRegistrationTask)
* focus = Reference(ExampleBCRSubmittedQuestionnaireResponse) "Corrected QuestionnaireResponse"
* for = Reference(BCRExamplePatient) "Example Patient"
* requester = Reference(BCRExampleHospital) "Example Oncology Hospital"
* owner = Reference(BCRExampleValidationService) "BCR FHIR Validation Service"
* input[questionnaireResponse].type = BCRTaskIO#questionnaire-response
* input[questionnaireResponse].valueReference = Reference(ExampleBCRSubmittedQuestionnaireResponse)
* output[validationOutcome].type = BCRTaskIO#validation-outcome
* output[validationOutcome].valueReference = Reference(ExampleBCRValidationOutcomeAccepted)
* output[registrationId].type = BCRTaskIO#registration-id
* output[registrationId].valueIdentifier.system = "https://www.ehealth.fgov.be/standards/fhir/registries/bcr/NamingSystem/registration-id"
* output[registrationId].valueIdentifier.value = "BCR-2026-0001234"

// ----------------------------------------------------------------------------
// The long-lived registration obligation (shown mid-flow: correction-required)
// ----------------------------------------------------------------------------
Instance: ExampleBCRRegistrationTask
InstanceOf: BCRRegistrationTask
Title: "Example Registration Task"
Description: "The hospital's obligation to register the case. Status moves forward only; the failed first attempt is reflected as businessStatus = correction-required."
Usage: #example
* status = #in-progress
* businessStatus = BCRTaskBusinessStatus#correction-required
* intent = #order
* code = BCRTaskCode#register-cancer-case
* authoredOn = "2026-05-19T08:00:00+02:00"
* lastModified = "2026-05-20T10:31:00+02:00"
* focus = Reference(ExampleBCRDummyQuestionnaire) "BCR Cancer Registration Form"
* for = Reference(BCRExamplePatient) "Example Patient"
* requester = Reference(BCRExampleRegistry) "Belgian Cancer Registry"
* owner = Reference(BCRExampleHospital) "Example Oncology Hospital"
* restriction.period.start = "2025-09-14"
* restriction.period.end = "2026-03-14"

// ----------------------------------------------------------------------------
// Subscription — how the hospital learns the validation result
// ----------------------------------------------------------------------------
Instance: ExampleBCRValidationSubscription
InstanceOf: Subscription
Title: "Example Validation Result Subscription"
Description: "Hospital X is notified by rest-hook whenever a validation attempt for this registration reaches a terminal state."
Usage: #example
* status = #active
* reason = "Notify the submitting hospital when validation of a BCR cancer-registration submission completes or fails."
* criteria = "Task?part-of=Task/ExampleBCRRegistrationTask&status=completed,failed"
* channel.type = #rest-hook
* channel.endpoint = "https://his.hospital-x.example/fhir/bcr/validation-callback"
* channel.payload = #"application/fhir+json"
* channel.header[0] = "Authorization: Bearer <token>"
