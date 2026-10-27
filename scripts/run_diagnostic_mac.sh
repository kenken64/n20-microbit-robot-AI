#!/bin/bash
set -u
cd "$(dirname "$0")/.." || exit 1
if ! command -v kicad-cli >/dev/null 2>&1; then
  export PATH="/Applications/KiCad/KiCad.app/Contents/MacOS:$PATH"
fi
if ! command -v kicad-cli >/dev/null 2>&1; then echo 'kicad-cli not found'; exit 127; fi
mkdir -p reports
kicad-cli version > reports/kicad_version.txt 2>&1
kicad-cli sch erc -o reports/erc_report_recheck.txt microbit_N20_revAQ.kicad_sch > reports/erc_console_recheck.txt 2>&1
status=$?
kicad-cli sch export netlist -o reports/schematic_netlist.net microbit_N20_revAQ.kicad_sch > reports/netlist_console.txt 2>&1
printf 'ERC exit status: %s\n' "$status"
printf 'Reports: reports/erc_report_recheck.txt, reports/erc_console_recheck.txt, reports/schematic_netlist.net\n'
exit "$status"
