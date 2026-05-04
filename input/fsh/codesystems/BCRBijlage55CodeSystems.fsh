// CodeSystems derived directly from Bijlage 55 (Pattern 1).
// Each code uses the numeric (or short alphanumeric) value as it appears on
// the form so the IG round-trips with the BCR data feeds.
// Source: https://www.riziv.fgov.be/SiteCollectionDocuments/formulier_verordening20030728_bijlage_55.pdf

// ----------------------------------------------------------------------------
// Bijlage 55 §2 — Basis voor diagnose (footnote 2)
// ----------------------------------------------------------------------------
CodeSystem: BCRBasisOfDiagnosis
Id: bcr-basis-of-diagnosis
Title: "BCR Basis of Diagnosis"
Description: "Most reliable method by which a cancer diagnosis was established. Bijlage 55, footnote 2."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #2 "Histology of primary tumour" "Histologie primaire tumor."
* #3 "Histology of metastasis" "Histologie metastase."
* #4 "Cytology / haematology" "Cytologie / hematologie."
* #5 "Technical investigation" "Technisch onderzoek (RX, endoscopie, …)."
* #6 "Clinical" "Klinisch."
* #7 "Tumour marker" "Tumormerker (PSA, hCG, AFP, Ig, …)."
* #8 "Cytogenetic / molecular tests" "Cytogenetische en/of moleculaire testen."
* #9 "Unknown" "Onbekend."

// ----------------------------------------------------------------------------
// Bijlage 55 §3 — WHO performance score (footnote 3)
// ----------------------------------------------------------------------------
CodeSystem: BCRWHOPerformanceScore
Id: bcr-who-performance-score
Title: "BCR WHO Performance Score"
Description: "Patient performance score at incidence date. Bijlage 55, footnote 3."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #0 "Asymptomatic, normal activity" "Asymptomatisch, normale activiteit."
* #1 "Symptomatic, ambulatory" "Symptomatisch, maar ambulant."
* #2 "Symptomatic, bedridden <50% per day" "Symptomatisch, bedlegerig <50% per dag."
* #3 "Symptomatic, bedridden >50% per day" "Symptomatisch, bedlegerig >50% per dag."
* #4 "Fully dependent, 100% bedridden" "Aangewezen op volledige verzorging, 100% bedlegerig."

// ----------------------------------------------------------------------------
// Bijlage 55 §5 — Lateraliteit (footnote 4)
// ----------------------------------------------------------------------------
CodeSystem: BCRLaterality
Id: bcr-laterality
Title: "BCR Laterality"
Description: "Laterality of the primary tumour. Bijlage 55, footnote 4."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #1 "Left" "Links."
* #2 "Right" "Rechts."
* #3 "Unpaired organ" "Onpaar orgaan."
* #NK "Unknown" "Niet gekend."

// ----------------------------------------------------------------------------
// Bijlage 55 §7 — Differentiatiegraad (footnote 5)
// ----------------------------------------------------------------------------
CodeSystem: BCRDifferentiationGrade
Id: bcr-differentiation-grade
Title: "BCR Differentiation Grade"
Description: "Degree of resemblance of tumour cells to the original tissue. Bijlage 55, footnote 5."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #1 "Well differentiated" "Goed gedifferentieerd."
* #2 "Moderately differentiated" "Matig gedifferentieerd."
* #3 "Poorly differentiated" "Weinig gedifferentieerd."
* #4 "Undifferentiated / anaplastic" "Ongedifferentieerd / anaplastisch."
* #5 "T-cell" "T-cel."
* #6 "B-cell" "B-cel."
* #7 "Null cell" "Nul-cel (niet T / niet B)."
* #8 "Natural killer (NK) cell" "Natural Killer (NK)-cel."
* #9 "Unknown" "Onbekend."

// ----------------------------------------------------------------------------
// Bijlage 55 §9 — Andere classificatie (footnote 6)
// ----------------------------------------------------------------------------
CodeSystem: BCROtherClassification
Id: bcr-other-classification
Title: "BCR Other Stage Classification"
Description: "Alternative staging classification used when applicable. Bijlage 55, footnote 6."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #1 "Childhood Cancer Stage" "Childhood Cancer Stage."
* #2 "FIGO" "FIGO."
* #3 "Lugano" "Lugano."
* #4 "Breslow (mm)" "Breslow (in mm)."
* #5 "Other" "Andere."

