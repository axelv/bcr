#!/bin/bash
# Download the latest HL7 FHIR IG Publisher into input-cache/.
set -euo pipefail
mkdir -p input-cache
curl -L -o input-cache/publisher.jar \
  https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
echo "publisher.jar updated."
