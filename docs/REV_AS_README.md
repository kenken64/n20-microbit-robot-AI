# Revision AS - conservative diagnostic package

This is NOT a completed ERC cleanup. It adds project-local symbol libraries reconstructed from the schematic embedded cache, and marks the obsolete J2 interface DNP/excluded from BOM and PCB. J2 remains visible until its second pin and net are reviewed. All other electrical nets are unchanged.

Run `bash scripts/run_erc_mac.sh` on macOS. The report must be reviewed. No claim of zero ERC errors or warnings is made.

Remaining errors to investigate: U1 FB2 (fixed-output datasheet check), U1 VIN_A and U4 VCCA (source classification and power-path verification), J70 CTRL and NC (actual module pinout), J2 (remaining connection), D20 GND (source recognition). Off-grid geometry requires a deliberate redraw, not a blind coordinate snap. Production footprints require manufacturer land-pattern checks.

Do not order JLCPCB boards from this package.
