/*
* fenster 
* Dach, Dachterasse
    * Spa/Sauna/Sport
    * Waschküche
    * Heimkino
    * Youtube studio
* texts anlegen
* Stangen Verbindungen, unterbau seriös(er) machen
* außentüren mit openings_implied anlegen
* aussen wand stärken überprüfen

öffentlich räume:
unten
    * in dem Sinne wie das Wohnzimmer vieler Leute ein repräsentativer Raum ist in dem Menschn die Gelegenheit bekommen ihre kulturelle Identität auszudrücken, fände ich es gut wenn der "öffentliche" Raum am Park ein Raum ist der die Kultur der Bewohner*innen ausdrückt
    * es ist auch ein Raum in den bei Bedarf alle rein passen
    * wenn niemandem etwas einfällt, wird es ein Restaurant, Essen braucht immer mal jemand, sowohl die Personen im Haus als auch Gäste der Sportstätten
    
hof
    ✓ Werkstatt (Fahrrad etc.), Makerspace
    * Gemeinschaftsgarten im Hof + auf Dachterrasse, Gewächshaus
    ✓ Fahrradschuppen
    ✓ Basten/Textil
    ✓ Bibliothek
    ✓ Gästezimmer
    ✓ Spielezimmer
    ✓ Coworking
    
Fahrstuhl Süd
    ✓ Musikzimmer Probenraum
    
Dach
    * Spa/Sauna/Sport
    * Waschküche
    * Heimkino
    * Youtube studio
*/

scale = 1/200;
rot = -16.39; // Grundstück nach Norden ausrichten und zurück
h_bodenplatte = 4000;
d_bodenplatte = 300;
railing = 1100;

z_cut = 0;
z_cutheight = 6000;
doorshigh = 0;  // einfacher zeichnen mit ober reus stehenden türen
e = 5;          // epsilon-wert
eg = 1;
og1 = 0;
og2 = 0;
og3 = 0;
walls = 1;
openings_implied = 0;

stangen_x = 6671;
stangen_y = 5253;
stuetzen_z = 800;       // curvature
tree_placement = [[5300, 31500], [5300+stangen_x*1.5, 31500], [5300+stangen_x*3, 31500]];

// flow control
module haus()
rotate([0, 0, -rot])
scale(scale)
translate([-22500, -22000])
{
    //grundstueck (); 
    difference(){
        union(){
            grundplatte(d_bodenplatte);
            if (eg) for (x=[0:stangen_x:47000], y=[1500:stangen_y:29000])
                translate([x, y]) color("lightgreen") bodensaeule();    
            if (eg) for (x=[0:stangen_x:37000], y=[1500:stangen_y:49000])
                translate([x, y]) color("lightgreen") bodensaeule();
            if (eg) for (x=[stangen_x/2 + 150:stangen_x:46000], y=[1650:stangen_y:29000]) 
                translate([x, y, h_bodenplatte - 500 - d_bodenplatte]) stuetzen_x();
            if (eg) for (x=[stangen_x/2 + 150:stangen_x:36000], y=[1650:stangen_y:49000]) 
                translate([x, y, h_bodenplatte - 500 - d_bodenplatte]) stuetzen_x();
            if (eg) for (x=[150:stangen_x:37000], y=[1650 + stangen_y/2:stangen_y:49000]) 
                translate([x, y, h_bodenplatte - 500 - d_bodenplatte]) stuetzen_y();
            if (og1 && walls) hausform3000(3000 - e, h_bodenplatte);
            if (og2 && walls) hausform3000(3200 - e, h_bodenplatte + 3000);
            if (og3 && walls) hausform3000(3200 - e, h_bodenplatte + 6200);
            if (og1 && walls) hausform2500(2500 - e, h_bodenplatte);
            if (og2 && walls) hausform2500(2700 - e, h_bodenplatte + 2500);
            if (eg) eg_aussen();
        }
        raeume_innen($doors = 1, $rooms=1, $staircase=1, $windows=0);
    entrances();
    }
    metall();
};



