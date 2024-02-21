/*

Ich lasse das jetzt so und arbeite am Präsentationsmodell.

todo Kuppelbunker:

* refactorieren um schalungen einfacher machen zu können
* Schalungen anlegen inkl zusammen hängend machen

später/weniger wichtig
* Wohnung
  * Bad andeuten
  * Küche andeuten
* Dachkontur auf Fahrstuhl anpassen
* Treppe zu Wohnung

*/


// 1 cm = 1 meter


// DESIGN OPTIONS

cube=0;

kuppel=1;
galerie=1;
saalboden=1;
badwaende=1;
wendeltreppen=1;
wohnung=1;
fahrstuhlschacht=1;
 
buehne=0;
dach=0;
toiletten=0;
beschriftung=1;
//intersection(){translate([0, 0, 5]) cube([109.5, 109.5, 119.5], true);


//rotate([0, 0, 270])
difference(){
union(){
    if (cube) difference(){                                       // Quader
        cube([120, 120, 120], true);                                
        translate([0, 0, 5]) cube([110, 110, 120], true);            
    };

    if (kuppel) difference(){                                       // Kuppel
        union(){
            kuppel(120);      
            rotate([0, 0, 22.5]) cylinder(60, 50, 24, center=false, $fn=8);
            umtueren();
        };
        kuppel(110); 
        rotate([0, 0, 22.5]) cylinder(120, 18, 18, center=false, $fn=8);  // Dachluke
    
        translate([40, 40, 12.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Galerie
        translate([40, -40, 12.5]) rotate([0, 0, 45]) cube([10, 20, 20], true);
        translate([-45, -29, 12.5]) rotate([0, 0, 45]) cube([15, 10, 20], true);
    };
    if (saalboden) translate([0, 0, -35]) linear_extrude(2.5)                  // Kellerdecke
        polygon([[-55,55], [25,55], [55,25], [55,-55], [-25,-55], [-55, -25]]);
    if (buehne) translate([0, 0, -32.5]) linear_extrude(2.5)                // Bühne
        polygon([[-25,55], [-15,55], [-10,35], [-35,10], [-55,15],[-55, 25]]);
    if (galerie) for(i=[0:45:270]) rotate([0, 0, -i]) linear_extrude(2.5, center=false) // Galerie
        polygon([[-25,55], [25,55], [20,45], [-20,45]]);
    if (badwaende) {
        linear_extrude(2.5) polygon([[55,-55], [25,-55], [55,-25]]);        // Bad Decken
        translate([0, 0, 23]) linear_extrude(2.5) 
            polygon([[55,-55], [10,-55], [10,-53], [20,-53], [53,-20], [53,-10], [55,-10]]);
    }
    if (toiletten){
        translate([0,0, 13.5])bad(23);
        translate([0,0, -16.5])bad(32.5);}
    if (wohnung) {
    difference(){
        union(){
            translate([0, 0, -7.5]) linear_extrude(2.5)         // Schlafkoje Boden
                polygon([[-55,55], [-25,55], [-55,25]]);
            translate([0, 0, 10]) linear_extrude(2.5)         // Bad Boden
                polygon([[-55,55], [-25,55], [-55,25]]);
            translate([0, 0, 32.5]) linear_extrude(2.5)         // Küche Boden
            polygon([[-55,55], [0,55], [0,47], [-18,47], [-47,18], [-47,0], [-55,0]]);
            };
            translate([-55, 50, -10]) cube([5, 5, 50]);   // Durchstieg
        };
        difference(){
            translate([0, 0, 57.5]) linear_extrude(2.5)         // Küche Decke
                polygon([[-55,55], [0,55], [0,40], [-16.5,40], [-40,16.5], [-40,0], [-55,0]]);
              translate([-55, 47, 56]) cube([8, 8, 5]);    
              translate([-35, 47, 56]) cube([8, 8, 5]);    
              translate([-15, 47, 56]) cube([8, 8, 5]);    
              translate([-55, 27, 56]) cube([8, 8, 5]);    
              translate([-55, 7, 56]) cube([8, 8, 5]);    
        };
        rotate([0, -90, 0])linear_extrude(2.5)              // Küche Wände
             polygon([[57.5, 57.5], [57.5, 40], [42,40], [35,41], [35, 57.5]]);
        difference(){
            translate([0, 2.5, 0]) rotate([0, -90, 90])linear_extrude(2.5) 
                 polygon([[57.5, 57.5], [57.5, 40], [42,40], [35,41], [35, 57.5]]);
            translate([-55,-1,37.5]) cube([10, 5,20], false);   // Wohnungstür
        };        
        translate([0, 0, 40]) linear_extrude(19)                // Wand zu Kuppel
            polygon([[-42.5,18], [-18,42.5], [0,42.5], [0,40], [-16.5,40], [-40,16.5], [-40,0], [-42.5,0]]);
                  
        translate([-56, 10, 22])  cube([5, 13, 8]);             // Wand füllen  
        translate([-55, 7, 27])  cube([8, 16, 6]);
        translate([-55, -7, 30.5])  cube([10.5, 26, 7]);        // Eingangsbereich
        translate([-55, -19, 30.5])  cube([10.5, 13, 9]);       // Außentreppe
        translate([-55, -19, 30.5])  cube([10.5, 9, 11.5]);
    };
    if (wendeltreppen) {                                        // Treppen
    translate([0, 0, -56])wendeltreppe ([for (i=[8.35:33.1:320]) i ], 25);
    translate([0, 0, -35])linear_extrude(2.5) 
        polygon([[-45,-55], [-25,-55], [-40,-30], [-47, -47]]);
    translate([0, 0, -32.6])wendeltreppe ([for (i=[8.35:33.1:480]) i ], 39.2);
    translate([0, 0, 1.2])wendeltreppe([for (i=[75:39:700]) i ], 45);  
    translate([-29, -57, 17.725]) rotate([0, 0, 45]) cube([7, 15, 3]);   
    translate([-26.5, -51.5, 20.35]) rotate([0, 0, 45]) cube([4.75, 15, 3]);   
    translate([-36.5, -41.5, 22.55]) rotate([0, 0, 45]) cube([5.5, 10, 3.5]);   
    translate([-43.5, -37.5, 23.65]) rotate([0, 0, 45]) cube([8, 16, 5]);    
    translate([-53, -26.5, 26.31]) rotate([0, 0, 45]) cube([8, 15, 5]);       
    translate([-56, -21.5, 26.31])  cube([8, 15, 5]);                
    translate([-56, -26, 22])  cube([5, 15, 5]);             
    translate([0, 0, 42.05]) linear_extrude(2.5) 
        polygon([[-21, -57], [-34, -60], [-45, -43], [-38,-15], [-15.5, -38.]]);
    translate([-50, -45, -55]) cube([5, 11, 3]);
    translate([-51, -47, -55]) cube([4, 13, 5]);
    translate([-55, -47, -55]) cube([4, 17, 9]);
    translate([-55, -46, 0]) cube([6, 17, 5]);
    }
    if (dach) {
    color("cyan")translate([0, 0, 42.052]) linear_extrude(2.5)         // Aussichtsplattform
        polygon([[-40,-55], [25,-55], [55,-55], [55, 22.75], [22.75, 55], [0, 55], [0, 35], [18, 35], [35, 18], [35,-18], [16,-38], [-16.5,-38], [-38,-16.5], [-38,-15], [-55,-15], [-55,-29], [-40,-40], [-46,-46]]);
    }    
    if (fahrstuhlschacht) {         // Fahrstuhlschacht
    difference(){
        color("green") linear_extrude(120, center=true)
            polygon([[22.75,55], [25,60], [60,25], [55,22.75]]);
        translate([40, 40, 47.5]) rotate([0, 0, 45]) cube([20, 20, 20], true);
    }    
    color("green") linear_extrude(120, center=true) polygon([[60,60], [25,60], [60,25]]);
    }
    if (beschriftung) beschriftungen();   
}

        
    translate([0, -55, -55]) cube([55, 55, 20], false);         // Keller Wände entfernen
    translate([-55, 0, -55]) cube([55, 55, 20], false);
    
    translate([40, 40, -45]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Keller Türen
    translate([-35, -43, -45]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-39.5, -55, -55]) cube([20, 20, 20], false);
    
    translate([40, 40, -22.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Saalboden
    translate([40, -40, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-32, -48, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-40, 40, -20]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        
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
 
//    rotate([0, 0, 180])
  //  translate([0, -115,0]) color("blue") cube([170, 120, 150], true);    
  //  rotate([0, 0, 90])
    //translate([0, -60,0]) color("blue") cube([170, 120, 150], true);
    
   // translate([0, 0, 70]) color("blue") cube([150, 150, 120], true);
   
//}


}





module beschriftungen(){
translate([80, 40, -60]) rotate([0, 0, 115]) text("Fahrstuhl");
translate([40, -80, -60]) rotate([0, 0, 25]) text("Toiletten");
translate([-60, -80, -60]) rotate([0, 0, 295]) text("Treppe", halign = "right");
translate([-80, 60, -60]) rotate([0, 0, 205]) text("Wohnung", halign = "right");
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
    linear_extrude(200)  polygon([[-60,-60], [-18,-60], [-60,-18]]);
    translate([-47,-47,0]) rotate([0, 0, i]) cube([30,5, 1]);
}

