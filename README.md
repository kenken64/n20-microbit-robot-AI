# N20 micro:bit robot — Rev AQ (reissued 2026-10-27)

A two-wheel robot built around a micro:bit V2 in a vertical 80-way socket, two N20 gear motors, a 4 × AA pack, an ultrasonic sensor and a QTRX line sensor. This repository holds the KiCad schematic, the 3D-printed chassis parts, and the validation evidence collected so far.

> **Status: HOLD — do not order boards from JLCPCB.** The schematic still has 7 ERC errors and 377 warnings (Rev AU, 2026-10-28). No routed PCB exists, and the printed parts don't fit together yet. See [`docs/RELEASE_STATUS.md`](docs/RELEASE_STATUS.md) for every blocker.

## 3D assembly viewer

**<https://claude.ai/artifact/J2JEAmkfgA7Dof7irhxfJg>**

An interactive model of the robot built from the STL files in [`mechanical/stl/`](mechanical/stl/). It has an explode slider, an eight-step assembly sequence, a parts list and a fit check that highlights where parts collide. The motors, wheels, caster, battery holder, sensor and micro:bit are generic parts at catalogue sizes, and the PCB is shown as its 86 × 103 mm envelope only. The link is private to its owner until it's shared from the page's Share menu.

## Repository layout

| Path | Contents |
| --- | --- |
| `microbit_N20_revAQ.kicad_pro` / `.kicad_sch` / `.kicad_prl` | KiCad 10 project. The schematic keeps its Rev AQ file name but holds the Rev AU content. |
| `N20Power.kicad_sym`, `Robot.kicad_sym`, `sym-lib-table` | Project-local symbol libraries, loaded through `${KIPRJMOD}` |
| [`README_FIRST.md`](README_FIRST.md) | Rev AT release-control note |
| [`docs/`](docs/) | Release status, JLCPCB checklist, validation report, revision notes, issue tracker |
| [`pcb_planning/`](pcb_planning/) | Placement candidates, routing plan, chassis-to-KiCad coordinate references |
| [`mechanical/`](mechanical/) | `robot_parts.scad`, print notes, and the exported STLs in `stl/` |
| [`scripts/`](scripts/) | macOS scripts that run KiCad's command-line ERC, netlist and DRC |
| [`reports/`](reports/) | ERC reports, console logs and netlists from each run |
| [`archive/`](archive/) | `microbit_N20_revAU.kicad_sch`, a byte-identical copy of the working schematic |

## Running the checks

The scripts need KiCad 10 (the reports were produced with 10.0.7). They find `kicad-cli` on your `PATH` or in `/Applications/KiCad`, and they can be run from any directory.

| Command | What it writes |
| --- | --- |
| `bash scripts/run_erc_mac.sh` | ERC and netlist for the current revision: `reports/erc_report_AU.txt`, `erc_console_AU.txt`, `schematic_netlist_AU.net` |
| `bash scripts/run_release_gate_mac.sh` | `reports/validation/`. Exits 1 if ERC or the netlist fails, 2 if `robot_final.kicad_pcb` is missing, 3 if DRC fails. It never exports Gerbers. |
| `bash scripts/run_diagnostic_mac.sh` | `reports/erc_report_recheck.txt`, `erc_console_recheck.txt`, `schematic_netlist.net` |
| `bash scripts/run_erc_diagnostic_mac.sh` | `reports/erc_report.txt`, `erc_console.txt`, `erc_help.txt` |

Each script also records the KiCad version in `reports/kicad_version.txt`.

## Electrical status

ERC on the Rev AU schematic reports 7 errors:

| Pin | ERC error | What has to be confirmed |
| --- | --- | --- |
| U4 pin 1 VCCA | Power pin not driven | `MB_EDGE_3V` comes from the micro:bit. Confirm the source and the power-off behaviour before declaring it. |
| U1 pin 6 FB2 | Pin not connected | TI's datasheet allows FB2 open on the fixed-output part. Re-place the no-connect marker on the pin tip. |
| U1 pin 12 VIN_A | Power pin not driven | `VMOTOR` needs its fuse, switch and reverse-polarity path confirmed before any power flag is added. |
| J70 pin 6 CTRL | Pin not connected | Check the Pololu QTRX emitter-control pin and the intended mode. |
| J70 pin 7 NC | Pin not connected | Check the harness pin map and the no-connect placement. |
| J2 pin 1 MB_3V | Pin not connected | J2 is obsolete (DNP, excluded from BOM and PCB). Remove it once both of its nets are checked. |
| D20 pin 3 GND | Power pin not driven | Confirm how the ground source should be declared. |

