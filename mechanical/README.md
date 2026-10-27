# Revision AW - reconstructed mechanical correction prototype

This is newly reconstructed CAD, not the original Revision U. Print PETG at 0.2 mm layers, 4 walls, ~30% infill. Use slicer to inspect all parts.

## Corrected design intent
- Wheel center height 16 mm above ground with 32 mm wheel, giving ground contact z=0 and chassis underside z=6 (6 mm clearance).
- Both motor cavities run along X, with shaft exit holes through X end walls. Confirm the actual Pololu motor and shaft lengths; printed saddle top is open.
- PCB underside z=34; battery cradle top z=25, estimated battery holder top z=29, motor saddle top z=24. This is nominal clearance, not validated against wiring and real parts.
- Battery cradle outer x +/-33 avoids motor saddles inner x +/-34. Motor mount screws y +/-8 may be difficult to access once motors are fitted.
- Ultrasonic upright is at y=-64, forward of PCB front y=-51.5; bolt holes align at x +/-20, y=-49.
- Caster bridge front edge y=32, battery rear edge y=31: nominal 1 mm gap. Caster ball ground contact is NOT validated; adjust shim and bridge height after measuring actual caster assembly.
- PCB hole spacing 74 x 91 mm; four M3 holes, 86 x 103 mm PCB. Check that 24 mm tall PCB supports and wiring are adequately rigid.

## Important limitations
- No physical measurements or real-assembly scan. Caster geometry, battery dimensions, motor shaft protrusion, ultrasonic mounting and all fastener access require test fits.
- The PCB may have components on its underside; these require their own keepout volumes and clearance checks.
- Do not use these STLs as evidence that the robot or PCB is production-ready.
- Use the same mechanical reference CSV and SCAD source for any subsequent KiCad mechanical update.

## Suggested test-print sequence
1. Print one saddle and fit one actual N20 motor and wheel; measure wheel radius and axle-to-ground.
2. Print chassis and test-fit two saddles and battery cradle with screws; verify no collisions.
3. Print caster bridge and shim set, measure ground contact with actual Pololu #951 caster.
4. Print ultrasonic holder and check board mounting and front access.
5. Print PCB template and confirm standoff positions before ordering the real PCB.

Export STL from OpenSCAD by selecting part in `robot_revAW.scad`; the zip includes the pre-exported STLs.
