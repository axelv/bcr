// Source: BCR "Cyto-histopathology register breast - metadata".

Logical: BCRChpBreastSample
Parent: BCRChpSample
Id: bcr-chp-breast-sample
Title: "BCR CHP Breast Sample (Logical Model)"
Description: """
Logical model of one breast cyto-histopathology sample registered in the Belgian Cancer Registry CHP register.
Covers all breast samples treated and delivered by Belgian pathological anatomy laboratories under the breast cancer screening programme.

Source: BCR — *Cyto-histopathology register breast - metadata*.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

* sampleCategory 0..1 code "Sample category (fld_ca)" "Grouping of the sample into BCR-defined categories (breast screening category, e.g. screening / diagnostic / follow-up)."
* sampleCategory from BCRSampleCategoryVS (preferred)
* laterality 0..1 code "Laterality (fld_lt)" "Laterality of the sample (left, right, bilateral, not applicable)."
* laterality from BCRLateralityVS (required)
* dataConfidenceLevel 0..1 code "Data confidence level (fld_ge)" "Level of confidence in the registered data or result."
* dataConfidenceLevel from BCRDataConfidenceLevelVS (preferred)