if (z_cut) projection() 
intersection(){
    translate([0, 0, z_cutheight * scale]) cube([20000, 20000, 0.1], center=true);
    haus(); 
}
else haus();
    
    
module grundstueck() color("black") scale([1000, 1000, 1])
    translate([-113.3608, 44.89835]) rotate([0, 0, rot])
    import("grundr2.stl"); // Grundriss 1:1000
module bodensaeule() cube([300, 300, 4000]);
module bad_barrierefrei() cube([2800, 2500, 2500]);
module tuer_barrierefrei() 
    cube([1000, 1000, doorshigh?3500:2000]);
module tuer_innen() 
    cube([800, 800, doorshigh?3500:2000]);
module tuer_klein() 
    cube([600, 600, doorshigh?3500:2000]);
{       // Fenster Module
module opening_south_ally(x, z, x_pos, y_pos, z_pos)
    if (openings_implied) 
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
        translate([x_pos, y_pos + 400, z_pos]) cube([x, 300, z]);
    };
module opening_south_3000(x, z, x_pos, y_pos, z_pos)
    if (openings_implied) 
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
        translate([x_pos, y_pos + 400, z_pos]) cube([x, 300, z]);
    };
module opening_west_ally(y, z, x_pos, y_pos, z_pos)
    if (openings_implied) 
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
        translate([x_pos + 400, y_pos, z_pos]) cube([300, y, z]);
    };
module opening_west_3000(y, z, x_pos, y_pos, z_pos)
    if (openings_implied) 
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
        translate([x_pos + 400, y_pos, z_pos]) cube([300, y, z]);
    };
};
module raeume_innen() {
    if (og1) we_01_ally_innen();     // 5
    if (og2) we_02_ally_innen();     // 5                                          
    if (og1) we_03_ally_innen();     // 5                                        
    if (og2) we_04_ally_innen();     // 5      
    if (og1) we_05();                // 4
    if (og2) we_06(h_bodenplatte + 3200);    // 5
    if (og3) we_06(h_bodenplatte + 6400);    // 5
    if (og2) we_08_paare(h_bodenplatte + 3200);  // 4
    if (og3) we_08_paare(h_bodenplatte + 6400);  // 4
    if (og2) family(h_bodenplatte + 3200);       // 7
    if (og3) family(h_bodenplatte + 6400);       // 7        
    //-> 56, davon 20 barrierefrei und 8 Kinder
    
    if ($staircase) color("blue") {       // Treppenhaus süd + Probenraum
        translate ([18000, 1900, 0]) cube([4000, 5200, h_bodenplatte+5200]); // Treppenhaus süd
        if (og1) translate ([19000, 7100, h_bodenplatte]) cube([2000, 7600, 2500]); // Gang zum Hof am treppenhaus süd
        if (og2) translate ([19000, 7100, h_bodenplatte + 2700]) cube([2000, 2000, 2500]); // Treppenhaus Süd
         };
    if ($windows) opening_south_ally(2000, 1300, 19000, 1350, h_bodenplatte -300);
    if ($windows) opening_south_ally(2000, 1300, 19000, 1350, h_bodenplatte + 2200);
       
        
    if ($rooms && og2) color("green") translate([0, 0, h_bodenplatte + 2700])    // Musikraum 
        {translate ([19100, 9400, 0]) cube([1800, 5300, 2500]); // Musik Proberaum 
        if ($doors) translate ([19500, 9000, 0]) cube([1000, 1000, 2000]); // Tür Musik Proberaum 
            
        };
    if ($windows) rotate([0, 0, 180]) opening_south_ally(1200, 1300, -20600, -15350, 900);
            
    
    if ($staircase) color("blue") {                   // Treppenhaus ost
        translate ([41400, 25500, 0]) cube([5200, 2200, 15000]); // Treppenhaus süd ost
        if (og1) translate ([35000, 26700, h_bodenplatte]) cube([6800, 1000, 3000]); // Durchgang treppenhaus Ost
            
        };
    if ($windows) 
        for (z = [h_bodenplatte - 300, h_bodenplatte + 2700, h_bodenplatte + 5900])
            rotate([0, 0, 180]) opening_west_3000(1000, 1800, -47200, -27100, z);
    
