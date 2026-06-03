// ValueSets for the asynchronous FHIR submission & validation channel.
// One "all codes" ValueSet per workflow CodeSystem, bound from the Task
// profiles in profiles/BCRSubmissionWorkflow.fsh.

ValueSet: BCRTaskCodeVS
Id: bcr-task-code-vs
Title: "BCR Task Code"
Description: "All codes from BCRTaskCode. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRTaskCode

ValueSet: BCRTaskStatusReasonVS
Id: bcr-task-status-reason-vs
Title: "BCR Task Status Reason"
Description: "All codes from BCRTaskStatusReason. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRTaskStatusReason

ValueSet: BCRTaskIOVS
Id: bcr-task-io-vs
Title: "BCR Task Input/Output Type"
Description: "All codes from BCRTaskIO. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRTaskIO

ValueSet: BCRSubmissionIntentVS
Id: bcr-submission-intent-vs
Title: "BCR Submission Intent"
Description: "All codes from BCRSubmissionIntent. **Draft — confirm with BCR.**"
* ^status = #draft
* ^experimental = true
* include codes from system BCRSubmissionIntent
