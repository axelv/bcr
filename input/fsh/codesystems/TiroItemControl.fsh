// Tiro form-renderer layout hints for Questionnaire item-control extensions.
// Hosted here (under Tiro's canonical) because the standard FHIR
// `questionnaire-item-control` code system does not define every layout hint
// the Tiro renderer needs — notably `tab`, which is not part of FHIR R4 (R4
// core defines only group/question/text). Registering this CodeSystem in the
// IG makes both codes resolvable so they validate cleanly on R4.
// See TIRO_INTEGRATION.md › "itemControl extensions".

CodeSystem: TiroItemControl
Id: tiro-item-control
Title: "Tiro Item Control"
Description: "Tiro-specific Questionnaire item-control layout hints read by the Tiro form renderer."
* ^url = "http://fhir.tiro.health/CodeSystem/tiro-item-control"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #tab "Tab" "Render this top-level group as a tab in the form."
* #block "Block" "Render this group's children as a Tiro layout block."
