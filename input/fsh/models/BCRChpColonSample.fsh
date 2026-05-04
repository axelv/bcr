// Source: BCR "Cyto-histopathology register colorectal - metadata".

Logical: BCRChpColonSample
Parent: BCRChpSample
Id: bcr-chp-colon-sample
Title: "BCR CHP Colorectal Sample (Logical Model)"
Description: """
Logical model of one colorectal cyto-histopathology sample registered in the Belgian Cancer Registry CHP register.
Covers all colorectal samples treated and delivered by Belgian pathological anatomy laboratories under the colorectal cancer screening programme.

Source: BCR — *Cyto-histopathology register colorectal - metadata*.
"""
* ^status = #draft
* ^experimental = true
* ^version = "0.1.0"

* sampleCategory 0..1 code "Sample category (fld_ca)" "Grouping of the sample into BCR-defined categories (colorectal screening category, e.g. screening / diagnostic / follow-up / surveillance)."
* sampleCategory from BCRSampleCategoryVS (preferred)
* dataConfidenceLevel 0..1 code "Data confidence level (fld_ge)" "Level of confidence in the registered data or result."
* dataConfidenceLevel from BCRDataConfidenceLevelVS (preferred)
