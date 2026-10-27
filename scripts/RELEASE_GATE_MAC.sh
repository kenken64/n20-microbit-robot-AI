#!/bin/bash
set -u
cd "$(dirname "$0")/.."
CLI="$(command -v kicad-cli || true)"
if [ -z "$CLI" ]; then CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli; fi
if [ ! -x "$CLI" ]; then echo "KiCad CLI missing"; exit 2; fi
mkdir -p reports
"$CLI" sch erc -o reports/RevAV_ERC.txt microbit_N20_revAQ.kicad_sch
SC=$?
"$CLI" pcb drc -o reports/RevAV_DRC.txt pcb_planning/N20_RevAV_MECHANICAL_ONLY.kicad_pcb
PC=$?
echo "Schematic ERC status $SC; mechanical-board DRC status $PC"
echo "STOP: mechanical-only board contains no electronics or routing; NEVER upload as production Gerbers."
exit 1
