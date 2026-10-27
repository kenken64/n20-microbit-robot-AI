# Revision AV - PCB preparation, NOT a fabrication release

## Actual deliverables
- Preserved Revision AU schematic and local symbols; no unverified electrical modifications.
- Created native KiCad PCB **mechanical skeleton**: 86 x 103 mm rectangular outline and four 3.2 mm NPTH M3 mounting holes, 74 x 91 mm spacing. No copper, electronic footprints or routes.
- PCB coordinates follow reconstructed OpenSCAD: chassis center (0,0), board center (100,100), board extents x 57..143 y 48.5..151.5; M3 hole centers (63/137,54.5/145.5).
- Original historical mechanical references in Rev AT disagree with reconstructed chassis for battery, ultrasonic and motor positions. Those references are NOT imported.

## Baseline from user Mac ERC
7 errors, 377 warnings. These are **not fixed**. Category counts in ERC_CATEGORIES.csv. KiCad CLI unavailable in current runtime; no ERC/DRC run or pass claimed.

## Electrical blockers
- TPS630701 U1 VIN_A: connected to VMOTOR but not recognized as driven; verify protected battery path, pin 14 EN, and reference design. Do not add arbitrary PWR_FLAG.
- U4 VCCA MB_EDGE_3V: externally driven by micro:bit only when powered; check USB-only/battery-only/off-state.
- D20 GND: ground net connected, ERC source declaration missing; verify actual ground return.
- FB2 U1: pin 6 corrected to output and may be unused; NC marker still not recognized by KiCad.
- J70 CTRL/NC: verify Pololu QTRX-MD-03A connector physical pad order; NC marker still not recognized.
- J2 obsolete: excluded from board but still present in schematic; remove only after checking both pins.

## Manufacturer footprint blockers
- TPS630701 RNM 15-contact package: custom pad pattern must match TI drawing.
- DRV8833 PWP exposed-pad HTSSOP: confirm thermal pad, stencil and via rules.
- Coilcraft XFL4020: verify exact selected inductor size and pads.
- Four SK6812MINI-E LEDs: verify manufacturer pad numbering and dimensions.
- 4UCON 17809 / Parallax 450-00310 80-contact vertical socket: physical mapping and mating unverified; no footprint placed.
- TMUX1511 PW pinout and 3.3V/USB power-off analog isolation require review.

## Critical note
The reconstructed OpenSCAD model is a prototype and has not been physically fit-checked. The PCB skeleton is not ready for JLCPCB. Do not export it for fabrication.