    if ($staircase) color("blue") {        // Treppenhaus nord
        translate ([15100, 43100, 0]) cube([4000, 5600, h_bodenplatte+10000]); // Treppenhaus Nord  
        if (og1) translate ([16000, 38100, h_bodenplatte]) cube([2000, 7600, 3000]); // Gang zum Hof am treppenhaus nord
        };
    
    if ($rooms && og1)         // Gemeinschaftsräume nordwest
        color("green") translate([0, 0, h_bodenplatte]) {
            translate ([400, 38100, 0]) cube([4500, 8500, 3000]); // fahrradschuppen
            translate ([400, 38100, 0]) cube([1700, 10600, 3000]);
            translate ([2300, 46800, 0]) cube([900, 1900, 3000]); // Toiette Fahrradschuppen
            translate ([3400, 46800, 0]) cube([1500, 1900, 3000]); // Toiette Bibiothek (barrierefrei)
            translate ([5100, 38100, 0]) cube([10700, 4800, 3000]); // werkstatt
            translate ([5100, 43100, 0]) cube([4800, 5600, 3000]); // basten/textil
            translate ([10100, 43100, 0]) cube([4800, 5600, 3000]); // bibiothek
            
            if ($doors){
                translate ([3400, 37500, 0]) tuer_barrierefrei(); // fahrradschuppen
                translate ([2400, 46300, 0]) tuer_klein(); // Toiette Fahrradschuppen
                translate ([4400, 46900, 0]) tuer_barrierefrei(); // Toiette Bibiothek (barrierefrei)
                translate ([6100, 37500, 0]) tuer_barrierefrei(); // werkstatt
                translate ([9200, 43500, 0]) tuer_barrierefrei(); // basten/textil
                translate ([14500, 43200, 0]) tuer_barrierefrei(); // bibiothek
            };
        };
    
    if ($rooms && og1)       // Gemeinschaftsräume nordost
        color("green") translate([0, 0, h_bodenplatte]) {
            {translate ([18200, 38100, 0]) cube([7200, 4800, 3000]); 
            translate ([19300, 38100, 0]) cube([2800, 6900, 3000]); 
            translate ([19300, 38100, 0]) cube([6100, 6200, 3000]);} // Spiele
            translate ([25600, 38100, 0]) cube([7600, 6200, 3000]); // Sport
            linear_extrude(3000) polygon([[43100, 27900], [33200, 37800],[33200, 41000], [29100, 38500], [29100, 34900], [36100, 27900]]);  // Coworkingng spac3
          
            translate ([19300, 45200, 0]) cube([2800, 3500, 3000]); // Gästezimmer 1
            translate ([22300, 44500, 0]) cube([2300, 4200, 3000]); // Gästezimmer 2
            translate ([24800, 43100, 0]) cube([900, 3200, 3000]);  // Flur zu Bad 1
            translate ([25900, 44500, 0]) cube([2500, 1800, 3000]);     // WC
            translate ([24800, 46500, 0]) cube([2300, 2200, 3000]);     // Gäste Bad 1
            translate ([27300, 46500, 0]) cube([2200, 2200, 3000]);     // Gäste Bad 2    
            translate ([28600, 43100, 0]) cube([900, 3200, 3000]);  // Flur zu Bad
            translate ([29700, 44500, 0]) cube([1600, 4200, 3000]); // Gästezimmer 3
            translate ([31500, 44500, 0]) cube([1700, 4200, 3000]); // Gästezimmer 4
            
            if ($doors){
                translate ([18400, 43200, 0]) tuer_barrierefrei();  // Spiele Treppenhaus
                translate ([21500, 37400, 0]) tuer_barrierefrei();  // Spiele Hof
                translate ([28500, 36000, 0]) tuer_barrierefrei();  // Coworkingng spac3
              
                translate ([19400, 44800, 0]) tuer_barrierefrei();  // Gästezimmer 1
                translate ([22400, 44000, 0]) tuer_barrierefrei();  // Gästezimmer 2
                translate ([26000, 44200, 0]) tuer_barrierefrei();  // WC
                translate ([24850, 46200, 0]) tuer_innen();         // Gäste Bad 1
                translate ([28650, 46200, 0]) tuer_innen();         // Gäste Bad 2   
                translate ([29800, 44000, 0]) tuer_innen();         // Gästezimmer 3
                translate ([31600, 44000, 0]) tuer_innen();         // Gästezimmer 4
            }
        };
        
