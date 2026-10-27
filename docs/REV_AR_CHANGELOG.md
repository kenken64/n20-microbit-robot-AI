# Revision AR - conservative ERC corrections

Changes made to the Revision AQ source schematic:

- U1 VOUT_B pin 8 changed from power_out to passive in embedded symbol, preventing a false dual-power-output collision. **This pin classification must be checked against the exact TI symbol before production.**
- Added no-connect at U1 FB2 pin 6 (61.50,97.92), consistent with the proposed fixed 5 V configuration; confirm datasheet variant.
- Added no-connect at J70 NC pin 7 (105.50,608.62) as the proposed harness pin is named NC. This does NOT verify the physical Pololu harness numbering.

Not changed because actual net inspection/physical mapping is needed:

- U1 VIN_A pin 12 power-source warning: verify supply net and power-output declarations before adding a PWR_FLAG.
- U4 VCCA power-source warning: trace rail and sequencing.
- J70 CTRL pin 6: verify Pololu emitter control function and connector pinout.
- J2 obsolete power connector: must confirm its attached net is truly redundant before removal.
- D20 GND power-input type is valid; check ground net and source declaration.
- All off-grid endpoints, custom libraries, and missing footprints require correction.

**This is not a clean ERC pass.** KiCad CLI was not available for local verification.
