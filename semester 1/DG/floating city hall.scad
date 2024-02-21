// 1 cm = 1 meter

//$fn = 60;

 
difference(){
    cube([120, 120, 120], true);                                // Quader
    translate([0, 0, 25]) cube([115, 115, 110], true);            
    for (i=[0:90:270]) rotate([0, 0, i]) translate([0, 0, 5])   // Dreiecke ausschneiden
        linear_extrude(120, center=true) polygon([[57.5, 27],[57.5, 57.5],[27, 57.5]]);
    tueren();                                                   // Türen
    //rotate([0, 0, 45])
    //translate([0, -60,0]) color("blue") cube([150, 120, 150], true);
};


difference(){
    union(){
        kuppel(120);                                               // Kupel
        oberlicht(offs = 5);
    rotate([0, 0, 22.5]) cylinder(60, 21, 21, center=false, $fn=8);
    };
    translate([0, 0, 5])oberlicht(offs = 0);
    kuppel(115); 
    rotate([0, 0, 22.5]) cylinder(120, 18, 18, center=false, $fn=8);    // Dachluke
    tueren();                                                   // Türen
    //rotate([0, 0, 45])
    //translate([0, -60,0]) color("blue") cube([150, 120, 150], true);
}


module tueren()
for (i=[0:90:270]) rotate([0, 0, i]) {
    translate([0, 60, 20]) cube([20, 30, 20], true);
    translate([0, 60, 30]) rotate([90, 0, 0]) cylinder(50, 10, 10, true);
};
  
module kuppel(w)
intersection_for(n = [1 : 8]){
    rotate([0, 0, n * 45])
    hull() {
        intersection(){
            translate([w/2, 0, 0])scale([1, 1, 0.65])rotate([90, 0, 0]) cylinder(w, w, w, true);
            translate([0, 0, w*0.25])cube([2*w, 2*w, w*0.75], true);
        };
        translate([0, 0, -w/4])cube([w, w, 0.1], true);
    }
}

module oberlicht(offs = 0)
for (i=[0:90:270]) rotate([0, 0, i]) translate([0, 0, 15])
    hull() linear_extrude(90, center=true) {
        translate([50, 0])resize([15 + offs, 20 + offs])circle(10); 
        translate([55, 0])square([5, 20 + offs], true);
    }

