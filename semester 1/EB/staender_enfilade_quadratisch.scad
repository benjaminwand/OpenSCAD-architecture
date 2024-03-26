// Übung für "Entwerfen und Baukonstruktion 1" TU Berlin WS 2023/24

// Darstellungsoptionen
stellen = 0;            // Platten. else: Stangen
staenderwerk = 0;       // ständer 3d version. else: diff mit Box
ghost = 0;
A4 = 0;
aussenstreifen = 1;
base=1;


// Maße
scale = 1/50;

l = 2500;           // Raumlänge
b = 2500;           // Raumbreite
h = 2500;           // Raumhöhe

tb = 833;           // Türbreite
fb = 833;           // Fensterbreite

wstrk = 1.5 / scale;    // Wandstärke
wx = 55;            // Winkel
d = 9.65;           // Streifen Abstand
p = -86.8;          // Streifen Position
minw = 1.2 / scale;


// Skizzen
if (ghost) %scale(scale) ghost();              // innenraum
if (A4) %square([200,200*sqrt(2)], true);   // Din A4 Referenz
//rotate([0,0, 45]) cube(120, true);  // 45° Referenz
if (base) cube([180, 80, 0.2], true);

// Lötpunkte
points = [
// Punkte an den langen horizontalen
for (x=[-b/2, b/2], y=[-l*1.5:l/3:l*1.5], z = [0, h]) [x, y, z]*scale,
// Punkte an den Vertikalen
for (x=[-b/2, b/2], y=[-l*1.5, l*1.5], z = [h/3, 2*h/3]) [x, y, z]*scale,
// Punkte an den Türen unten eine Seite
for (x=-tb/2, y=[-l*1.5: l: l*1.5], z = 0) [x, y, z]*scale,
// Punkte an den kurzen horizontalen oben
for (x=[-tb/2, tb/2], y=[-l*1.5, l*1.5], z = h) [x, y, z]*scale,
for (x=tb/2, y=[-l*0.5, l*0.5], z = h) [x, y, z]*scale,
// Punkte an den Seiten für die Innenwände
for (x=[-b/2, b/2], y=[-l*0.5, l*0.5], z = [h/3, 2*h/3]) [x, y, z]*scale,
]; 

module loetpunkte() for (i=points) translate(i) sphere(6);//cube(8, true);

module stripes()let(xyz = [wstrk, 3*l + 4*wstrk, h+wstrk])
for(i=[p:d:110]) rotate([0, 0, 45]) rotate([wx, 0, 0])  
    translate([0, 0, i]) cube([200, 200, wstrk*scale], true);
    
module skylights() {
    translate([-b/2, -fb/2, h]) cube ([b, fb, wstrk]);
    translate([-b/2, l-fb/2, h]) cube ([b, fb, wstrk]);
    translate([-b/2, -l-fb/2, h]) cube ([b, fb, wstrk]);
}

module skylights_narrow() {
    translate([wstrk-b/2, minw-fb/2, h-2*wstrk]) cube ([b-2*wstrk, fb-2*minw, 3*wstrk]);
    translate([wstrk-b/2, minw+l-fb/2, h-2*wstrk]) cube ([b-2*wstrk, fb-2*minw, 3*wstrk]);
    translate([wstrk-b/2, minw-l-fb/2, h-2*wstrk]) cube ([b-2*wstrk, fb-2*minw, 3*wstrk]);
}

module ghost(){
    translate([-b/2, -l/2]) cube ([b, l, h]);
    translate([-b/2, wstrk +l/2]) cube ([b, l, h]);
    translate([-b/2, -wstrk -1.5*l]) cube ([b, l, h]);
    skylights();
    translate([-tb/2, 1.5*l-wstrk/2, 0]) cube ([tb, wstrk, h]);
    translate([-tb/2, -1.5*l-wstrk/2, 0]) cube ([tb, wstrk, h]);
    translate([-tb/2, 0.5*l-wstrk/2, 0]) cube ([tb, wstrk, h]);
    translate([-tb/2, -0.5*l-wstrk/2, 0]) cube ([tb, wstrk, h]);
}


stellen()
{
    // wände längs 
    let(xyz = [wstrk, 3*l, h]){
    translate([b/2-wstrk/2, xyz[1]/-2, 0]) cube (xyz);
    };
    let(xyz = [wstrk, 3*l, h]){
    translate([-wstrk/2-b/2, xyz[1]/-2, 0]) cube (xyz);
    };

    // wände quer hoch
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, l*1.5-wstrk/2, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*1.5-wstrk/2, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, -l*1.5-0.5*wstrk, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*1.5-0.5*wstrk, 0]) cube (xyz);
    };

    // wände quer flach
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, -l*0.5-wstrk*0.5, 0]) cube (xyz);
    translate([b/2 - xyz[0], -l*0.5-wstrk*0.5, 0]) cube (xyz);
    };
    let(xyz = [b/2-tb/2, wstrk, h]){
    translate([-b/2, l*0.5-wstrk*0.5, 0]) cube (xyz);
    translate([b/2 - xyz[0], l*0.5-wstrk*0.5, 0]) cube (xyz);
    };
    union(){
        // decke innen
        let(xyz = [b, l -fb, wstrk]){
        translate([-b/2, fb/2, h-0.5*wstrk]) cube (xyz);
        translate([-b/2, -xyz[1]-fb/2, h-0.5*wstrk]) cube (xyz);
        };
    
        // decke vorne + hinten
        let(xyz = [b, l/2-fb/2, wstrk]){
        translate([-b/2, -1.5*l, h-0.5*wstrk]) cube (xyz);
        translate([-b/2, l+fb/2, h-0.5*wstrk]) cube (xyz);
        };
    };
}

module aussenstreifen (){
    for (x=[b/2, -b/2], z = [0, h])
        translate([x, 0, z]) cube([wstrk, 3*l, wstrk], center=true);
    for (x=[b/2, -b/2], y = [l*1.5, -l*1.5])
        translate([x, y, h/2]) cube([wstrk, wstrk, h], center=true);
    for (y = [l*1.5, -l*1.5])
        translate([0, y, h]) cube([b, wstrk, wstrk], center=true);
    for (x=[b/4+tb/4, -b/4-tb/4], y = [l*1.5, l*0.5, -l*0.5, -l*1.5])
        translate([x, y, 0]) cube([b/2-tb/2, wstrk, wstrk], center=true);
};

module aussenbox()
{
    for (x=[b/2, -b/2]) translate([x, 0, h/2]) 
        cube([wstrk + 2*minw, 3*l + 2*minw + wstrk, h + 2*minw + wstrk], center=true);
    for (y = [-l*1.5:l: l*1.5])
        translate([0, y, h/2]) cube([b, wstrk + 2*minw, h+ wstrk + 2*minw], center=true);
    translate([0, 0, h]) cube([b + 2*minw+wstrk, 3*l + 2*minw+wstrk, wstrk + 2*minw], center=true);
};


module stellen() {
if (stellen) 
    scale(scale) children([0:$children-1]);
    
else if (staenderwerk){
    intersection(){
        stripes();
        scale(scale) children([0 : $children-1]);
    };
    loetpunkte();
    if (aussenstreifen) scale(scale) aussenstreifen();
    }
    
else translate([0, 0, (h+wstrk/2+minw)*scale]) rotate([180, 0, 90]) 
    difference() {
        scale(scale) aussenbox();
        intersection(){
            stripes();
            scale(scale) children([0 : $children-1]);
        }
        loetpunkte();
        if (aussenstreifen) scale(scale) aussenstreifen();
        scale(scale)skylights_narrow();
    }   
};