    if ($rooms && eg) eg_innen();
}

module we_01_ally_innen() a11y_west(h_bodenplatte);
module we_02_ally_innen() a11y_west(h_bodenplatte + 2700);
module we_03_ally_innen() a11y_east(h_bodenplatte);
module we_04_ally_innen() a11y_east(h_bodenplatte + 2700);
    
module a11y(h) {
    {translate ([400, 1900, h]) cube([6000, 5200, 2500]);     // Süd Küche Wäsche
    translate ([4600, 6750, h]) tuer_barrierefrei();
    translate ([6600, 1900, h]) cube([4000, 5200, 2500]); 
    translate ([7800, 6750, h]) tuer_barrierefrei();
    translate ([10800, 1900, h]) bad_barrierefrei();
    translate ([10400, 3300, h]) tuer_barrierefrei();
    translate ([10800, 4600, h]) bad_barrierefrei();
    translate ([12900, 4700, h]) tuer_barrierefrei();
    translate ([13800, 1900, h]) cube([4000, 5200, 2500]);
    translate ([15400, 6750, h]) tuer_barrierefrei();} 
    {translate ([3000, 7300, h]) cube([15800, 2000, 2500]); // Flur
    translate ([16000, 7300, h]) cube([2800, 4700, 2500]);}
    translate ([400, 7300, h]) cube([2400, 2000, 2500]); // Gäste Toilette
    
    translate ([2300, 7750, h]) tuer_barrierefrei();
    translate ([18300, 7750, h]) tuer_barrierefrei();
    
    {translate ([400, 9500, h]) cube([4000, 5200, 2500]); // Nord
    translate ([3400, 8750, h]) tuer_barrierefrei();
    translate ([4600, 9500, h]) bad_barrierefrei();
    translate ([4200, 12250, h]) tuer_barrierefrei();
    translate ([4600, 12200, h]) bad_barrierefrei();
    translate ([7200, 10850, h]) tuer_barrierefrei();
    translate ([7600, 9500, h]) cube([4000, 5200, 2500]); 
    translate ([9400, 8750, h]) tuer_barrierefrei();
    translate ([11800, 9500, h]) cube([4000, 5200, 2500]); 
    translate ([13200, 8750, h]) tuer_barrierefrei();
    translate ([16000, 12200, h]) bad_barrierefrei();
    translate ([15200, 12250, h]) tuer_barrierefrei();}
    
    if ($windows) {
        for (x = [900, 2600, 4300, 7000, 9000, 11700, 14300, 16200])
           opening_south_ally(1200, 1300, x, 1350, h + 900);
        for (x = [-2000, -3900, -6600, -9200, -11100, -13500, -15200, -18000])
            rotate([0, 0, 180]) opening_south_ally(1200, 1300, x, -15350, h + 900);
    }
}

module a11y_east(h) translate([40000, 0, 0]) mirror([1, 0, 0])  a11y(h);
module a11y_west(h) {
    a11y(h);
    ally_windows_west(h);
};
module ally_windows_west(h)
    if ($windows) for (y = [2000, 3700, 7700, 11700, 13400])
        opening_west_ally(1200, 1300, -200, y, h + 900);


module we_05() translate ([0,0, h_bodenplatte]){
    translate ([39800, 1900, 0]) cube([6800, 4200, 3000]);      // Küche / Wohnen
    translate ([39800, 6300, 0]) cube([1200, 20200, 3000]);     // Flur
    translate ([40000, 25500, 0]) cube([1200, 1000, 3000]);     // Flur
    linear_extrude(3000) polygon([[39800, 26500], [37500, 26500], [39800, 24200]]); // Genkan
    
