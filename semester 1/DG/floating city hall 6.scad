/*

todo Kuppelbunker:
* 

später/weniger wichtig
* Wohnung
  * Bad andeuten
  * Küche andeuten

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
 
buehne=1;
dachgang=1;
toiletten=0;
beschriftung=0;

cut_small = 1;
//$vpd = 480;

intersection(){
if (cut_small) translate([0, 0, 5]) cube([109.5, 109.5, 119.5], true);

//rotate([0, 0, 270])
difference(){
union(){
    if (cube) difference(){                                       // Quader
        cube([120, 120, 120], true);                                
        translate([0, 0, 5]) cube([110, 110, 120], true);     
    
        translate([0, -43, 14]) schiessscharte();                  // Toiletten Fenster
        translate([0, -43, -20]) schiessscharte();
        translate([43, 0, 14]) rotate([0, 0, -90]) schiessscharte();
        translate([43, 0, -20]) rotate([0, 0, -90]) schiessscharte();
        
        rotate([0, 0, 180]) translate([0, -43, -17]) schiessscharte();      // Backstage Fenster
        
        rotate([0, 0, 180]) translate([0, -43, 4]) schiessscharte();      // Wohnung Fenster
        rotate([0, 0, 180]) translate([0, -43, 25]) schiessscharte(); 
        rotate([0, 0, 180]) translate([0, -43, 46]) schiessscharte(); 
        rotate([0, 0, 180]) translate([0, -20, 46]) schiessscharte(); 
    
        rotate([0, 0, 90]) translate([0, 20, 46]) schiessscharte(); 
        rotate([0, 0, 90]) translate([0, 43, 25]) schiessscharte(); 
        
        rotate([0, 0, -90]) translate([0, -43, 34]) schiessscharte();
        rotate([0, 0, -90]) translate([0, -43, 8]) schiessscharte();     // Treppen Fenster
        rotate([0, 0, -90]) translate([0, -43, -19]) schiessscharte();
        rotate([0, 0, 180]) translate([0, 43, 21]) schiessscharte();
        rotate([0, 0, 180]) translate([0, 43, -6]) schiessscharte();
        rotate([0, 0, 180]) translate([0, 43, -33]) schiessscharte();
  
        rotate([0, 0, 0]) translate([0, 19, 57]) schiessscharte(h=7); // Schießscharten Dach   
        rotate([0, 0, 0]) translate([0, 4, 57]) schiessscharte(h=7);   
        rotate([0, 0, 0]) translate([0, -12, 57]) schiessscharte(h=7);  
        rotate([0, 0, 0]) translate([0, -28, 57]) schiessscharte(h=7);   
        rotate([0, 0, 0]) translate([0, -43, 57]) schiessscharte(h=7);
        rotate([0, 0, -90]) translate([0, 43, 57]) schiessscharte(h=7);
        rotate([0, 0, -90]) translate([0, 25, 57]) schiessscharte(h=7);
        rotate([0, 0, -90]) translate([0, 7, 57]) schiessscharte(h=7);
        rotate([0, 0, -90]) translate([0, -11, 57]) schiessscharte(h=7);
        rotate([0, 0, -90]) translate([0, -29, 57]) schiessscharte(h=7);
        rotate([0, 0, 180]) translate([0, 10, 57]) schiessscharte(h=7);
        rotate([0, 0, 90]) translate([0, -12, 57]) schiessscharte(h=7);   
    };

    if (kuppel) difference(){                                       // Kuppel
        union(){
            kuppel(120);      
            rotate([0, 0, 22.5]) cylinder(60, 50, 24, center=false, $fn=8);
            if (!cut_small) umtueren();
        };
        kuppel(110); 
        rotate([0, 0, 22.5]) cylinder(120, 18, 18, center=false, $fn=8);  // Dachluke
    }
    if (fahrstuhlschacht) {                             // Fahrstuhlschacht
        difference(){
            linear_extrude(120, center=true)
                polygon([[22.75,55], [25,60], [60,25], [55,22.75]]);
            translate([40, 40, 47.5]) rotate([0, 0, 45]) cube([20, 20, 20], true);
        }    
        translate([0, 0, 57.5]) linear_extrude(2.5) polygon([[60,60], [25,60], [60,25]]);
    }
    if (saalboden) translate([0, 0, -35]) linear_extrude(2.5)                  // Kellerdecke
        polygon([[-55,55], [25,55], [55,25], [55,-55], [-25,-55], [-55, -25]]);
    if (buehne) translate([0, 0, -32.5]) linear_extrude(2.5)                // Bühne
        polygon([[-25,55], [-15,55], [-10,35], [-35,10], [-55,15],[-55, 25]]);
    if (galerie) for(i=[0:45:270]) rotate([0, 0, -i]) linear_extrude(2.5, center=false) // Galerie
        polygon([[-25,55], [25,55], [20,45], [-20,45]]);
    if (badwaende) {
        linear_extrude(2.5) polygon([[55,-55], [25,-55], [55,-25]]);        // Bad Decken
        translate([0, 0, 22.5]) linear_extrude(2.5) 
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
        difference(){ 
            rotate([0, -90, 0])linear_extrude(2.5)              // Küche Wände
                 polygon([[57.5, 57.5], [57.5, 40], [42,40], [35,41], [35, 57.5]]);
            translate([-4,45,37.5]) cube([5, 10,20], false);   // Wohnungstür
        };
        translate([0, 2.5, 0]) rotate([0, -90, 90])linear_extrude(2.5) 
             polygon([[57.5, 57.5], [57.5, 40], [42,40], [35,41], [35, 57.5]]);
        translate([0, 0, 40]) linear_extrude(19)                // Wand zu Kuppel
            polygon([[-42.5,18], [-18,42.5], [0,42.5], [0,40], [-16.5,40], [-40,16.5], [-40,0], [-42.5,0]]);
                  
        translate([-56, 10, 22]) cube([5, 13, 8]);             // Wand füllen  
        translate([-55, 7, 27])  cube([8, 16, 6]);
        translate([-19, 44.5, 30.5])  cube([18, 10.5, 7]);        // Eingangsbereich
    };
    if (wendeltreppen) {                                        // Treppen
    translate([0, 0, -56])wendeltreppe ([for (i=[8.35:33.1:320]) i ], 25);
    translate([0, 0, -35])linear_extrude(2.5) 
        polygon([[-45,-55], [-25,-55], [-40,-30], [-47, -47]]);
    translate([0, 0, -32.6])wendeltreppe ([for (i=[8.35:32.5:480]) i ], 39.2);
    translate([0, 0, 1])wendeltreppe([for (i=[80:25:480]) i ], 45);   
    if (!cut_small) intersection(){
        cube([109.5, 109.5, 119.5], true);
        translate([-53, -25, 26.31]) rotate([0, 0, 45]) cube([5, 5, 5]); 
    };
    if (!cut_small) translate([-56, -21.5, 26.31])  cube([8, 15, 5]);                
    if (!cut_small) translate([-56, -26, 22.5])  cube([5, 15, 5]);             
    translate([-50, -45, -55]) cube([5, 11, 3]);            // unter Treppe im Keller
    translate([-51, -47, -55]) cube([4, 13, 5]);
    translate([-55, -47, -55]) cube([4, 17, 9]);
    translate([-55, -46, 0]) cube([6, 17, 5]);
    }
    if (dachgang) {
    color("cyan")translate([0, 0, 42.052]) linear_extrude(2.5)         // Aussichtsplattform
        polygon([[-23,-55], [25,-55], [55,-55], [55, -17], [38, -17], [35,-18], [16,-38], [-16.5,-38], [-38,-16.5], [-38,-15], [-38, 0], [-55,0], [-55,-23]]);
    color("red")translate([0, 0, 35]) linear_extrude(2.5) 
        polygon([[22.75, 55], [0, 55], [0, 42], [19.7, 42], [42, 18.7],[55, 18.7],[55, 22.75]]);
    color("green")polyhedron( [                 // Schräge
      [  42, 18.7,  35 ],  //0
      [ 55, 18.7,  35 ],  //1
      [ 55, -17,  42.052 ],  //2
      [  38, -17,  42.052 ],  //3
      [ 42, 18.7,  37.5 ],  //4
      [ 55, 18.7,  37.5 ],  //5
      [ 55, -17,  44.552 ],  //6
      [  38, -17,  44.552 ]], //7
      [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]] // left
      );
    }    
    if (beschriftung) beschriftungen();   
}

        
    translate([0, -55, -55]) cube([55, 55, 20], false);         // Keller Wände entfernen
    translate([-55, 0, -55]) cube([55, 55, 20], false);
    
    translate([40, 40, -45]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Keller Türen
    translate([-35, -43, -45]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-39.5, -55, -55]) cube([20, 20, 20], false);
    
    translate([40, 40, 12.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Galerie
    translate([40, -40, 12.5]) rotate([0, 0, 45]) cube([10, 20, 20], true);
    translate([-43, -31, 12.5]) rotate([0, 0, 45]) cube([15, 10, 20], true);
    
    translate([40, 40, -22.5]) rotate([0, 0, 45]) cube([20, 20, 20], true); // Türen Saalboden
    translate([40, -40, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-32, -48, -22.5]) rotate([0, 0, 45]) cube([10, 10, 20], true);
    translate([-40, 40, -20]) rotate([0, 0, 45]) cube([10, 10, 20], true);
        
    tueren();                                                   // Außentüren
    
    translate([-65, 25, -55]) cube([40, 40, 20], false);        // Keller Fenster
    translate([25, -65, -55]) cube([40, 40, 20], false);
 
  //  rotate([0, 0, 180])
    //translate([0, -60,0]) color("blue") cube([170, 120, 150], true);    
 //   rotate([0, 0, 90])
   // translate([0, -60,0]) color("blue") cube([170, 120, 150], true);
    
   // translate([0, 0, 70]) color("blue") cube([150, 150, 120], true);
   
}


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
    if (cut_small) translate([0, 52.5, 0]) rotate([90, 0, 0]) linear_extrude(10, center=true)
        polygon([[22.75,2.5], [-22.75,2.5], [-22.75,4], [-10,22.5], [10,22.5], [22.75,4]]);
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

module schiessscharte(h=5, b=2)
translate([60, 0, 0]) rotate([0, -90, 0]) union(){
    cube([h, b, 1], center=true);
    hull(){
        translate([0, 0, 0.5]) cube([h, b, 0.1], center=true);
        translate([0, 0, 5]) cube([h+3, b+3, 4], center=true);
    };
}
