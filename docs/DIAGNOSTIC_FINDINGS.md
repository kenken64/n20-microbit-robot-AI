# Revision AR ERC investigation — source-backed findings

Source: user-uploaded `microbit_N20_revAQ.kicad_sch` and `erc_report_AR.txt`.

The schematic is readable as a text file. The prior ERC run reports 8 errors and 467 warnings. This package preserves the uploaded schematic unchanged because power-source and pin-mapping corrections require inspection of actual electrical nets and manufacturer symbol definitions; adding arbitrary PWR_FLAGs could conceal errors.

## Direct checks

- A `no_connect` object exists at (61.50, 97.92), corresponding to U1 FB2's reported ERC coordinate. KiCad still reports pin_not_connected and pin_not_driven. The no-connect needs inspection in the GUI, including the actual pin endpoint and any library symbol mismatch.
- A `no_connect` object exists at (105.50, 608.62), corresponding to J70 NC's reported coordinate. KiCad still reports pin_not_connected.
- A wire ends at (22.50, 273.65), U4 VCCA's reported coordinate. ERC reports power_pin_not_driven; verify the net's actual source and supply domains.
- A wire ends at (88.50, 113.16), U1 VIN_A's reported coordinate. ERC reports power_pin_not_driven; trace through battery switch, fuse, diode, and regulator input.
- A wire ends at (331.50, 411.27), D20 GND's reported coordinate. ERC reports power_pin_not_driven; check the power source/ground ERC model and other ground connections.
- J70 CTRL is not connected; verify the Pololu module's emitter control and harness pinout before assigning a net.
- J2 is the legacy output connector; verify its net and remove only after confirming no functional dependence.

## Warning classes

The ERC report includes many off-grid endpoints, absent `N20Power` and `Robot` symbol libraries, and unavailable footprints for TPS630701, DRV8833, inductor and SK6812 LEDs. Do not globally snap all wire endpoints without preserving connectivity.

## Recommended workflow

1. Open the schematic in KiCad and inspect pin 6 of U1 and pin 7 of J70; remove and re-place no-connect flags at their actual electrical pin tips, then rerun ERC.
2. Export a netlist; inspect U1 VIN_A and U4 VCCA for a genuine supply driver. Do not insert PWR_FLAG on a floating net.
3. Verify the TPS630701 manufacturer symbol and pinout, including FB2 fixed-output behavior, before approving any no-connect.
4. Verify J70 harness against the actual QTRX module and connect CTRL as appropriate.
5. Reconcile J2 with J6 and the micro:bit edge power connection before removing it.
6. Restore custom symbol libraries and resolve missing footprints, then address off-grid warnings.
7. Re-run ERC and review every residual violation. This design is not manufacturing ready.
