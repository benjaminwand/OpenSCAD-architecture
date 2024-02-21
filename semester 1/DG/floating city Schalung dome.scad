module bunker() translate([0, 0, 120]) rotate([0, 180, 0]) scale([2, 2, 2]) 
    import("/Users/Ben/Documents/Studium Architektur Bachelor/1. Semester/Darstellen und Gestalten/floating city hall concrete1 innen.stl");

module z_rainbow (z) {
for (i= [0 : len(z)-1 ])
  color([cos(20*i)/2+0.5,
    -sin(20*i)/2+0.5,
    -cos(20*i)/2+0.5,
    1])
  translate([0, 0, z[i]]) cube([125, 110, z[i+1]-z[i]]);
}

module sonne (r, h, a)      // radius, höhe, Abstand
    for (z = [0:a:(h-1)], n=[0:20:90]) translate([0, 0, z]) rotate([0, 0, n]) cube([r, 1, 1]);
 
z_layers = [0, 5, 35.9, 75, 120, 145, 190, 228.5];
//bunker();
//z_rainbow(z_layers);


/*difference(){
    translate([0, 0, -3])cube ([122, 122, 3+z_layers[1]-z_layers[0]]);
    bunker();
};
difference(){
    rotate([0, 0, 90])translate([0, 0, -3])cube ([122, 122, 3+z_layers[1]-z_layers[0]]);
    bunker();
};*/

/*difference(){
    rotate([0, 0, 180])translate([0, 0, -3])cube ([122, 122, 3+z_layers[1]-z_layers[0]]);
    bunker();
};
difference(){
    rotate([0, 0, 270])translate([0, 0, -3])cube ([122, 122, 3+z_layers[1]-z_layers[0]]);
    bunker();
};*/

/*
difference(){
    translate([0, 0, z_layers[1]])cube ([122, 122, z_layers[2]-z_layers[1]]);
    bunker();
}; 
translate([0, 0, z_layers[1]]) sonne(80, z_layers[2]-z_layers[1], 12);
difference(){
    rotate([0, 0, 90])translate([0, 0, z_layers[1]])cube ([122, 122, z_layers[2]-z_layers[1]]);
    bunker();
};
rotate([0, 0, 90]) 
translate([0, 0, z_layers[1]]) sonne(80, z_layers[2]-z_layers[1], 12);
*/
/*
difference(){
    rotate([0, 0, 180])translate([0, 0, z_layers[1]])cube ([122, 122, z_layers[2]-z_layers[1]]);
    bunker();
};
rotate([0, 0, 180]) 
translate([0, 0, z_layers[1]]) sonne(80, z_layers[2]-z_layers[1], 12);
difference(){
    rotate([0, 0, 270])translate([0, 0, z_layers[1]])cube ([122, 122, z_layers[2]-z_layers[1]]);
    bunker();
};
rotate([0, 0, 270]) 
translate([0, 0, z_layers[1]]) sonne(80, z_layers[2]-z_layers[1], 12);
*/

/*difference(){
    translate([0, 0, z_layers[2]]) cube([122, 122, z_layers[3]-z_layers[2]]);
    bunker();
};
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[2]]) cube([122, 122, z_layers[3]-z_layers[2]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[2]]) cube([122, 122, z_layers[3]-z_layers[2]]);
    bunker();
};
difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[2]]) cube([122, 122, z_layers[3]-z_layers[2]]);
    bunker();
};
*/

/*difference(){
    translate([0, 0, z_layers[3]]) cube([122, 122, z_layers[4]-z_layers[3]]);
    bunker();
};
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[3]]) cube([122, 122, z_layers[4]-z_layers[3]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[3]]) cube([122, 122, z_layers[4]-z_layers[3]]);
    bunker();
};
difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[3]]) cube([122, 122, z_layers[4]-z_layers[3]]);
    bunker();
};
*/

/*difference(){
    translate([0, 0, z_layers[4]]) cube([122, 122, z_layers[5]-z_layers[4]]);
    bunker();
};
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[4]]) cube([122, 122, z_layers[5]-z_layers[4]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[4]]) cube([122, 122, z_layers[5]-z_layers[4]]);
    bunker();
};
difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[4]]) cube([122, 122, z_layers[5]-z_layers[4]]);
    bunker();
};
*/

/*difference(){
    translate([0, 0, z_layers[5]]) cube([122, 122, z_layers[6]-z_layers[5]]);
    bunker();
};
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[5]]) cube([122, 122, z_layers[6]-z_layers[5]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[5]]) cube([122, 122, z_layers[6]-z_layers[5]]);
    bunker();
};
difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[5]]) cube([122, 122, z_layers[6]-z_layers[5]]);
    bunker();
};
*/

/*difference(){
    translate([0, 0, z_layers[6]]) cube([122, 122, z_layers[7]-z_layers[6]]);
    bunker();
};
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[6]]) cube([122, 122, z_layers[7]-z_layers[6]]);
    bunker();
};*/
difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[6]]) cube([122, 122, z_layers[7]-z_layers[6]]);
    bunker();
};
difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[6]]) cube([122, 122, z_layers[7]-z_layers[6]]);
    bunker();
};