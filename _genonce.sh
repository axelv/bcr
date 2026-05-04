#!/bin/bash
# Run SUSHI then the HL7 IG Publisher once.
set -euo pipefail
sushi build .
java -jar input-cache/publisher.jar -ig . "$@"
