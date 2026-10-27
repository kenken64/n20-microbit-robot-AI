#!/bin/bash
set -eu
cd "$(dirname "$0")/.."
CLI="$(command -v kicad-cli || true)"
if [ -z "$CLI" ]; then CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli; fi
if [ ! -x "$CLI" ]; then echo 'KiCad CLI missing'; exit 127; fi
mkdir -p reports/validation
"$CLI" version > reports/validation/kicad_version.txt
set +e
"$CLI" sch erc --output reports/validation/erc_report.txt microbit_N20_revAQ.kicad_sch
ERC=$?
"$CLI" sch export netlist --output reports/validation/schematic_netlist.net microbit_N20_revAQ.kicad_sch
NET=$?
set -e
printf 'ERC exit=%s, netlist exit=%s\n' "$ERC" "$NET" | tee reports/validation/status.txt
if [ "$ERC" -ne 0 ] || [ "$NET" -ne 0 ]; then echo 'RELEASE BLOCKED: schematic validation'; exit 1; fi
if [ ! -f robot_final.kicad_pcb ]; then echo 'RELEASE BLOCKED: no routed robot_final.kicad_pcb'; exit 2; fi
set +e
"$CLI" pcb drc --output reports/validation/drc_report.txt robot_final.kicad_pcb
DRC=$?
set -e
if [ "$DRC" -ne 0 ]; then echo 'RELEASE BLOCKED: PCB DRC'; exit 3; fi
# No automatic CAM export: electrical and mechanical/assembly approval also required.
echo 'ERC and DRC passed, but fabrication requires manual approval of socket, power tests, footprints, BOM and CPL.'
exit 0
