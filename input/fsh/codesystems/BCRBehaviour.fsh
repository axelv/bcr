// Pattern 2 helper. ICD-O-3 publishes behaviour as a one-digit suffix on the
// morphology code (e.g. 8500/3). Because the BCRCancerRegistrationForm and
// BCRCancerCase models split morphology and behaviour into separate elements,
// we expose a small standalone CodeSystem for the digit-only behaviour value.

CodeSystem: BCRBehaviour
Id: bcr-behaviour
Title: "BCR ICD-O-3 Behaviour"
Description: "Single-digit ICD-O-3 behaviour code (the value after the slash on a morphology code such as 8500/3)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #0 "Benign" "Benigne."
* #1 "Uncertain malignant potential" "Borderline / onzekere maligne potentiaal."
* #2 "In situ" "In situ."
* #3 "Malignant, primary" "Maligne, primair."
* #6 "Malignant, metastatic" "Maligne, metastatisch."
* #9 "Malignant, uncertain primary or metastatic" "Maligne, onduidelijk of het primair dan wel metastatisch is."
