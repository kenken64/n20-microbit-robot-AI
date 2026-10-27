# N20 micro:bit robot

A two-wheel robot built around a micro:bit V2 in a vertical 80-way socket, two N20 gear motors, a 4 × AA pack, an ultrasonic sensor and a QTRX line sensor. This repository holds the KiCad schematic, a mechanical-only PCB skeleton, the 3D-printed chassis parts, and the validation evidence collected so far.

| Area | Current revision | Where |
| --- | --- | --- |
| Schematic | Rev AU (no electrical changes since) | `microbit_N20_revAQ.kicad_sch` |
| PCB | Rev AV mechanical skeleton: outline and M3 holes only | `pcb_planning/N20_RevAV_MECHANICAL_ONLY.kicad_pcb` |
| Printed parts | Rev AW mechanical correction | `mechanical/` |

> **Status: HOLD — do not order boards from JLCPCB.** The schematic still has 7 ERC errors and 377 warnings, the PCB has no footprints or routing, and the Rev AW printed parts haven't been test-fitted. See [`docs/RELEASE_STATUS.md`](docs/RELEASE_STATUS.md) and [`docs/VALIDATION_REPORT_AV.md`](docs/VALIDATION_REPORT_AV.md) for every blocker.

## 3D assembly viewer

**<https://claude.ai/artifact/J2JEAmkfgA7Dof7irhxfJg>**

An interactive model of the robot with an explode slider, an eight-step assembly sequence, a parts list and a fit check that highlights where parts collide. It shows the **Rev AQ** printed parts from [`archive/mechanical_revAQ/stl/`](archive/mechanical_revAQ/stl/). Rev AW was designed to fix the clashes its fit check lists, and isn't in the viewer yet. The motors, wheels, caster, battery holder, sensor and micro:bit are generic parts at catalogue sizes. The link is private to its owner until it's shared from the page's Share menu.

## Repository layout

| Path | Contents |
| --- | --- |
| `microbit_N20_revAQ.kicad_pro` / `.kicad_sch` / `.kicad_prl` | KiCad 10 project. The schematic keeps its Rev AQ file name but holds the Rev AU content. |
| `N20Power.kicad_sym`, `Robot.kicad_sym`, `sym-lib-table` | Project-local symbol libraries, loaded through `${KIPRJMOD}` |
| [`README_FIRST.md`](README_FIRST.md) | Rev AV note on the mechanical-only PCB skeleton |
| [`mechanical/`](mechanical/) | Rev AW chassis: `robot_revAW.scad`, its STLs in `stl/`, `MECHANICAL_REFERENCES.csv`, and design notes in `README.md` |
| [`pcb_planning/`](pcb_planning/) | Rev AV PCB skeleton, placement candidates and routing plan |
| [`docs/`](docs/) | Release status, JLCPCB checklist, validation reports, ERC categories, revision notes, issue tracker |
| [`scripts/`](scripts/) | macOS scripts that run KiCad's command-line ERC, netlist and DRC |
| [`reports/`](reports/) | ERC reports, console logs and netlists from each run |
| [`archive/`](archive/) | Superseded files: the Rev AQ mechanical reconstruction and its Rev AT references (`mechanical_revAQ/`), and `microbit_N20_revAU.kicad_sch`, a byte-identical copy of the working schematic |

## Running the checks

The scripts need KiCad 10 (the reports were produced with 10.0.7). They find `kicad-cli` on your `PATH` or in `/Applications/KiCad`, and they can be run from any directory.

| Command | What it writes |
| --- | --- |
| `bash scripts/run_erc_mac.sh` | ERC and netlist for the current schematic: `reports/erc_report_AU.txt`, `erc_console_AU.txt`, `schematic_netlist_AU.net` |
| `bash scripts/RELEASE_GATE_MAC.sh` | ERC on the schematic and DRC on the Rev AV skeleton: `reports/RevAV_ERC.txt`, `RevAV_DRC.txt`. Always exits 1, so the skeleton can never pass as a release. |
| `bash scripts/run_release_gate_mac.sh` | `reports/validation/`. Exits 1 if ERC or the netlist fails, 2 if `robot_final.kicad_pcb` is missing, 3 if DRC fails. It never exports Gerbers. |
| `bash scripts/run_diagnostic_mac.sh` | `reports/erc_report_recheck.txt`, `erc_console_recheck.txt`, `schematic_netlist.net` |
| `bash scripts/run_erc_diagnostic_mac.sh` | `reports/erc_report.txt`, `erc_console.txt`, `erc_help.txt` |

## Electrical status

ERC on the Rev AU schematic reports 7 errors:

