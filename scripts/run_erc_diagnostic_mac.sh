#!/bin/bash
set -uo pipefail
cd "$(dirname "$0")/.."
CLI="$(command -v kicad-cli || true)"
if [ -z "$CLI" ] && [ -x /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli ]; then CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli; fi
if [ -z "$CLI" ]; then echo "kicad-cli not found"; exit 2; fi
mkdir -p reports
"$CLI" version > reports/kicad_version.txt 2>&1
"$CLI" sch erc --help > reports/erc_help.txt 2>&1
"$CLI" sch erc -o reports/erc_report.txt microbit_N20_revAQ.kicad_sch > reports/erc_console.txt 2>&1
STATUS=$?
echo "KiCad exit status: $STATUS" | tee -a reports/erc_console.txt
if [ "$STATUS" -ne 0 ]; then
 echo "ERC failed or found violations. Please upload reports/erc_console.txt and reports/erc_report.txt (if present)."
else
 echo "ERC command returned success. Inspect the report before proceeding."
fi
exit "$STATUS"
