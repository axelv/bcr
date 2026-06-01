// UICC TNM top-level categories. The form captures the c/p/y prefix implicitly
// through which element is used (clinical / pathological / post-neoadjuvant), so
// this CodeSystem holds only the bare category values. Subcategories (T1a, T1mi,
// N2b, M1c, …) are intentionally not enumerated — the bindings are extensible and
// the form items allow additional codings (answerConstraint = optionsOrType).

CodeSystem: BCRTNMCategory
Id: bcr-tnm-category
Title: "BCR TNM Category"
Description: "Top-level UICC TNM T/N/M categories used by the cTNM, pTNM and ypTNM elements of the cancer registration form."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #TX "TX" "Primary tumour cannot be assessed."
* #T0 "T0" "No evidence of primary tumour."
* #Tis "Tis" "Carcinoma in situ."
* #T1 "T1" "Primary tumour category T1."
* #T2 "T2" "Primary tumour category T2."
* #T3 "T3" "Primary tumour category T3."
* #T4 "T4" "Primary tumour category T4."
* #NX "NX" "Regional lymph nodes cannot be assessed."
* #N0 "N0" "No regional lymph node metastasis."
* #N1 "N1" "Regional lymph node category N1."
* #N2 "N2" "Regional lymph node category N2."
* #N3 "N3" "Regional lymph node category N3."
* #M0 "M0" "No distant metastasis."
* #M1 "M1" "Distant metastasis."
