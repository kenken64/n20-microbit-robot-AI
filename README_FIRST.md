# Revision AT - manufacturing release control

This package is a reproducible engineering baseline, NOT an orderable PCB. It includes the last available Revision AS schematic, its project-local custom symbols, original ERC report, and placement/routing planning files. The new script fails closed until schematic ERC and PCB DRC pass. It does not generate Gerbers automatically and does not claim the outstanding circuit issues are fixed.

On macOS: `bash scripts/run_release_gate_mac.sh`. Send back `reports/validation/erc_report.txt` and a routed `robot_final.kicad_pcb` when available. Consult docs/RELEASE_STATUS.md for all blockers.
