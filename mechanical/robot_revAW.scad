// Rev AW reconstructed N20 robot - mechanical correction prototype, millimeters.
// Z=0 ground. X=left/right, Y negative=front. PETG FDM. Verify actual hardware.
part="assembly"; $fn=48;
body_x=118; body_y=114; plate_bottom=6; plate_t=4;
pcb_x=86; pcb_y=103; pcb_z=34; pcb_t=1.6;
axle_z=16; wheel_d=32; wheel_w=7;
// Motor cavity: 26 mm long along X, 12.5 mm across Y, clearance for N20 envelope.
module hole(d,h=50){cylinder(d=d,h=h,center=true);}
module rounded(x,y,z,r=9){hull()for(a=[-1,1],b=[-1,1])translate([a*(x/2-r),b*(y/2-r),0])cylinder(r=r,h=z,center=true);}
module chassis(){difference(){union(){translate([0,0,plate_bottom+plate_t/2])rounded(body_x,body_y,plate_t);
// Standoffs support PCB at 34mm; screws through M3.
for(x=[-37,37],y=[-45.5,45.5])translate([x,y,10])cylinder(d=9,h=pcb_z-10);
// Motor mounting ribs stop below the elevated PCB
for(s=[-1,1])translate([s*49,0,12])cube([28,19,4],center=true);
}for(x=[-37,37],y=[-45.5,45.5])translate([x,y,20])hole(3.3,55);
// Battery mounting pattern - shared single source with cradle
for(x=[-24,24],y=[-22,22])translate([x,y,8])hole(2.5,20);
// Motor saddle bolts, y= +/- 8, x +/- 49 (outside pocket)
for(x=[-49,49],y=[-8,8])translate([x,y,10])hole(3.3,30);
// Caster bridge rear mounting, keep clear of battery wall (battery ends y=31)
for(x=[-14,14],y=[39,53])translate([x,y,8])hole(2.5,25);
translate([0,46,8])hole(19,30);
// Ultrasonic bracket bolts on front edge, Y=-49
for(x=[-20,20])translate([x,-49,8])hole(2.5,25);
}}
// Motor saddle centered at +/-49. Cavity along X, motor shaft outward.
// Saddle z base=10, cavity center z=17; shaft opening outward side.
module motor_saddle(){difference(){union(){translate([0,0,2])cube([30,19,4],center=true);translate([0,0,9])cube([30,17,10],center=true);}
translate([0,0,10])cube([26.5,12.8,12],center=true);
// Through-shaft opening on both ends (either handed)
translate([0,0,6])rotate([0,90,0])hole(5,40);
for(y=[-8,8])translate([0,y,3])hole(3.3,20);
// open top for inserting motor and strap
translate([0,0,15])cube([26.5,12.8,12],center=true);
}}
// Cradle x +/-33, y +/-31. Mounted at plate top (z=10); 4-AA holder nominal 16mm high.
module battery_cradle(){difference(){union(){cube([66,62,3],center=false);for(x=[0,63])translate([x,0,3])cube([3,62,12]);for(y=[0,59])translate([0,y,3])cube([66,3,8]);}
for(x=[9,57],y=[9,53])translate([x,y,1.5])hole(2.5,12);
for(x=[22,44])translate([x,31,1.5])cube([5,15,10],center=true);
}}
// Front-facing ultrasonic upright stays forward of PCB front edge (-51.5).
// Place module origin at (0,-59,10), upright at local y=-8 => global -67.
module ultrasonic_holder(){difference(){union(){translate([0,0,2])cube([62,20,4],center=true);translate([0,-8,15])cube([62,4,26],center=true);}
for(x=[-20,20])translate([x,7,2])hole(2.5,14);
for(x=[-21,21])translate([x,-8,20])rotate([90,0,0])hole(3.2,16);
}}
// Rear bridge centered y=46. Mounting holes y +/-7 (global 39,53).
// Caster #951 fastener pitch nominal 13.5mm; ball recess is provisional.
module caster_bridge(){difference(){union(){translate([0,0,2.5])cube([42,28,5],center=true);translate([0,0,6])cube([26,22,2],center=true);}
translate([0,0,4])hole(19,25);
for(x=[-14,14],y=[-7,7])translate([x,y,3])hole(2.5,20);
for(x=[-6.75,6.75])translate([x,0,3])hole(2.5,20);
}}
module shim(t){difference(){translate([0,0,t/2])cube([26,22,t],center=true);translate([0,0,t/2])hole(19,12);for(x=[-6.75,6.75])translate([x,0,t/2])hole(2.5,12);}}
module pcb_spacer(){difference(){cylinder(d=9,h=24);translate([0,0,12])hole(3.3,35);}}
module pcb_template(){difference(){translate([0,0,1])cube([86,103,2],center=true);for(x=[-37,37],y=[-45.5,45.5])translate([x,y,1])hole(3.3,10);}}
module wheel_preview(){rotate([0,90,0])cylinder(d=wheel_d,h=wheel_w,center=true);}
module assembly(){color("silver")chassis();
for(s=[-1,1]){color("orange")translate([s*49,0,10])motor_saddle();color("#333333")translate([s*74,0,axle_z])wheel_preview();}
color("#4682b4")translate([-33,-31,10])battery_cradle();
color("#e4ba50")translate([0,-56,10])ultrasonic_holder();
color("#ca7152")translate([0,46,10])caster_bridge();
color([0,0.5,0.2,0.35])translate([0,0,pcb_z+pcb_t/2])cube([pcb_x,pcb_y,pcb_t],center=true);
}
if(part=="chassis")chassis();else if(part=="motor_saddle")motor_saddle();else if(part=="battery_cradle")battery_cradle();else if(part=="ultrasonic_holder")ultrasonic_holder();else if(part=="caster_bridge")caster_bridge();else if(part=="shim_05")shim(0.5);else if(part=="shim_10")shim(1);else if(part=="shim_20")shim(2);else if(part=="pcb_spacer")pcb_spacer();else if(part=="pcb_template")pcb_template();else assembly();
