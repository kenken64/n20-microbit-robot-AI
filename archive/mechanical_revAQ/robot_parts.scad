// Reconstructed N20 micro:bit robot, FDM PETG prototype. Units mm.
// NOT recovered original Rev U geometry. Verify all physical components before use.
part = "chassis"; // chassis, motor_saddle, battery_cradle, ultrasonic_holder, caster_bridge, shim_05, shim_10, shim_20, pcb_spacer, pcb_template
$fn=48;
plate=4; body_x=118; body_y=114; pcb_dx=74; pcb_dy=91;
module hole(d,h=30){cylinder(d=d,h=h,center=true);}
module rounded_plate(x,y,z,r=8){hull() for(a=[-1,1],b=[-1,1]) translate([a*(x/2-r),b*(y/2-r),0]) cylinder(r=r,h=z,center=true);}
module chassis(){difference(){union(){translate([0,0,plate/2])rounded_plate(body_x,body_y,plate,9);
// raised motor platform ribs, left/right; motor axis to be checked at assembly
for(s=[-1,1]) translate([s*43,0,7]) cube([12,38,10],center=true);
// PCB pillars 4x M3, top of plate + 9 mm
for(x=[-37,37],y=[-45.5,45.5]) translate([x,y,4]) cylinder(d=9,h=9);
}
for(x=[-37,37],y=[-45.5,45.5]) translate([x,y,6])hole(3.3,30);
// saddle mounting through holes (M3)
for(x=[-43,43],y=[-12,12]) translate([x,y,6])hole(3.3,30);
// battery cradle mounting holes M2.3, central pattern 48 x 44
for(x=[-24,24],y=[-22,22]) translate([x,y,3])hole(2.4,20);
// rear caster bridge M2.3 pattern 28 x 16; rear positive Y
for(x=[-14,14],y=[35,51]) translate([x,y,3])hole(2.4,20);
// caster ball clearance through rear base
translate([0,43,3])hole(18,20);
// front ultrasonic mounting, M2.3 through chassis
for(x=[-20,20])translate([x,-49,3])hole(2.4,20);
}}
module motor_saddle(){difference(){union(){cube([17,34,5],center=true);translate([0,0,6])difference(){cube([17,34,12],center=true);translate([0,0,2])cube([12.5,26,13],center=true);}}for(y=[-12,12])translate([0,y,-1])hole(3.3,20);}}
module battery_cradle(){difference(){union(){translate([0,0,2])cube([72,70,4],center=true);for(x=[-35,35])translate([x,0,10])cube([3,64,16],center=true);for(y=[-34,34])translate([0,y,8])cube([72,3,12],center=true);}for(x=[-24,24],y=[-22,22])translate([x,y,2])hole(2.4,15); // battery strap slots
for(x=[-18,18])translate([x,0,2])cube([5,16,12],center=true);}}
module ultrasonic_holder(){difference(){union(){translate([0,0,2])cube([62,18,4],center=true);translate([0,7,16])cube([62,4,28],center=true);}for(x=[-20,20])translate([x,-3,2])hole(2.4,15); // adjustable sensor slots for 3.3V ultrasonic module
for(x=[-21,21])translate([x,7,19])rotate([90,0,0])cylinder(d=3.2,h=15,center=true);}}
module caster_bridge(){difference(){union(){translate([0,0,2.5])cube([44,32,5],center=true);translate([0,0,6])cube([26,24,3],center=true);}translate([0,0,5])hole(18,25);for(x=[-14,14],y=[-8,8])translate([x,y,3])hole(2.4,15); // candidate caster mounting pair
for(x=[-6.75,6.75])translate([x,0,5])hole(2.4,20);}}
module shim(t){difference(){translate([0,0,t/2])cube([26,22,t],center=true);translate([0,0,t/2])hole(18,10);for(x=[-6.75,6.75])translate([x,0,t/2])hole(2.4,10);}}
module pcb_spacer(){difference(){cylinder(d=7,h=9);translate([0,0,4.5])hole(3.3,20);}}
module pcb_template(){difference(){translate([0,0,1])cube([86,103,2],center=true);for(x=[-37,37],y=[-45.5,45.5])translate([x,y,1])hole(3.3,10);}}
if(part=="chassis")chassis();
else if(part=="motor_saddle")motor_saddle();
else if(part=="battery_cradle")battery_cradle();
else if(part=="ultrasonic_holder")ultrasonic_holder();
else if(part=="caster_bridge")caster_bridge();
else if(part=="shim_05")shim(0.5);
else if(part=="shim_10")shim(1);
else if(part=="shim_20")shim(2);
else if(part=="pcb_spacer")pcb_spacer();
else if(part=="pcb_template")pcb_template();
