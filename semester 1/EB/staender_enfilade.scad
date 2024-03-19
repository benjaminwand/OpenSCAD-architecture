// Todo
/*
* alle punkte festlegen
* streifn zwischen punkte
* außenwände um alles abzuziehen
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

wstrk = 1.65 / scale;//stellen ? 3/scale : 1.65/scale;    // Wandstärke
wstrk2 = 1.65 / scale;
wx = 45;         // Winkel
wy = 35;
wx_2 = 55;


// Skizzen
if (ghost) %scale(scale) ghost();              // innenraum
if (A4) %square([200,200*sqrt(2)], true);   // Din A4 Referenz
//rotate([0,0, 45]) cube(120, true);  // 45° Referenz

module stripes_2()let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk])
for(i=[-81.4:5*sqrt(2):110]) rotate([0, 0, 45]) rotate([wx_2, 0, 0])  
    translate([-150, -150, i]) cube([300, 300, wstrk2*scale]);

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
    translate([-b/2, -fb/2, h]) cube ([b, fb, wstrk2]);
    translate([-b/2, l+wstrk-fb/2, h]) cube ([b, fb, wstrk2]);
    translate([-b/2, -l-wstrk-fb/2, h]) cube ([b, fb, wstrk2]);
    translate([-tb/2, 1.5*l-wstrk2/2, 0]) cube ([tb, wstrk2, h]);
    translate([-tb/2, -1.5*l-wstrk2/2, 0]) cube ([tb, wstrk2, h]);
    translate([-tb/2, 0.5*l-wstrk2/2, 0]) cube ([tb, wstrk2, h]);
    translate([-tb/2, -0.5*l-wstrk2/2, 0]) cube ([tb, wstrk2, h]);
}

stellen()
{
    // wände längs 
    let(xyz = [wstrk, 3*l, h]){
    translate([b/2-wstrk2/2, xyz[1]/-2, 0]) cube (xyz);
    };
    let(xyz = [wstrk, 3*l, h]){
    translate([-wstrk2/2-b/2, xyz[1]/-2, 0]) cube (xyz);
    };

    // wände quer hoch
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, l*1.5-wstrk2/2, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*1.5-wstrk2/2, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, -l*1.5-0.5*wstrk2, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*1.5-0.5*wstrk2, 0]) cube (xyz);
    };

    // wände quer flach
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, -l*0.5-wstrk2*0.5, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*0.5-wstrk2*0.5, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, l*0.5-wstrk2*0.5, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*0.5-wstrk2*0.5, 0]) cube (xyz);
    };
    union(){
        // decke innen
        let(xyz = [b, l -fb + wstrk, wstrk]){
        translate([-b/2, fb/2, h-0.5*wstrk2]) cube (xyz);
        translate([-b/2, -xyz[1]-fb/2, h-0.5*wstrk2]) cube (xyz);
        };
    
        // decke vorne + hinten
        let(xyz = [b, l/2-fb/2-0.5*wstrk2, wstrk]){
        translate([-b/2, -1.5*l, h-0.5*wstrk2]) cube (xyz);
        translate([-b/2, l+wstrk+fb/2, h-0.5*wstrk2]) cube (xyz);
        };
    };
}

module aussenstreifen (){
    for (x=[b/2, -b/2], z = [0, h])
        translate([x, 0, z]) cube([wstrk2, 3*l, wstrk2], center=true);
    for (x=[b/2, -b/2], y = [l*1.5, -l*1.5])
        translate([x, y, h/2]) cube([wstrk2, wstrk2, h], center=true);
    for (y = [l*1.5, -l*1.5])
        translate([0, y, h]) cube([b, wstrk2, wstrk2], center=true);
    for (x=[b/4+tb/4, -b/4-tb/4], y = [l*1.5, l*0.5, -l*0.5, -l*1.5])
        translate([x, y, 0]) cube([b/2-tb/2, wstrk2, wstrk2], center=true);
};



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

//rotate([0, 0, 45])cube(50);