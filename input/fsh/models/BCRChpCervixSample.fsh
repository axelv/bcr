// Source: BCR "Cyto-histopathology register cervix - metadata".

Logical: BCRChpCervixSample
Parent: BCRChpSample
Id: bcr-chp-cervix-sample
Title: "BCR CHP Cervix Sample (Logical Model)"
Description: """
Logical model of one cervical cyto-histopathology sample registered in the Belgian Cancer Registry CHP register.
Covers all cervical samples treated and delivered by Belgian pathological anatomy laboratories under the cervical cancer screening programme.

Source: BCR — *Cyto-histopathology register cervix - metadata*.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

* hpvTestResult 0..1 code "HPV test result (fld_hr)" "Result of the HPV test on the sample (typically positive / negative / not done / inconclusive)."
* hpvTestResult from BCRHPVTestResultVS (preferred)
* hpvType 0..* code "HPV type detected (fld_ht)" "HPV genotype(s) detected when the HPV test is positive. Multiple types may be reported per sample."
* hpvType from BCRHPVTypeVS (preferred)
* specimenQuality 0..1 code "Specimen quality (fld_qs)" "Assessment of the specimen's quality / adequacy for diagnosis."
* specimenQuality from BCRSpecimenQualityVS (preferred)
