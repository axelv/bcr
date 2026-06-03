// Profiles for the asynchronous FHIR submission & validation channel.
//
// Design (see async-validation.md): a single, long-lived registration
// obligation Task whose `status` only ever moves FORWARD, with each submission
// attempt modelled as its own short-lived validation Task. A failed validation
// is a terminal `failed` validation Task; the registration Task's `status` is
// never rewound and the per-attempt state lives in the history of validation
// Tasks. This mirrors the consistent guidance on chat.fhir.org that a Task
// status machine is forward-only and that "going back" is a new Task.

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
The national service creates this Task when the hospital posts the `Condition`
that opens the case; `focus` points back at that `Condition`.

`status` is **forward-only**: `ready → in-progress → completed`, or
`cancelled`/`failed` as terminal exits.

- `ready → in-progress` is a side effect of the **first** `QuestionnaireResponse`
  submission (the first `BCRValidationTask`).
- `in-progress → completed` may be performed by **either** the registry or the
  hospital once they consider the oncology case complete — but only after a
  submission with `final` intent (see `BCRValidationTask`) has validated
  successfully.

All of the back-and-forth of repeated validation attempts lives in the **history
of `BCRValidationTask`s** (one per attempt, linked via `Task.partOf`), not on
this Task — the current situation (awaiting data, under validation, correction
required, partially or fully accepted) is **derived** from the most recent
attempt's `status`, `submission-intent` and `output`. A **correction after
completion** (a new `BCRValidationTask` arriving while this Task is already
`completed`) does **not** rewind `status`.

**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* status MS
* intent = #order
* code 1..1 MS
* code = BCRTaskCode#register-cancer-case
* focus 1..1 MS
* focus only Reference(Condition)
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

`requested → in-progress → completed | failed`

The client POSTs the Task as `requested`; on receipt the server moves it
straight to `in-progress` and validates in the background.

- `completed` — validation passed; `output` carries the validation
  `OperationOutcome` and (on success) the registry `registration-id`.
- `failed` — validation found blocking errors; `statusReason` gives the coded
  reason and `output` references the `OperationOutcome` listing the issues.

Every attempt declares a **submission intent** (`partial` or `final`) as a typed
`input`. The parent `BCRRegistrationTask` can only be closed after an attempt
with `final` intent validates successfully; a successful `partial` attempt
leaves the registration open (`status` stays `in-progress`).

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
* input contains
    questionnaireResponse 1..1 MS and
    submissionIntent 1..1 MS
* input[questionnaireResponse].type = BCRTaskIO#questionnaire-response
* input[questionnaireResponse].value[x] only Reference(QuestionnaireResponse)
* input[submissionIntent].type = BCRTaskIO#submission-intent
* input[submissionIntent].value[x] only CodeableConcept
* input[submissionIntent].value[x] from BCRSubmissionIntentVS (required)
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