    translate ([41200, 6300, 0]) cube([5400, 3800, 3000]);  
    translate ([41200, 10300, 0]) cube([5400, 3800, 3000]);  
    translate ([41200, 14300, 0]) cube([5400, 3800, 3000]);   
    translate ([41200, 18300, 0]) cube([5400, 3800, 3000]); 
    
    translate ([41200, 22300, 0]) cube([5400, 1300, 3000]);     // Bad Vorraum
    translate ([41200, 22300, 0]) cube([1200, 1800, 3000]);
    translate ([42600, 23800, 0]) cube([1800, 1500, 3000]);    // Duschraum
    translate ([44600, 23800, 0]) cube([2000, 1500, 3000]);    // Wannenraum
    translate ([41200, 24300, 0]) cube([1200, 1000, 3000]); // Toilette
    
    translate ([40000,6000, 0]) tuer_innen();
    translate ([40900,7800, 0]) tuer_innen();
    translate ([40900,11800, 0]) tuer_innen();
    translate ([40900,15800, 0]) tuer_innen();
    translate ([40900, 19800, 0]) tuer_innen();
    translate ([40900, 22400, 0]) tuer_innen();
    translate ([40900, 24400, 0]) tuer_innen();
    translate ([40900, 25600, 0]) tuer_innen();
    translate ([42700, 23100, 0]) tuer_innen();
    translate ([44700, 23100, 0]) tuer_innen();
    
    if ($windows) {
    for (y = [-3500, -5500, -7800, -9800, -11800, -13800, -15800, -17800, -19800, -21800])
        rotate([0, 0, 180]) opening_west_3000(1200, 1800, -47200, y, 1000);
    for (y = [ -23400, -25000])
        rotate([0, 0, 180]) opening_west_3000(800, 1800, -47200, y, 1000);
    for (x = [ 40400, 42700, 45000])
        opening_south_ally(1200, 1800, x, 1350, 1000);
    };
    
};
    
module we_06(h) translate ([0,0, h]){
    translate ([39800, 1900, 0]) cube([6800, 4200, 3000]);  // Küche / Wohnen
    translate ([39800, 6300, 0]) cube([1200, 21400, 3000]);  // Flur
    translate ([40000, 25500, 0]) cube([1200, 2200, 3000]);  // Flur
    linear_extrude(3000) polygon([[39800, 26500], [37500, 26500], [39800, 24200]]); // Genkan
    
    translate ([41200, 6300, 0]) cube([5400, 3800, 3000]);  // Wohnen
    translate ([41200, 10300, 0]) cube([5400, 3800, 3000]);  
    translate ([41200, 14300, 0]) cube([5400, 3800, 3000]);   
    translate ([41200, 18300, 0]) cube([5400, 3800, 3000]); 
    linear_extrude(3000) polygon([[39600, 27900],[43100, 27900],[38500, 32500], [35000, 29000], [37300, 26700], [39600, 26700]]); 
    
    translate ([41200, 22300, 0]) cube([5400, 1300, 3000]);     // Bad Vorraum
    translate ([41200, 22300, 0]) cube([1200, 1800, 3000]);
    translate ([42600, 23800, 0]) cube([1800, 1500, 3000]);    // Duschraum
    translate ([44600, 23800, 0]) cube([2000, 1500, 3000]);    // Wannenraum
    translate ([41200, 24300, 0]) cube([1200, 1000, 3000]); // Toilette
    translate ([40000,6000, 0]) tuer_innen();
    translate ([40900,7800, 0]) tuer_innen();
    translate ([40900,11800, 0]) tuer_innen();
    translate ([40900,15800, 0]) tuer_innen();
    translate ([40900, 19800, 0]) tuer_innen();
    translate ([40900, 22400, 0]) tuer_innen();
    translate ([40900, 24400, 0]) tuer_innen();
    translate ([40900, 25800, 0]) tuer_innen();
    translate ([42700, 23100, 0]) tuer_innen();
    translate ([44700, 23100, 0]) tuer_innen();
    translate ([40200, 27400, 0]) tuer_innen();
    
