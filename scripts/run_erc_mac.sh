#!/bin/bash
set -u
cd "$(dirname "$0")/.."
if ! command -v kicad-cli >/dev/null 2>&1; then export PATH="/Applications/KiCad/KiCad.app/Contents/MacOS:$PATH"; fi
mkdir -p reports
kicad-cli version > reports/kicad_version.txt 2>&1
kicad-cli sch erc -o reports/erc_report_AU.txt microbit_N20_revAQ.kicad_sch > reports/erc_console_AU.txt 2>&1
status=$?
kicad-cli sch export netlist -o reports/schematic_netlist_AU.net microbit_N20_revAQ.kicad_sch >> reports/erc_console_AU.txt 2>&1
printf 'ERC exit code: %s\n' "$status"
exit "$status"
