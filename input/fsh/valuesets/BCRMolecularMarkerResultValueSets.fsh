// Per-marker subsets of BCRMolecularMarkerResult plus a union ValueSet.
// Logical-model elements bind to the union (`BCRMolecularMarkerResultVS`).
// The per-marker subsets are published for downstream consumers that want
// to validate marker-specific results (typically via slicing or invariants
// applied in a profile).

ValueSet: BCRMolecularMarkerResultERPRVS
Id: bcr-molecular-marker-result-er-pr-vs
Title: "BCR ER / PR Result"
Description: "Result codes valid for the ER and PR markers (Bijlage 55 vervolg 1, footnote 10)."
* ^status = #draft
* ^experimental = true
* BCRMolecularMarkerResult#positief
* BCRMolecularMarkerResult#gering-positief
* BCRMolecularMarkerResult#negatief

ValueSet: BCRMolecularMarkerResultHER2IHCVS
Id: bcr-molecular-marker-result-her2-ihc-vs
Title: "BCR HER2 IHC Score Result"
Description: "Result codes valid for the HER2 IHC score (Bijlage 55 vervolg 1, footnote 11)."
* ^status = #draft
* ^experimental = true
* BCRMolecularMarkerResult#score-0
* BCRMolecularMarkerResult#score-1plus
* BCRMolecularMarkerResult#score-2plus
* BCRMolecularMarkerResult#score-3plus

ValueSet: BCRMolecularMarkerResultHER2CombinedVS
Id: bcr-molecular-marker-result-her2-combined-vs
Title: "BCR HER2 Combined (IHC + ISH) Result"
Description: "Result codes valid for HER2 status based on combined IHC + ISH (Bijlage 55 vervolg 1, footnote 12)."
* ^status = #draft
* ^experimental = true
* BCRMolecularMarkerResult#positief
* BCRMolecularMarkerResult#her2-low
* BCRMolecularMarkerResult#negatief

ValueSet: BCRMolecularMarkerResultMutationVS
Id: bcr-molecular-marker-result-mutation-vs
Title: "BCR Gene Mutation Result"
Description: "Result codes valid for the BRCA1/2, CHEK2, PALB2, ATM, and PIK3CA markers (Bijlage 55 vervolg 1, footnote 13)."
* ^status = #draft
* ^experimental = true
* BCRMolecularMarkerResult#niet-getest
* BCRMolecularMarkerResult#geen-mutatie
* BCRMolecularMarkerResult#somatische-mutatie
* BCRMolecularMarkerResult#kiembaanmutatie

ValueSet: BCRMolecularMarkerResultKi67VS
Id: bcr-molecular-marker-result-ki67-vs
Title: "BCR Ki-67 Result"
Description: "Result codes valid for Ki-67 (Bijlage 55 vervolg 1, footnote 14). The percentage value is captured separately on `molecularMarker.resultPercentage`; this ValueSet only enumerates the categorical *not tested* sentinel."
* ^status = #draft
* ^experimental = true
* BCRMolecularMarkerResult#niet-getest

ValueSet: BCRMolecularMarkerResultVS
Id: bcr-molecular-marker-result-vs
Title: "BCR Molecular Marker Result (union)"
Description: "Union of all per-marker result codes. Bound on `BCRBreastTumourSupplement.molecularMarker.result`. Per-marker constraints are documented in the marker-specific ValueSets."
* ^status = #draft
* ^experimental = true
* include codes from system BCRMolecularMarkerResult
