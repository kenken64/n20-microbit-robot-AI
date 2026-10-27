# N20 robot - Revision AT manufacturing release control

Status: **HOLD - DO NOT UPLOAD TO JLCPCB**.

Baseline: Revision AS ERC from 2026-10-28: **8 errors, 377 warnings**. No routed robot PCB or verified production CAM is included.

## Electrical blockers (from actual KiCad ERC)

- U4 pin 1 VCCA: power_pin_not_driven; net MB_EDGE_3V is sourced externally from micro:bit. Confirm physical connector, USB/battery source and power-off behavior before power source declaration.
- U1 pin 6 FB2: pin_not_connected and pin_not_driven. Confirm manufacturer configuration and rebuild exact pin-level symbol/connection; no-connect marker attempt did not resolve.
- U1 pin 12 VIN_A: power_pin_not_driven on VMOTOR. Confirm battery fuse, switch and reverse-polarity topology and power-source declaration.
- J70 pin 6 CTRL: pin_not_connected. Confirm Pololu QTRX emitter control pin and intended mode before wiring.
- J70 pin 7 NC: pin_not_connected. Verify exact harness mapping and proper KiCad no-connect placement.
- J2 pin 1 MB_3V: pin_not_connected. Obsolete abstract connector remains in schematic despite being excluded from PCB/BOM; remove after checking both pins and associated nets.
- D20 pin 3 GND: power_pin_not_driven. Confirm battery negative / ground network, then represent source appropriately.

## Warning classes

- Hundreds of endpoint_off_grid warnings: rebuild symbols and wires on KiCad connection grid, preserve netlist and check for shorts/splits after each section.
- Missing footprints: TPS630701 RNM, Coilcraft XFL4020, DRV8833 PWP, four SK6812MINI-E; do not substitute lookalike land patterns.
- Isolated labels: UNUSED_S4, UNUSED_D4, LED_LAST_DOUT; use deliberate NC markers or remove labels after checking use.

## Physical and fabrication blockers

- Manufacturer-verified 4UCON 17809 80-contact footprint and micro:bit V2 contact map not proven by connector breakout testing.
- USB/battery power-path and GPIO power-off isolation need bench verification.
- Robot board mechanical placement plan exists, but no fully footprint-populated routed robot board exists in this package.
- JLCPCB/LCSC live availability, assembly BOM, CPL and Gerbers not verified.

## Required evidence for release

1. KiCad ERC report with zero unwaived errors and all warnings reviewed.
2. Verified schematic netlist and component pin map against manufacturer datasheets.
3. Routed PCB aligned to Revision U chassis; copper zones filled; no unrouted connections.
4. KiCad DRC report with zero unwaived violations.
5. Visual Gerber/drill inspection, BOM/CPL, polarity and pin-1 orientation review.
6. Physical socket fit and power-path bench tests.
