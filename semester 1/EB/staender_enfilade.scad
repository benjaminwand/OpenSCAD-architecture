// Todo
/*
* Stangen an Ränder
* Proportionen und Winkel korrigieren
* passt das enfilade überhaupt auf den 3d drucker?
*/


// Darstellungsoptionen
stellen = 0;            // Platten. else: Stangen
staenderwerk = 1;       // ständer 3d version. else: diff mit Box
ghost = 0;
A4 = 0;
aussenstreifen = 1;


// Maße
scale = 1/50;

l = 3000;       // Raumlänge
b = 2500;       // Raumbreite
h = 3000;       // Raumhöhe

tb = 1000;      // Türbreite
fb = 500;       // Fensterbreite

wstrk = stellen ? 3/scale : 1.65/scale;    // Wandstärke
wx = 45;         // Winkel
wy = 35;
wx_2 = 55;


// Skizzen
if (ghost) %scale(scale) ghost();              // innenraum
if (A4) %square([200,200*sqrt(2)], true);   // Din A4 Referenz
//rotate([0,0, 45]) cube(120, true);  // 45° Referenz

module stripes_2()let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk])
for(i=[-81:5*sqrt(2):110]) rotate([0, 0, 45]) rotate([wx_2, 0, 0])  
    translate([-150, -150, i]) cube([300, 300, 0.5]);

module stripes_1()let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk])
for(i=[-81:5*sqrt(2):110]) rotate([wx, 0, 0]) rotate([0, wy, 0])  
    translate([-150, -150, i]) cube([300, 300, 0.5]);

module stripes_0()let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk])
for(i=[-81:15.9:110]) rotate([45, 45, 0]) 
    translate([-150, -150, i]) cube([300, 300, 1.65/scale]);

module ghost(){
    translate([-b/2, -l/2]) cube ([b, l, h]);
    translate([-b/2, wstrk +l/2]) cube ([b, l, h]);
    translate([-b/2, -wstrk -1.5*l]) cube ([b, l, h]);
    translate([-b/2, -fb/2, h]) cube ([b, fb, wstrk]);
    translate([-b/2, l+wstrk-fb/2, h]) cube ([b, fb, wstrk]);
    translate([-b/2, -l-wstrk-fb/2, h]) cube ([b, fb, wstrk]);
}

stellen()
{
    // wände längs 
    let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk]){
    echo(str("wände längs: 2x ", str(xyz*scale)));
    translate([b/2, xyz[1]/-2, 0]) cube (xyz);
    };
    let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk]){
    translate([-wstrk-b/2, xyz[1]/-2, 0]) cube (xyz);
    };

    // wände quer hoch
    let(xyz = [b/2-tb/2, wstrk, h+wstrk]){
    translate([-b/2, l*1.5+wstrk, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*1.5+wstrk, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h+wstrk]){
    echo(str("wände quer hoch: 4x ", str(xyz*scale)));
    translate([-b/2, -l*1.5-2*wstrk, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*1.5-2*wstrk, 0]) cube (xyz);
    };

    // wände quer flach
    let(xyz = [b/2-tb/2, wstrk, h]){
    echo(str("wände quer flach: 4x ", str(xyz*scale)));
    translate([-b/2, -l*0.5-wstrk, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*0.5-wstrk, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, l*0.5, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*0.5, 0]) cube (xyz);
    };
    union(){
        // decke innen
        let(xyz = [b, l -fb + wstrk, wstrk]){
        echo(str("decke innen: 2x ", str(xyz*scale)));
        translate([-b/2, fb/2, h]) cube (xyz);
        translate([-b/2, -xyz[1]-fb/2, h]) cube (xyz);
        };
    
        // decke vorne + hinten
        let(xyz = [b, l/2-fb/2, wstrk]){
        echo(str("decke vorne + hinten: 2x ", str(xyz*scale)));
        translate([-b/2, -1.5*l - wstrk, h]) cube (xyz);
        translate([-b/2, l+wstrk+fb/2, h]) cube (xyz);
        };
    };
}

module aussenstreifen (){
    for (x=[b/2, -b/2], z = [0, h])
    translate([x, 0, z]) cube([wstrk, 3*l, wstrk], center=true);
    
    for (x=[b/2, -b/2], y = [l*1.5, -l*1.5])
    translate([x, y, h/2]) cube([wstrk, wstrk, h], center=true);
    

    for (y = [l*1.5, -l*1.5], z = [0, h])
    translate([0, y, z]) cube([b, wstrk, wstrk], center=true);

}
;



module stellen() {
if (stellen) 
    scale(scale) children([0:$children-1]);
    
else if (staenderwerk)
    intersection(){
        stripes_2();
        scale(scale) children([0 : $children-1]);
    }
    
else
    difference() {
        translate([0, 0, 30]) cube([60, 190, 65], true);
        intersection(){
            stripes();
            scale(scale) children([0 : $children-1]);
        }
    }   
if (aussenstreifen) scale(scale) aussenstreifen();
};

//rotate([45, 0, 0])cube(50);