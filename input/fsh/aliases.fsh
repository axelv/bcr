// Common terminology aliases for the BCR IG

Alias: $LOINC = http://loinc.org
Alias: $SCT = http://snomed.info/sct
Alias: $ICD10 = http://hl7.org/fhir/sid/icd-10
Alias: $ICDO3 = http://terminology.hl7.org/CodeSystem/icd-o-3
Alias: $UCUM = http://unitsofmeasure.org

// HL7 terminology
Alias: $obs-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $v3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $v3-RoleCode = http://terminology.hl7.org/CodeSystem/v3-RoleCode

// Belgian / eHealth identifiers (placeholders — confirm with eHealth catalogue)
Alias: $ssin = https://www.ehealth.fgov.be/standards/fhir/NamingSystem/ssin
Alias: $nihii = https://www.ehealth.fgov.be/standards/fhir/NamingSystem/nihii
Alias: $cbe = https://www.ehealth.fgov.be/standards/fhir/NamingSystem/cbe

// SDC (Structured Data Capture) — extraction & population extensions.
// hl7.fhir.uv.sdc has no FHIR R5 release, so these stable canonical URLs are
// referenced as bare strings (not loaded as a package); see ignoreWarnings.txt.
Alias: $sdcExtract = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemExtractionContext
Alias: $sdcLaunchContext = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext
Alias: $sdcLaunch = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext
Alias: $sdcInitial = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression
Alias: $sdcItemPopCtx = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemPopulationContext
