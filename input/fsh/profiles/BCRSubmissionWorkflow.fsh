// Profiles for the asynchronous FHIR submission & validation channel.
//
// Design (see async-validation.md): a single, long-lived registration
// obligation Task whose `status` only ever moves FORWARD, with each submission
// attempt modelled as its own short-lived validation Task. A failed validation
// is a terminal `failed` validation Task plus `correction-required` on the
// registration Task's businessStatus — the registration Task's `status` is
// never rewound. This mirrors the consistent guidance on chat.fhir.org that a
// Task status machine is forward-only and that "going back" is a new Task.

// ----------------------------------------------------------------------------
// Registration obligation — long-lived, one per cancer case
// ----------------------------------------------------------------------------
Profile: BCRRegistrationTask
Parent: Task
Id: bcr-registration-task
Title: "BCR Registration Task"
Description: """
The hospital's obligation to register a new cancer case with the Belgian Cancer
Registry, tracked across the whole lifecycle of submission and (re)validation.

`status` is **forward-only** (`requested → in-progress → completed`, or
`cancelled`/`failed` as terminal exits). All of the back-and-forth of repeated
validation attempts is reflected in `businessStatus`, not by rewinding `status`.
Each validation attempt is a separate `BCRValidationTask` linked via
`Task.partOf`.

**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* status MS
* businessStatus 1..1 MS
* businessStatus from BCRTaskBusinessStatusVS (required)
* intent = #order
* code 1..1 MS
* code = BCRTaskCode#register-cancer-case
* focus 0..1 MS
* focus only Reference(Questionnaire)
* for 1..1 MS
* for only Reference(Patient)
* requester 1..1 MS
* requester only Reference(Organization)
* owner 1..1 MS
* owner only Reference(Organization)
* authoredOn MS
* lastModified MS
* restriction.period 0..1 MS
// Registry-assigned identifier, attached on acceptance
* output ^slicing.discriminator.type = #pattern
* output ^slicing.discriminator.path = "type"
* output ^slicing.rules = #open
* output ^slicing.description = "Typed outputs of the registration obligation"
* output contains registrationId 0..1 MS
* output[registrationId].type = BCRTaskIO#registration-id
* output[registrationId].value[x] only Identifier

// ----------------------------------------------------------------------------
// Validation attempt — short-lived, one per submission
// ----------------------------------------------------------------------------
Profile: BCRValidationTask
Parent: Task
Id: bcr-validation-task
Title: "BCR Validation Task"
Description: """
A single submission of a completed cancer-registration `QuestionnaireResponse`
to the national validation service. Its `status` reflects the validation
lifecycle of *this attempt only*:

`requested → received → accepted → in-progress → completed | failed`

- `completed` — validation passed; `output` carries the validation
  `OperationOutcome` and (on success) the registry `registration-id`.
- `failed` — validation found blocking errors; `statusReason` gives the coded
  reason and `output` references the `OperationOutcome` listing the issues.

Attempts are linked to their parent `BCRRegistrationTask` via `Task.partOf`
and ordered by `authoredOn`; a corrected resubmission is simply a new
`BCRValidationTask`. **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* status MS
* statusReason MS
* statusReason from BCRTaskStatusReasonVS (extensible)
* intent = #order
* code 1..1 MS
* code = BCRTaskCode#validate-submission
* focus 1..1 MS
* focus only Reference(QuestionnaireResponse)
* for 1..1 MS
* for only Reference(Patient)
* requester 1..1 MS
* requester only Reference(Organization)
* owner 1..1 MS
* owner only Reference(Organization)
* partOf 1..1 MS
* partOf only Reference(BCRRegistrationTask)
* authoredOn MS
* lastModified MS
// Typed input: the QuestionnaireResponse under validation
* input ^slicing.discriminator.type = #pattern
* input ^slicing.discriminator.path = "type"
* input ^slicing.rules = #open
* input ^slicing.description = "Typed inputs of the validation attempt"
* input contains questionnaireResponse 1..1 MS
* input[questionnaireResponse].type = BCRTaskIO#questionnaire-response
* input[questionnaireResponse].value[x] only Reference(QuestionnaireResponse)
// Typed outputs: the validation outcome and (on success) the registration id
* output ^slicing.discriminator.type = #pattern
* output ^slicing.discriminator.path = "type"
* output ^slicing.rules = #open
* output ^slicing.description = "Typed outputs of the validation attempt"
* output contains
    validationOutcome 0..1 MS and
    registrationId 0..1 MS
* output[validationOutcome].type = BCRTaskIO#validation-outcome
* output[validationOutcome].value[x] only Reference(BCRValidationOutcome)
* output[registrationId].type = BCRTaskIO#registration-id
* output[registrationId].value[x] only Identifier

// ----------------------------------------------------------------------------
// Validation result — the OperationOutcome attached to a validation Task
// ----------------------------------------------------------------------------
Profile: BCRValidationOutcome
Parent: OperationOutcome
Id: bcr-validation-outcome
Title: "BCR Validation Outcome"
Description: """
The result of asynchronous validation of a cancer-registration submission,
referenced from `BCRValidationTask.output`. Each `issue` SHOULD use
`expression` (a FHIRPath into the submitted `QuestionnaireResponse`) so the
submitting system can point the user at the exact field to correct.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* issue 1..* MS
* issue.severity MS
* issue.code MS
* issue.details MS
* issue.expression MS