| Pin | ERC error | What has to be confirmed |
| --- | --- | --- |
| U4 pin 1 VCCA | Power pin not driven | `MB_EDGE_3V` comes from the micro:bit. Confirm the source and the USB-only, battery-only and off states. |
| U1 pin 6 FB2 | Pin not connected | TI's datasheet allows FB2 open on the fixed-output part. KiCad still doesn't recognise the no-connect marker. |
| U1 pin 12 VIN_A | Power pin not driven | `VMOTOR` needs its fuse, switch and reverse-polarity path confirmed before any power flag is added. |
| J70 pin 6 CTRL | Pin not connected | Check the Pololu QTRX-MD-03A emitter-control pin and connector pad order. |
| J70 pin 7 NC | Pin not connected | Check the harness pin map and the no-connect placement. |
| J2 pin 1 MB_3V | Pin not connected | J2 is obsolete (DNP, excluded from BOM and PCB). Remove it once both of its nets are checked. |
| D20 pin 3 GND | Power pin not driven | Confirm how the ground source should be declared. |

The 377 warnings are 367 off-grid endpoints, 7 footprint link issues and 3 isolated labels; [`docs/ERC_CATEGORIES.csv`](docs/ERC_CATEGORIES.csv) sets the policy for each. TPS630701 pin 14 is EN, not VIN, so check the netlist before releasing anything that ties it to the supply. Footprints still need manufacturer land patterns for the TPS630701 (RNM), DRV8833 (PWP), Coilcraft XFL4020, four SK6812MINI-E LEDs and the 4UCON 17809 socket.

## Mechanical status (Rev AW)

Rev AW is a new reconstruction, not the original Rev U CAD. Its coordinates put **Z = 0 at the ground** and negative Y at the front; Rev AQ measured Z from the chassis underside instead. The KiCad board centre (100, 100) is chassis (0, 0).

| Feature | Rev AW design value |
| --- | --- |
| Wheels | 32 mm, axle 16 mm above the ground, centres at X ±74 |
| Chassis underside | 6 mm above the ground |
| Motor cavities | Along X with shaft holes in both end walls; saddles centred at X ±49 |
| PCB | Underside at 34 mm on four 24 mm spacers |
| Battery cradle | Outer X ±33 (saddles start at ±34), top at 25 mm; holder top about 29 mm |
| Ultrasonic upright | Y −64, forward of the PCB's front edge at Y −51.5 |
| Caster bridge | Front edge Y 32, 1 mm behind the battery cradle |

These are nominal values from [`mechanical/README.md`](mechanical/README.md), which also lists the test-print sequence. Nothing has been test-fitted with real motors, wheels, caster or battery holder. Print in PETG at 0.2 mm layers with 4 walls and about 30% infill. To re-export a part after editing the `.scad`:

```sh
openscad -o mechanical/stl/chassis.stl -D 'part="chassis"' mechanical/robot_revAW.scad
```

## Revision history

| Rev | Change | Record |
| --- | --- | --- |
| AW | Mechanical correction: motor cavities along X with shaft exits, axle at 16 mm for 32 mm wheels, PCB raised to 34 mm, cradle narrowed, ultrasonic upright moved forward, caster bridge moved clear of the cradle. | [`mechanical/README.md`](mechanical/README.md) |
| AV | Mechanical-only KiCad PCB skeleton (86 × 103 mm, four M3 holes at 74 × 91 mm), ERC category audit and a release gate that always fails. No electrical changes. | [`README_FIRST.md`](README_FIRST.md), [`docs/VALIDATION_REPORT_AV.md`](docs/VALIDATION_REPORT_AV.md) |
| AU | FB2 pin type changed from input to output, per TI SLVSC58B. ERC: 7 errors, 377 warnings. | [`docs/VALIDATION_REPORT_AU.md`](docs/VALIDATION_REPORT_AU.md), [`docs/ISSUE_TRACKER.csv`](docs/ISSUE_TRACKER.csv) |
| AT | Release control: fail-closed release gate script, placement and routing plans. | [`docs/REV_AT_README_FIRST.md`](docs/REV_AT_README_FIRST.md), [`docs/RELEASE_STATUS.md`](docs/RELEASE_STATUS.md) |
| AS | Project-local symbol libraries rebuilt from the schematic's embedded cache; J2 marked DNP. ERC: 8 errors, 377 warnings. | [`docs/REV_AS_README.md`](docs/REV_AS_README.md) |
| AR | U1 VOUT_B pin type changed to passive; no-connects added at U1 FB2 and J70 NC. ERC: 8 errors, 467 warnings. | [`docs/REV_AR_CHANGELOG.md`](docs/REV_AR_CHANGELOG.md), [`docs/DIAGNOSTIC_FINDINGS.md`](docs/DIAGNOSTIC_FINDINGS.md) |
| AQ | Load repairs: UUIDs added to three text objects; nFAULT pin type changed from `open_drain` to `open_collector`. ERC: 9 errors, 467 warnings. | [`docs/REPAIR_NOTES.txt`](docs/REPAIR_NOTES.txt), [`docs/FIX_NOTES.txt`](docs/FIX_NOTES.txt) |

Release gates before any board order are listed in [`docs/JLCPCB_RELEASE_CHECKLIST.md`](docs/JLCPCB_RELEASE_CHECKLIST.md).