// ----------------------------------------------------------------------------
// Bijlage 55 §10A — Klinische studie (Ja/Nee/Onbekend)
// ----------------------------------------------------------------------------
CodeSystem: BCRClinicalTrialIndicator
Id: bcr-clinical-trial-indicator
Title: "BCR Clinical Trial Indicator"
Description: "Whether the cancer treatment is part of a clinical study. Bijlage 55, §10 A."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #ja "Yes" "Ja."
* #nee "No" "Nee."
* #onbekend "Unknown" "Onbekend."

// ----------------------------------------------------------------------------
// Bijlage 55 §10B and Vervolg 3 §II — diagnosis / treatment chronology codes
// (footnote 8). Includes both the main-form codes and the additional Vervolg 3
// code 15 (beenmergtransplantatie).
// ----------------------------------------------------------------------------
CodeSystem: BCRTreatmentCode
Id: bcr-treatment-code
Title: "BCR Diagnosis / Treatment Code"
Description: "Diagnosis and treatment chronology codes used on Bijlage 55 (main form footnote 8) and on Bijlage 55 vervolg 3."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #5 "Diagnosis" "Diagnose."
* #10 "Surgery" "Heelkunde."
* #11 "Excision biopsy" "Excisiebiopt."
* #15 "Bone marrow transplant" "Beenmergtransplantatie. Used only on Bijlage 55 vervolg 3; the main form distinguishes 16 (autologous HSCT) and 17 (allogeneic HSCT) instead."
* #16 "HSCT autologous" "Hematopoietische stamceltransplantatie — autoloog."
* #17 "HSCT allogeneic" "Hematopoietische stamceltransplantatie — allogeen."
* #20 "External radiotherapy / brachytherapy" "Externe radiotherapie / brachytherapie."
* #21 "IORT" "Intra-operatieve radiotherapie."
* #22 "Hadron therapy" "Hadrontherapie."
* #25 "Concurrent chemoradiotherapy" "Concomitant chemoradiotherapie."
* #26 "Concurrent radio-immunotherapy" "Concomitant radio-immunotherapie."
* #30 "Radio-isotopes" "Radio-isotopen."
* #35 "Phototherapy" "Fototherapie."
* #36 "Topical therapy" "Topicale therapie."
* #40 "Chemotherapy / systemic therapy" "Chemo-, systemische therapie."
* #45 "Targeted therapy" "Targeted therapy (excludes 26, 60)."
* #50 "Hormonal therapy" "Hormonale therapie."
* #60 "Immunotherapy" "Immunotherapie (excludes 26, 66)."
* #66 "Concurrent chemo-immunotherapy" "Concomitant chemo-immunotherapie."
* #70 "Symptomatic / palliative" "Symptomatisch / palliatief."
* #75 "Active surveillance" "Active surveillance / watchful waiting."
* #80 "Other treatment" "Andere behandeling. Free-text comment required when used."
* #90 "No therapy" "Geen therapie."
* #95 "Therapy refusal" "Weigering therapie."
* #99 "Unknown" "Onbekend."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 1 §1 — Menopauzale status (footnote 9)
// ----------------------------------------------------------------------------
CodeSystem: BCRMenopausalStatus
Id: bcr-menopausal-status
Title: "BCR Menopausal Status"
Description: "Menopausal status at diagnosis. Bijlage 55 vervolg 1, footnote 9."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #ja "Yes" "Ja, postmenopausaal."
* #nee "No" "Nee."
* #onduidelijk "Unclear" "Onduidelijk."
* #niet-gekend "Unknown" "Niet gekend."
* #niet-van-toepassing "Not applicable" "Niet van toepassing (mannelijke patiënt)."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 1 §2 — Molecular markers (table headers)
// ----------------------------------------------------------------------------
CodeSystem: BCRMolecularMarker
Id: bcr-molecular-marker
Title: "BCR Molecular Marker"
Description: "Molecular markers listed on Bijlage 55 vervolg 1. The form spells PIK3CA as 'PIKCA3'; the canonical gene symbol is preserved here."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #ER "Estrogen receptor" "Oestrogeen receptor status (ER)."
* #PR "Progesterone receptor" "Progesteron receptor status (PR)."
* #HER2-IHC "HER2 IHC score" "HER2 IHC score (0 / 1+ / 2+ / 3+)."
* #HER2-IHC-ISH "HER2 status (IHC + ISH combined)" "HER2 status op basis van IHC en ISH."
* #BRCA1-2 "BRCA1/2" "BRCA1/2 mutation status."
* #CHEK2 "CHEK2" "CHEK2 mutation status. Spelled 'CHECK2' on the source form."
* #PALB2 "PALB2" "PALB2 mutation status."
* #ATM "ATM" "ATM mutation status."
* #PIK3CA "PIK3CA" "PIK3CA mutation status. Spelled 'PIKCA3' on the source form."
* #KI67 "Ki-67 before systemic therapy" "Ki-67 vóór systemische therapie. Result is expressed as a percentage."
* #OTHER "Other" "Other marker — free-text marker name expected."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 1 §2 — Result codes (footnotes 10–13)
// One CodeSystem with all unique result codes; ValueSets below select per-marker subsets.
// ----------------------------------------------------------------------------
CodeSystem: BCRMolecularMarkerResult
Id: bcr-molecular-marker-result
Title: "BCR Molecular Marker Result"
Description: "Result codes used across the molecular-marker table on Bijlage 55 vervolg 1. Footnotes 10–13."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #positief "Positive" "Positief."
* #gering-positief "Borderline positive" "Gering positief."
* #negatief "Negative" "Negatief."
* #score-0 "IHC score 0" "HER2 IHC score 0."
* #score-1plus "IHC score 1+" "HER2 IHC score 1+."
* #score-2plus "IHC score 2+" "HER2 IHC score 2+."
* #score-3plus "IHC score 3+" "HER2 IHC score 3+."
* #her2-low "HER2 low" "HER2 low (provisional category — definitive value pending)."
* #niet-getest "Not tested" "Niet getest."
* #geen-mutatie "No mutation detected" "Geen mutatie gedetecteerd."
* #somatische-mutatie "Somatic mutation" "Somatische mutatie."
* #kiembaanmutatie "Germline mutation" "Kiembaanmutatie."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 1 §3b — Lymph node location (table headers)
// ----------------------------------------------------------------------------
CodeSystem: BCRLymphNodeLocation
Id: bcr-lymph-node-location
Title: "BCR Lymph Node Location"
Description: "Lymph node groups assessed in the breast tumour surgical block. Bijlage 55 vervolg 1, §3b."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #SENTINEL "Sentinel nodes" "Sentinelklieren."
* #AXILLARY "Axillary nodes" "Axillaire klieren."
* #OTHER "Other nodes" "Andere klieren."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 2 — Reden MOC
// ----------------------------------------------------------------------------
CodeSystem: BCRMOCReason
Id: bcr-moc-reason
Title: "BCR MOC Reason"
Description: "Reason for the multidisciplinary oncology consultation (MOC). Bijlage 55 vervolg 2."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #new-diagnosis "New cancer diagnosis" "Patiënt met een nieuwe diagnose van kanker."
* #guideline-deviation "Guideline-deviating treatment" "Voorafgaand aan een oncologische behandeling die afwijkt van de geschreven en aanvaarde richtlijnen."
* #repeat-radiation "Repeat radiation within 12 months" "Voorafgaand aan een herhaling van een bestralingsreeks van éénzelfde doelgebied binnen de twaalf maanden."
* #ctg-drug "CTG-monitored chemotherapy drug" "Voorafgaand aan een chemotherapeutische behandeling met een geneesmiddel aangeduid voor monitoring via MOC door de Commissie Tegemoetkoming Geneesmiddelen."
* #other "Other" "Andere (vrije tekst)."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 3 §I — Recidief type
// ----------------------------------------------------------------------------
CodeSystem: BCRRecurrenceType
Id: bcr-recurrence-type
Title: "BCR Recurrence Type"
Description: "Type(s) of recurrence at follow-up. Bijlage 55 vervolg 3, §I."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #local "Local" "Lokaal."
* #regional "Regional" "Regionaal."
* #metastatic "Metastatic" "Metastasen."

// ----------------------------------------------------------------------------
// Bijlage 55 vervolg 3 §III — Reden follow-up MOC
// ----------------------------------------------------------------------------
CodeSystem: BCRFollowUpMOCReason
Id: bcr-follow-up-moc-reason
Title: "BCR Follow-Up MOC Reason"
Description: "Reason for a follow-up MOC. Bijlage 55 vervolg 3, §III."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #recurrence "Recurrence" "Behandeling van een patiënt met een recidief."
* #progression "Progressive disease" "Behandeling van een patiënt met een progressieve ziekte."
* #guideline-deviation "Guideline-deviating treatment" "Voorafgaand aan elke oncologische behandeling die afwijkt van de aanvaarde richtlijnen."
* #repeat-radiation "Repeat radiation within 12 months" "Aan een herhaling van een bestralingsreeks van éénzelfde doelgebied binnen de twaalf maanden."
* #ctg-drug "CTG-monitored chemotherapy drug" "Aan elke chemotherapeutische behandeling met een geneesmiddel aangeduid voor monitoring via MOC door de Commissie Tegemoetkoming Geneesmiddelen."
* #other "Other" "Andere (vrije tekst)."