The 377 warnings are mostly off-grid wire and pin endpoints, plus missing footprints for the TPS630701, DRV8833, the Coilcraft inductor and four SK6812 LEDs. [`docs/VALIDATION_REPORT.md`](docs/VALIDATION_REPORT.md) also flags TPS630701 pin 14 as EN, not VIN. Check the netlist before releasing anything that ties it to the supply.

## Mechanical status

The printed parts are a reconstruction, not the original Rev U CAD. Print settings and quantities are in [`mechanical/README_PRINT_FIRST.txt`](mechanical/README_PRINT_FIRST.txt). To re-export a part after editing the `.scad`:

```sh
openscad -o mechanical/stl/chassis.stl -D 'part="chassis"' mechanical/robot_parts.scad
```

Placing the STLs by their shared screw holes shows these problems. Each one can be inspected in the 3D viewer's fit check.

1. **The motor saddles pass through the PCB.** They rise to 26.5 mm, and the PCB sits at 22–23.6 mm with its edges at X ±43, over the middle of both saddles.
2. **The ultrasonic holder passes through the PCB.** Its upright reaches 34 mm inside the front 10 mm of the board.
3. **The wheels can't reach the floor.** The axle is 22 mm above the chassis underside, and a 32 mm wheel only reaches down to 6 mm above it.
4. **The saddle pocket runs front to back.** It holds an N20 with its shaft pointing forward, not out towards the wheels.
5. **The saddles overlap the battery cradle's side walls** by 2 mm.
6. **The caster bridge's front screw holes** (Y 35) sit under the cradle's rear wall.
7. **The PCB has no clearance above the battery cradle.** It rests on the cradle walls at 22 mm, and a 15 mm battery holder reaches about 23 mm.
8. **`pcb_planning/MECHANICAL_REFERENCES.csv` doesn't match `robot_parts.scad`** for the cradle, saddle, ultrasonic and caster positions. The CSV's saddle centres at X ±52 would clear the PCB.

Coordinates use the `.scad` frame: X across, Y towards the rear, Z up from the chassis underside. KiCad coordinates are chassis X + 100 and chassis Y + 100.

## Revision history

| Rev | Change | Record |
| --- | --- | --- |
| AU | FB2 pin type changed from input to output, per TI SLVSC58B. ERC: 7 errors, 377 warnings. | [`docs/VALIDATION_REPORT.md`](docs/VALIDATION_REPORT.md), [`docs/ISSUE_TRACKER.csv`](docs/ISSUE_TRACKER.csv) |
| AT | Release control: fail-closed release gate script, placement and routing plans. | [`README_FIRST.md`](README_FIRST.md), [`docs/RELEASE_STATUS.md`](docs/RELEASE_STATUS.md) |
| AS | Project-local symbol libraries rebuilt from the schematic's embedded cache; J2 marked DNP. ERC: 8 errors, 377 warnings. | [`docs/REV_AS_README.md`](docs/REV_AS_README.md) |
| AR | U1 VOUT_B pin type changed to passive; no-connects added at U1 FB2 and J70 NC. ERC: 8 errors, 467 warnings. | [`docs/REV_AR_CHANGELOG.md`](docs/REV_AR_CHANGELOG.md), [`docs/DIAGNOSTIC_FINDINGS.md`](docs/DIAGNOSTIC_FINDINGS.md) |
| AQ | Load repairs: UUIDs added to three text objects; nFAULT pin type changed from `open_drain` to `open_collector`. ERC: 9 errors, 467 warnings. | [`docs/REPAIR_NOTES.txt`](docs/REPAIR_NOTES.txt), [`docs/FIX_NOTES.txt`](docs/FIX_NOTES.txt) |

Release gates before any board order are listed in [`docs/JLCPCB_RELEASE_CHECKLIST.md`](docs/JLCPCB_RELEASE_CHECKLIST.md).