    if ($windows) {
    for (y = [-3500, -5500, -7800, -9800, -11800, -13800, -15800, -17800, -19800, -21800])
        rotate([0, 0, 180]) opening_west_3000(1200, 1800, -47200, y, 1000);
    for (y = [ -23400, -25000])
        rotate([0, 0, 180]) opening_west_3000(800, 1800, -47200, y, 1000);
    for (x = [ 40400, 42700, 45000])
        opening_south_ally(1200, 1800, x, 1350, 1000);
    };
};
    
module we_08_paare(h) translate([0, 0, h]){
    translate ([400, 40200, 0]) cube([4500, 6400, 3000]); // Küche
    translate ([400, 46800, 0]) cube([4500, 1900, 3000]); // Bad
    translate ([400, 38100, 0]) cube([4500, 1900, 3000]); // Bad
    {translate ([5100, 43100, 0]) cube([9800, 900, 3000]);  // Flur
    translate ([13400, 42000, 0]) cube([1500, 1100, 3000]);}   // Genkan
    
    translate ([4800, 39000, 0]) tuer_innen();
    translate ([4800, 47000, 0]) tuer_innen();
    translate ([4800, 43150, 0]) tuer_innen();
    translate ([6000, 42700, 0]) tuer_innen();
    translate ([11000, 42700, 0]) tuer_innen();
    translate ([8000, 43700, 0]) tuer_innen();
    translate ([13000, 43700, 0]) tuer_innen();
    translate ([14500, 43150, 0]) tuer_innen();
    translate ([9500, 45150, 0]) tuer_innen();
    translate ([9500, 39000, 0]) tuer_innen();
    
    {translate ([9800, 38100, 0]) cube([3400, 4800, 3000]);
    translate ([9800, 38100, 0]) cube([5100, 3700, 3000]);}
    translate ([5100, 38100, 0]) cube([4500, 4800, 3000]);
    translate ([10100, 44200, 0]) cube([4800, 4500, 3000]); 
    translate ([5100, 44200, 0]) cube([4800, 4500, 3000]); 
    
};
    
module family(h) {
    {translate ([22300, 44500, h]) cube([3400, 4200, 3000]); 
    translate ([19300, 45200, h]) cube([6400, 3500, 3000]);};
        
    translate ([28600, 44500, h]) cube([4600, 4200, 3000]); 
    translate ([25900, 44500, h]) cube([2500, 1800, 3000]);     // Bad
    translate ([25900, 46500, h]) cube([2500, 2200, 3000]);     // Bad
    
    {translate ([19300, 43100, h]) cube([11000, 1200, 3000]);   // Flur
    translate ([29100, 38100, h]) cube([1200, 5200, 3000]);
    translate ([19300, 43100, h]) cube([2800, 1900, 3000]);
    translate ([19300, 42100, h]) cube([900,1900, 3000]);
    translate ([18200, 42000, h]) cube([2000,900, 3000]);}
        
    translate ([15100, 38100, h]) cube([2900, 4800, 3000]);
    translate ([18200, 38100, h]) cube([3000, 3700, 3000]);
    translate ([20400, 38100, h]) cube([1500, 4800, 3000]);
    translate ([22100, 38100, h]) cube([3300, 4800, 3000]);
    translate ([25600, 38100, h]) cube([3300, 4800, 3000]);
    
    translate ([30500, 38100, h]) cube([2700, 6200, 3000]);     // Kinderbad
    
    translate ([0, 0, h]) linear_extrude(3000) polygon([[33100, 37900],[29100, 37900], [29100, 34900], [34850, 29150], [38350, 32650]]);        // Küche
    
