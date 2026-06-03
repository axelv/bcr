// CodeSystems for the asynchronous FHIR submission & validation channel
// (see dataflow.md → "Async FHIR submission & validation"). These drive the
// two Task profiles (BCRRegistrationTask / BCRValidationTask) and let the
// long-lived registration obligation move *forward only* while the per-attempt
// validation detail is carried on the validation Tasks (status / statusReason /
// submission-intent / output). All resources are marked draft and experimental.

// ----------------------------------------------------------------------------
// Task.code — what kind of work the Task represents
// ----------------------------------------------------------------------------
CodeSystem: BCRTaskCode
Id: bcr-task-code
Title: "BCR Task Code"
Description: """
Distinguishes the two Tasks used in the asynchronous submission channel: the
long-lived **registration obligation** and the short-lived, per-attempt
**validation** Task. **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #register-cancer-case "Register cancer case" "Obligation on a hospital to register a new cancer case for a patient. One per case; status only ever moves forward."
* #validate-submission "Validate submission" "A single submission of a QuestionnaireResponse to the national validation service. One per attempt."

// ----------------------------------------------------------------------------
// Task.statusReason — why a validation Task reached a terminal state
// ----------------------------------------------------------------------------
CodeSystem: BCRTaskStatusReason
Id: bcr-task-status-reason
Title: "BCR Task Status Reason"
Description: """
Coded reason explaining why a `BCRValidationTask` `failed` (R4 `Task.statusReason`
is a `CodeableConcept`, so the human-readable detail lives in the linked
`OperationOutcome` referenced from `Task.output`). **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #validation-failed "Validation failed" "The submission contained one or more blocking validation errors."
* #processing-error "Processing error" "A system error prevented validation from completing."
* #duplicate-submission "Duplicate submission" "A registration for this case already exists."
* #superseded "Superseded" "A newer submission attempt replaced this one before it completed."

// ----------------------------------------------------------------------------
// Task.input.type / Task.output.type — typed payload slots
// ----------------------------------------------------------------------------
CodeSystem: BCRTaskIO
Id: bcr-task-io
Title: "BCR Task Input/Output Type"
Description: """
Types for the `Task.input` and `Task.output` slices used by the submission
workflow. **Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #questionnaire-response "QuestionnaireResponse" "Input: the completed cancer-registration QuestionnaireResponse being validated."
* #submission-intent "Submission intent" "Input: whether this submission is a partial (interim) or final submission of the registration."
* #validation-outcome "Validation outcome" "Output: the OperationOutcome carrying the validation result (errors / warnings / success)."
* #registration-id "Registration identifier" "Output: the registry-assigned identifier issued when a case is accepted."

// ----------------------------------------------------------------------------
// Submission intent — does this submission attempt close the registration?
// ----------------------------------------------------------------------------
CodeSystem: BCRSubmissionIntent
Id: bcr-submission-intent
Title: "BCR Submission Intent"
Description: """
The submitting hospital's intent for a single `BCRValidationTask`: whether the
submitted `QuestionnaireResponse` is an interim (**partial**) submission or the
**final** submission for the cancer case. A `BCRRegistrationTask` may only be
closed (`status = completed`) after a `final` submission validates successfully.
**Draft — confirm with BCR.**
"""
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #partial "Partial submission" "An interim submission; the case is not yet complete and a further (final) submission is expected. A successful partial submission does not close the registration."
* #final "Final submission" "The submission the hospital considers complete; on successful validation the registration can be closed."
