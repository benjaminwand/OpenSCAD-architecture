/*

todo Kuppelbunker:

* refactorieren um schalungen einfacher machen zu können
* bad beton und innenausbau teli separieren
* in 3 gießbare Teile zerlegen
* Schalungen anlegen

später/weniger wichtig
* Wohnung
  * Küche Wände
  * Durchstieg + Leiter
  * Bad andeuten
  * Küche andeuten
  * erhöhter Eingengsbereich + Wohnungstür
* Fahrstuhldach und oben Fenster
* Dachkontur
* Treppe zu Wohnung
* Schräge auf Dach für Fahrstuhl

*/


// 1 cm = 1 meter

//$fn = 60;

// DESIGN OPTIONS

cube=0;

kuppel=1;
galerie=1;
buehne=1;
saalboden=1;

wendeltreppen=0;
dach=0;
bad=0;
wohnung=0;
beschriftung=0;

scale([2,2,2])intersection(){
%translate([0, 0, -43.75]) cube([109.5, 109.5, 22.5], true); 
%translate([0, 0, -15]) cube([109.5, 109.5, 35], true); 
translate([0, 0, 27.5]) cube([109.5, 109.5, 50], true); 

difference(){
union(){
    if (cube) difference(){                                       // Quader
        cube([120, 120, 120], true);                                
        translate([0, 0, 5]) cube([110, 110, 120], true);            
    };


    difference(){
        if (kuppel) union(){
            kuppel(120);                                        // Kupel
            rotate([0, 0, 22.5]) cylinder(60, 50, 24, center=false, $fn=8);
            umtueren();
        };
        if (kuppel) {kuppel(110); 
        rotate([0, 0, 22.5]) cylinder(120, 18, 18, center=false, $fn=8);}
        // Dachluke
        
        translate([0, -55, -55]) cube([55, 55, 20], false);         // Keller Wände entfernen
        translate([-55, 0, -55]) cube([55, 55, 20], false);
        
        translate([40, 40, -45]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Keller Türen
        translate([-38, -40, -45]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        translate([-40, -55, -55]) cube([20, 20, 20], false);
        
        translate([40, 40, -22.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Saalboden
        translate([40, -40, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    //    translate([-40, -40, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        translate([-32, -48, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        translate([-40, 40, -20]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        
        translate([40, 40, 12.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Galerie
        translate([40, -40, 12.5]) rotate([0, 0, 45]) cube([10, 20, 20], true);
      //  translate([-40, -40, 12.5]) rotate([0, 0, 45]) cube([20, 10, 20], true);
        translate([-48, -32, 12.5]) rotate([0, 0, 45]) cube([20, 10, 20], true);
    };
    if (saalboden) translate([0, 0, -35]) linear_extrude(2.5)                  // Kellerdecke
        polygon([[-55,55], [25,55], [55,25], [55,-55], [-25,-55], [-55, -25]]);
    if (buehne) translate([0, 0, -32.5]) linear_extrude(2.5)                // Bühne
        polygon([[-25,55], [-15,55], [-10,35], [-35,10], [-55,15],[-55, 25]]);
    if (galerie) for(i=[0:45:270]) rotate([0, 0, -i]) linear_extrude(2.5, center=false) // Galerie
        polygon([[-25,55], [25,55], [20,45], [-20,45]]);
    if (bad) {
        translate([0,0, 13.5])bad(23);
        translate([0,0, -16.5])bad(32.5);
        linear_extrude(2.5) polygon([[55,-55], [25,-55], [55,-25]]);        // Bad Decken
        translate([0, 0, 23]) linear_extrude(2.5) 
            polygon([[55,-55], [10,-55], [10,-53], [20,-53], [53,-20], [53,-10], [55,-10]]);
    }
    if (wohnung) {
        translate([0, 0, -7.5]) linear_extrude(2.5)         // Schlafkoje Boden
            polygon([[-55,55], [-25,55], [-55,25]]);
        translate([0, 0, 10]) linear_extrude(2.5)         // Bad Boden
            polygon([[-55,55], [-25,55], [-55,25]]);
        translate([0, 0, 32.5]) linear_extrude(2.5)         // Küche Boden
            polygon([[-55,55], [0,55], [0,47], [-18,47], [-47,18], [-47,0], [-55,0]]);
        translate([0, 0, 57.5]) linear_extrude(2.5)         // Küche Decke
            polygon([[-55,55], [0,55], [0,40], [-16.5,40], [-40,16.5], [-40,0], [-55,0]]);
    };
    if (wendeltreppen) {
    translate([0, 0, -35])linear_extrude(2.5) polygon([[-55,-55], [-25,-55], [-55,-25]]);
    color("blue")translate([0, 0, -32.6])wendeltreppe ([for (i=[8.35:33.1:480]) i ], 39.2);
    color("red")translate([0, 0, 1.2])wendeltreppe([for (i=[75:39:700]) i ], 45);  
    }
    if (dach) {      
    color("green")translate([0, 0, 42.052]) linear_extrude(2.5)         // Aussichtsplattform
            polygon([[-40,-55], [25,-55], [55,-55], [55, 30], [30, 55], [0, 55], [0, 35], [18, 35], [35, 18], [35,-18], [16,-38], [-16.5,-38], [-38,-16.5], [-38,-10], [-55,-10], [-55,-29], [-40,-40], [-46,-46]]);
    
    
    }
        
}
    tueren();                                                   // Außentüren
    
    translate([-65, 25, -55]) cube([40, 40, 20], false);        // Keller Fenster
    translate([25, -65, -55]) cube([40, 40, 20], false);
    
    translate([54, -44, 12]) cube([7, 2, 5], false);            // Toiletten Fenster
    translate([42, -61, 12]) cube([2, 7, 5], false);
    translate([54, -44, -22]) cube([7, 2, 5], false);       
    translate([42, -61, -22]) cube([2, 7, 5], false);
    
    translate([-61, 46, -20]) cube([7, 2, 5], false);            // Backstage Fenster
    
    translate([-61, 46, 2]) cube([7, 2, 5], false);            // Wohnung Fenster
    translate([-61, 46, 22]) cube([7, 2, 5], false);       
    translate([-42, 54, 22]) cube([2, 7, 5], false); 
    translate([-61, 46, 45]) cube([7, 2, 5], false);  
    translate([-61, 24, 45]) cube([7, 2, 5], false);  
    mirror([1,1,0])translate([-61, 24, 45]) cube([7, 2, 5], false);  
    
    translate([-61, -44, 42]) cube([7, 2, 5], false);            // Treppen Fenster
    translate([-42, -61, 30]) cube([2, 7, 5], false); 
    translate([-61, -44, 18]) cube([7, 2, 5], false);         
    translate([-42, -61, 5]) cube([2, 7, 5], false);
    translate([-61, -44, -7]) cube([7, 2, 5], false);       
    translate([-42, -61, -22]) cube([2, 7, 5], false);
 
 //   rotate([0, 0, 180])
   // translate([0, -60,0]) color("blue") cube([170, 120, 150], true);    
  //  rotate([0, 0, 90])
    //translate([0, -60,0]) color("blue") cube([170, 120, 150], true);
    
   // translate([0, 0, 70]) color("blue") cube([150, 150, 120], true);
   
}
}

if (beschriftung) beschriftungen();



module beschriftungen(){
translate([60, 60, -60]) text("Fahrstuhl");
translate([60, -60, -60]) text("Toiletten");
translate([-60, -60, -60]) text("Treppe", halign = "right");
translate([-60, 60, -60]) text("Wohnung", halign = "right");
}

module tueren()
for (i=[0:90:270]) rotate([0, 0, i]) {
    translate([0, 60, 12.5]) cube([20, 30, 20], true);
    translate([0, 60, 18.5]) rotate([90, 45/2, 0]) cylinder(50, 10.8, 10.8, true, $fn=8);
};
  
module umtueren()
for (i=[0:90:270]) rotate([0, 0, i]) 
    translate([0, 50, 18]) rotate([90, 45/2, 0]) cylinder(20, 15, 15, true, $fn=8);
  
module kuppel(w)
intersection_for(n = [1 : 8]){
    rotate([0, 0, n * 45])
    hull() {
        intersection(){
            translate([w/2, 0, 0])scale([1, 1, 0.65])rotate([90, 0, 0]) cylinder(w, w, w, true , $fn=80);
            translate([0, 0, w*0.25])cube([2*w, 2*w, w*0.75], true);
        };
        translate([0, 0, -w/2])cube([w, w, 0.1], true);
    }
}
module bad(h) {
translate([55, -55.75, 0.25-h/2]) rotate([0, 0, 45]) cube([1, 10, h]);  // Wand
                                                                        // Toiletten
translate([52.5, -36, 0.25-h/2]) rotate([0, 0, 60])resize([6,4,4]) cylinder($fn=10,center=false);
translate([36, -52.5, 0.25-h/2]) rotate([0, 0, 30])resize([6,4,4]) cylinder($fn=10,center=false);

translate([48, -53, 0.25-h/2]) cylinder(8,1,2,$fn=10,center=false);     // Waschbecken
translate([53, -48, 0.25-h/2]) cylinder(8,1,2,$fn=10,center=false);
}

module wendeltreppe(stufen, hoehe)
for (i=[0:len(stufen)-1], h=hoehe/len(stufen))
{
    echo(i, h);
    hull(){
translate([0, 0, h*i])  one_step (stufen[i]);
if(i<len(stufen)-1) translate([0, 0, h*(i+1)]) one_step (stufen[i+1]);
if(i<len(stufen)-1)  translate([0, 0, h*(i+1)]) one_step (stufen[i]);
    }
    
};

module one_step (i)
intersection(){
    linear_extrude(200)  polygon([[-55,-55], [-25,-55], [-55,-25]]);
    translate([-46,-46,0]) rotate([0, 0, i]) cube([20,1, 1]);
}

