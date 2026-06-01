// T / N / M subsets of BCRTNMCategory. Bound extensibly so subcategories
// (T1a, N2b, M1c, …) remain valid without enumerating them.

ValueSet: BCRTNMTVS
Id: bcr-tnm-t-vs
Title: "BCR TNM — T category"
Description: "Top-level UICC T categories (TX, T0, Tis, T1–T4)."
* ^status = #draft
* ^experimental = true
* BCRTNMCategory#TX
* BCRTNMCategory#T0
* BCRTNMCategory#Tis
* BCRTNMCategory#T1
* BCRTNMCategory#T2
* BCRTNMCategory#T3
* BCRTNMCategory#T4

ValueSet: BCRTNMNVS
Id: bcr-tnm-n-vs
Title: "BCR TNM — N category"
Description: "Top-level UICC N categories (NX, N0–N3)."
* ^status = #draft
* ^experimental = true
* BCRTNMCategory#NX
* BCRTNMCategory#N0
* BCRTNMCategory#N1
* BCRTNMCategory#N2
* BCRTNMCategory#N3

ValueSet: BCRTNMMVS
Id: bcr-tnm-m-vs
Title: "BCR TNM — M category"
Description: "Top-level UICC M categories (M0, M1)."
* ^status = #draft
* ^experimental = true
* BCRTNMCategory#M0
* BCRTNMCategory#M1
