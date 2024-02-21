module bunker() translate([0, 0, 120]) rotate([0, 180, 0]) scale([2, 2, 2]) 
    import("/Users/Ben/Documents/Studium Architektur Bachelor/1. Semester/Darstellen und Gestalten/floating city concrete1 aussen.stl");

module z_rainbow (z) {
for (i= [0 : len(z)-1 ])
  color([cos(20*i)/2+0.5,
    -sin(20*i)/2+0.5,
    -cos(20*i)/2+0.5,
    1])
  translate([0, 0, z[i]]) cube([125, 110, z[i+1]-z[i]]);
}


z_layers = [0, 63, 190, 239];
//bunker();
//z_rainbow(z_layers);

/*difference(){
    translate([0, 0, -3])cube ([123, 123, 3+z_layers[1]-z_layers[0]]);
    bunker();
};
difference(){
    rotate([0, 0, 90])translate([0, 0, -3])cube ([123, 123, 3+z_layers[1]-z_layers[0]]);
    bunker();
};
difference(){
    rotate([0, 0, 180])translate([0, 0, -3])cube ([123, 123, 3+z_layers[1]-z_layers[0]]);
    bunker();
};
difference(){
    rotate([0, 0, 270])translate([0, 0, -3])cube ([123, 123, 3+z_layers[1]-z_layers[0]]);
    bunker();
};*/

/*difference(){
    translate([0, 0, z_layers[1]])cube ([123, 123, z_layers[2]-z_layers[1]]);
    bunker();
};*/
difference(){
    rotate([0, 0, 90])translate([0, 0, z_layers[1]])cube ([123, 123, z_layers[2]-z_layers[1]]);
    bunker();
};
/*difference(){
    rotate([0, 0, 180])translate([0, 0, z_layers[1]])cube ([123, 123, z_layers[2]-z_layers[1]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 270])translate([0, 0, z_layers[1]])cube ([123, 123, z_layers[2]-z_layers[1]]);
    bunker();
};*/

/*difference(){
    translate([0, 0, z_layers[2]]) cube([123, 123, z_layers[3]-z_layers[2]]);
    bunker();
};*/
difference(){
    rotate([0, 0, 90]) translate([0, 0, z_layers[2]]) cube([123, 123, z_layers[3]-z_layers[2]]);
    bunker();
};
/*rotate([0, 0, 90]) 
for (x=[5: 12: 110], y=[5: 12: 110], z=[z_layers[2]:7:z_layers[3]-10]) 
{
    translate([x,0,z]) cube([1, 120, 1]); 
    translate([0,y,z]) cube([120, 1, 1]); 
};*/
/*difference(){
    rotate([0, 0, 180]) translate([0, 0, z_layers[2]]) cube([123, 123, z_layers[3]-z_layers[2]]);
    bunker();
};*/
/*difference(){
    rotate([0, 0, 270]) translate([0, 0, z_layers[2]]) cube([123, 123, z_layers[3]-z_layers[2]]);
    bunker();
};*/
/*rotate([0, 0, 270]) 
for (x=[5: 12: 110], y=[5: 12: 110], z=[z_layers[2]:7:z_layers[3]-10]) 
{
    translate([x,0,z]) cube([1, 120, 1]); 
    translate([0,y,z]) cube([120, 1, 1]); 
};*/