    translate ([18500, 43200, h]) tuer_barrierefrei();  
    translate ([17500, 42050, h]) tuer_innen();
    translate ([20500, 42200, h]) tuer_barrierefrei();
    translate ([23500, 42200, h]) tuer_barrierefrei();
    translate ([26500, 42200, h]) tuer_barrierefrei();
    translate ([23500, 44000, h]) tuer_barrierefrei();
    translate ([29000, 44000, h]) tuer_barrierefrei();
    translate ([28000, 45400, h]) tuer_innen();
    translate ([25500, 46600, h]) tuer_innen();
    translate ([30000, 43000, h]) tuer_barrierefrei();
    translate ([29200, 37500, h]) tuer_barrierefrei();
}

module eg_innen(){
    translate ([40400, 1900, 0]) cube([6200, 23400, h_bodenplatte - d_bodenplatte]);
    if ($windows) 
        for (y = [-4000, -6000, -8000, -13000, -15000, -17000, -19000, -21000])
            rotate([0, 0, 180]) opening_west_3000(1500, 2000, -47200, y, 300);
};

module eg_aussen() {
    translate ([40000, 1500, 0]) cube([7000, 23800, h_bodenplatte - d_bodenplatte - e]);
    translate ([41000, 1500, 0]) cube([6000, 26570, h_bodenplatte - d_bodenplatte - e]);
    translate ([17600, 1500, 0]) cube([4800, 6000, h_bodenplatte - d_bodenplatte - e]);
    translate ([14700, 42700, 0]) cube([4800, 6400, h_bodenplatte - d_bodenplatte - e]);
}

module entrances() {
    translate ([19500, 14600, h_bodenplatte]) tuer_barrierefrei();
    translate ([16500, 37500, h_bodenplatte]) tuer_barrierefrei();
    translate ([19500, 1400, 0]) tuer_barrierefrei();
    translate ([16500, 48500, 0]) tuer_barrierefrei();
    translate ([46100, 26100, 0]) tuer_barrierefrei();
    translate ([39900, 9000, 0]) tuer_barrierefrei();
    translate ([46100, 9250, 0]) tuer_barrierefrei();
    };

module grundplatte(d) 
difference(){
    color("grey") translate ([0, 0, h_bodenplatte-d]) linear_extrude(d) 
    polygon([[0, 1500],[47000, 1500], [47000, 28100], [43500, 28100], [33650, 37950],[33650, 49080],[0, 49080]]);  
    for (i=tree_placement) translate(i) cylinder(2* h_bodenplatte, 1000, 1000);
};

module hausform3000(d, h) {
    color("white") translate ([0, 0, h]) linear_extrude(d) 
    polygon([[47000, 1500], [47000, 28100], [43500, 28100], [33650, 37950],[33650, 49080],[0, 49080], [0, 37700], [28600, 37700], [28600, 34650], [39300, 23950],[39300, 15200],[39300, 1500]]);  
    }
 module hausform2500(d, h) {
    color("lightgreen") translate ([0, 1500, h]) cube([39300, 13700, d]);  
    }
    
module metall() color("gold"){
    for (i=tree_placement) translate(i) baumzaun();
    for (y = [15300 : 120 : 37700]) 
        translate([20, y, h_bodenplatte]) cylinder(railing, 20, 20, $fn=20);
    translate ([0, 15200, h_bodenplatte + railing]) cube([40, 22500, 40], center = false); 
};
    
module baumzaun() 
    for (i= [1:6:360]) rotate([0, 0, i]) union(){
    translate ([1000, 0, h_bodenplatte + railing]) cube([40, 120, 40], center = true);   
    translate ([1000, 10]) cylinder(h_bodenplatte + railing, 20, 20, $fn=20);
    }
    
module stuetzen_x() difference(){
    cube([stangen_x, 300, stuetzen_z *2], true);
    translate([0, 0, -stuetzen_z]) resize([stangen_x, 400, stuetzen_z * 2.5]) rotate([90, 0, 0]) 
        cylinder(300, stangen_x, stangen_x, true);
}
module stuetzen_y() difference(){
    cube([300, stangen_y, stuetzen_z*2], true);
    translate([0, 0, -stuetzen_z]) resize([400, stangen_y, stuetzen_z * 2.5]) rotate([0, 90, 0]) 
        cylinder(300, stangen_y, stangen_y, true);
}
