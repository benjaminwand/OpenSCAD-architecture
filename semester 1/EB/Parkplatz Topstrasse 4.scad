/*
* treppenhaus Nord rum drehen und Räume anpassen
* Tonnen gewölbe Decken einbauen
* Säulen umziehen
* texts anlegen
    * EG
    * 1
    * 2
    * 3
    * Dach
* Dach, Dachterasse
    * Spa/Sauna/Sport
    * Waschküche
    * Heimkino
    * Youtube studio
* Bäume umziehen
    
* Fenster Code austauschen
* Fenster 
* Pärchen-WG symmetrisch machen ???
* fenster und türen vervollständigen am öffentlichen Raum

* Parkplatz präzisieren
* Fundament einzeichnen

* Bogen unter 38° Außenlinie machen ???
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


// Design-Optionen
scale = 1/200;
rot = -16.39;           // Grundstück nach Norden ausrichten und zurück
z_cut = 0;
z_cutheight = 6000;
doorshigh = 1;          // einfacher zeichnen mit ober raus stehenden tueren
e = 5;                  // epsilon-wert, nummerisch in mm, zum Rendern 0 machen
eg = 1;
og1 = 0;
og2 = 0;
og3 = 0;
walls = 1;
roof = 0;
openings_implied = 1;
fast_curves = 1;        // nacht Vorschau schneller, zum Rendern 0 machen
metall = 1;             // Zäunchen
arches = 0;
parking = 1;
color_index = 1;

// Farben
color_walls = "black";
color_yard = "lightgrey";
color_pillars = "black";
color_arches = "grey";
color_access = "cyan";
color_elevator = "DeepSkyBlue";
color_private = "Yellow";
color_public = "SpringGreen";
color_full_public = "pink";
color_entrance_doors = "cyan";
color_metal = "goldenrod";
color_text = "black";
color_parking = "lightgrey";

// Maße
h_bodenplatte = 5000;
d_bodenplatte = 300;
railing = 1100;
dicke_saeule = 400;
stangen_x = 6600;
stangen_y = 5187;
stangen_y_neu = [2000, for (i=[5600:4790:50000])i];
//[2000, 4000, 9000, 14000, 19000, 24000, 29000, 34000, 39000, 44000, 49000];
stuetzen_z = 800;       // curvature
schwelle = 5;
tree_placement = [
    [stangen_x + dicke_saeule/2, stangen_y * 5 + 2000 + dicke_saeule/2], 
    [stangen_x * 2 + dicke_saeule/2, stangen_y * 4 + 2000 + dicke_saeule/2], 
    [stangen_x * 3 + dicke_saeule/2, stangen_y * 5 + 2000 + dicke_saeule/2], 
    [stangen_x * 4 + dicke_saeule/2, stangen_y * 4 + 2000 + dicke_saeule/2]];

// flow control
module haus()
//rotate([0, 0, -rot])
scale(scale)
//translate([-22500, -22000])
//intersection(){ union()     // hier in Teile schneiden
//difference(){
{
    //grundstueck (); 
    difference(){
        union(){
            if (og1) grundplatte(d_bodenplatte);
            if (eg) for (x=[0:stangen_x:45000], y=[2000:stangen_y:29000])
                translate([x, y]) bodensaeule();    
            if (eg) for (x=[0:stangen_x:37000], y=[2000:stangen_y:50000])
                translate([x, y]) bodensaeule();
            
            if (arches && eg) {    
                for (x=[stangen_x/2 + dicke_saeule/2:stangen_x:40000], y=[2000+dicke_saeule/2:stangen_y:29000]) 
                    translate([x, y, h_bodenplatte - 500 - d_bodenplatte - e]) stuetzen_x();
                for (x=[stangen_x/2 + dicke_saeule/2:stangen_x:36000], y=[2000+dicke_saeule/2:stangen_y:49000]) 
                    translate([x, y, h_bodenplatte - 500 - d_bodenplatte - e]) stuetzen_x();
                
                for (x=[dicke_saeule/2:stangen_x:40000], y=[2000+dicke_saeule/2 + stangen_y/2:stangen_y:30000]) 
                    translate([x, y, h_bodenplatte - 500 - d_bodenplatte - e]) stuetzen_y();
                for (x=[dicke_saeule/2:stangen_x:37000], y=[2000+dicke_saeule/2 + stangen_y/2:stangen_y:49000]) 
                    translate([x, y, h_bodenplatte - 500 - d_bodenplatte - e]) stuetzen_y();
            };
            
            if (walls){
                if (og1) hausform3000(3000 - e, h_bodenplatte);
                if (og2) hausform3000(3200 - e, h_bodenplatte + 3000);
                if (og3) hausform3000(3200 - e, h_bodenplatte + 6200);
                if (og1) hausform2500(2500 - e, h_bodenplatte);
                if (og2) hausform2500(2700 - e, h_bodenplatte + 2500);
            };
            eg_aussen();
        }
        raeume_innen($doors = 1, $rooms=1, $staircase=1, $windows=1, $text=1, $elevator=1);
        entrances($entrance_doors=1);
        // 
        for (i=tree_placement) translate(i) cylinder(3 * h_bodenplatte, 1000, 1000, center = true, $fn=fast_curves?10:30);
        for (i=tree_placement) translate([i[0], i[1], h_bodenplatte*0.7 - d_bodenplatte])
            resize([stangen_x *2 - dicke_saeule, stangen_y *2 - dicke_saeule, h_bodenplatte/2]) sphere(h_bodenplatte/2, $fn=fast_curves?10:30);
    }
    if (metall) metall();
    if (roof) {
        dach_nord();
        dach_ost();
        dach_sued();
    }
    if (parking) parking();
    //translate([35600, 31500, 6000]) rotate([0, 0, 38]) cube([5500, 2000,18000], center=true);
    
    //for (i=stangen_y_neu) translate([0, i]) bodensaeule(); 
};

 //     scale([1, 1, 5]) hausform2500(2500 - e, 0); // Ally House
//};   
   //   scale([1, 1, 5]) hausform3000(3000 - e, 0);};    // hohes House



if (z_cut) projection() 
intersection(){
    translate([0, 0, z_cutheight * scale]) cube([20000, 20000, 0.1], center=true);
    haus(); 
}
else haus();
    
if (color_index)
    translate([-170, 50, 0]){
        translate([0, 100, 0]) color(color_walls) cube([10, 10, 1]);
        translate([12, 100, 0]) color("black") text("Mauern, Stützen");
        translate([0, 80, 0]) color(color_yard) cube([10, 10, 1]);
        translate([12, 80, 0]) color("black") text("Innenhof, Dachterrasse, Parkplatz");
        translate([0, 60, 0]) color(color_access) cube([10, 10, 1]);
        translate([12, 60, 0]) color("black") text("Zugänge, Treppenhäuser");
        translate([0, 40, 0]) color(color_elevator) cube([10, 10, 1]);
        translate([12, 40, 0]) color("black") text("Fahrstühle");
        translate([0, 20, 0]) color(color_full_public) cube([10, 10, 1]);
        translate([12, 20, 0]) color("black") text("Öffentlicher Raum");
        translate([0, 0, 0]) color(color_public) cube([10, 10, 1]);
        translate([12, 0, 0]) color("black") text("Gemeinschaftsräume");
        translate([0, -20, 0]) color(color_private) cube([10, 10, 1]);
        translate([12, -20, 0]) color("black") text("Wohneinheiten");
    }
    

    
module grundstueck() scale([1000, 1000, 1])
    translate([-113.3608, 44.89835]) rotate([0, 0, rot])
    import("grundr2.stl"); // Grundriss 1:1000
module bodensaeule() 
    color(color_pillars) cube([dicke_saeule, dicke_saeule, h_bodenplatte - e]);
module bad_barrierefrei() 
    cube([2800, 2500, 2500]);
module tuer_barrierefrei() 
    translate([0, 0, schwelle]) cube([1000, 1000, doorshigh?3100:2000]);
module tuer_innen() 
    translate([0, 0, schwelle]) cube([800, 800, doorshigh?3100:2000]);
module tuer_klein() 
    translate([0, 0, schwelle]) cube([600, 600, doorshigh?3100:2000]);

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
    
module opening_3000(breite, hoehe, x_pos, y_pos, z_pos, z_rot = 0)
    translate([x_pos, y_pos, z_pos]) rotate([0, 0, z_rot]) 
    if (openings_implied) 
        cube([breite, 300, doorshigh?3000:hoehe]);
    else 
        union() {
            cube([breite, 300, doorshigh?3000:hoehe]);
            translate([0, 400, 0]) cube([breite, 300, doorshigh?3000:hoehe]);
        };
   
    // Eingänge
    
module entrance(breite, hoehe, x_pos, y_pos, z_pos, z_rot = 0) color(color_entrance_doors)
    translate([x_pos, y_pos, z_pos + schwelle]) rotate([0, 0, z_rot]) 
        cube([breite, openings_implied?300:800, doorshigh?h_bodenplatte:hoehe]);
};

module raeume_innen() {
    color(color_private) {
        if (og1) we_01_ally_innen();                // 5
        if (og2) we_02_ally_innen();                // 5 
        if (og1) we_03_ally_innen();                // 5 
        if (og2) we_04_ally_innen();                // 5 
        if (og1) we_05();                           // 3
        if (og2) we_06(h_bodenplatte + 3200);       // 4
        if (og3) we_06(h_bodenplatte + 6400);       // 4
        if (og2) we_08_paare(h_bodenplatte + 3200); // 4
        if (og3) we_08_paare(h_bodenplatte + 6400); // 4
        if (og2) family(h_bodenplatte + 3200);      // 7
        if (og3) family(h_bodenplatte + 6400);      // 7 
        //-> 53, davon 20 barrierefrei und 8 Kinder
    };
    
    if ($staircase) 
        //if (eg || og1 || og2 || og3) 
        color(color_access) {       // Treppenhaus süd + Probenraum
            translate ([18000, 2400, 0]) cube([4000, 5200, h_bodenplatte+5200]); // Treppenhaus süd
            if (og1) translate ([19000, 7600, h_bodenplatte]) cube([2000, 7600, 2500]); // Gang zum Hof am treppenhaus süd
            if (og2) translate ([19000, 7600, h_bodenplatte + 2700]) cube([2000, 2000, 2500]); // Treppenhaus Süd
        };
    if ($elevator) color(color_elevator) translate ([19067.5, 3467.5, 0]) 
        cube([1865, 2845, h_bodenplatte+7500]); // Fahrstuhl süd
    
    if ($windows) opening_south_ally(2000, 1300, 19000, 1850, h_bodenplatte -300);
    if ($windows) opening_south_ally(2000, 1300, 19000, 1850, h_bodenplatte + 2200);
       
        
    if ($rooms && og2) color(color_public) translate([0, 0, h_bodenplatte + 2700])    // Musikraum 
        {translate ([19100, 9900, 0]) cube([1800, 5300, 2500]); // Musik Proberaum 
        if ($doors) translate ([19500, 9500, 0]) tuer_barrierefrei(); // Tür Musik Proberaum 
        };   
    if ($windows) rotate([0, 0, 180]) opening_south_ally(1200, 1300, -20600, -15850, h_bodenplatte + 2700 + 900);
           
    if ($staircase) color(color_access) {                   // Treppenhaus ost
        translate ([41400, 25600, 0]) cube([5200, 2300, 15000]); // Treppenhaus süd ost
        translate ([0, 0, h_bodenplatte]) linear_extrude(3000) 
            polygon([[41500, 27900], [41500, 26700], [39700, 26700], [37700, 25100],[36900, 26100], [39200, 27900]]); 
        };
    if ($windows) 
        for (z = [h_bodenplatte - 300, h_bodenplatte + 2700, h_bodenplatte + 5900])
            rotate([0, 0, 180]) opening_west_3000(1000, 1800, -47150, -27200, z);
    
    if ($staircase) color(color_access) {        // Treppenhaus nord
        translate ([15100, 43100, 0]) cube([4000, 5600, h_bodenplatte+10000]); // Treppenhaus Nord  
        
        if (og1) translate ([16000, 38100, h_bodenplatte]) cube([2000, 7600, 3000]); // Gang zum Hof am treppenhaus nord
        };
        
    if ($elevator) color(color_elevator) translate ([16167.5, 44500, 0]) 
        cube([1865, 2845, h_bodenplatte+12500]); // Fahrstuhl nord
    
    if (og1)                    // Gemeinschaftsräume nordwest
        color(color_public) translate([0, 0, h_bodenplatte]) {
            if ($rooms){
                translate ([400, 38100, 0]) cube([4500, 10600, 3000]); // werkstatt
                translate ([10100, 38100, 0]) cube([5700, 4800, 3000]); // basteln/textil
                translate ([5100, 38100, 0]) cube([4800, 10600, 3000]); // fahrradschuppen
                translate ([10100, 43100, 0]) cube([4800, 5600, 3000]); // bibiothek
            };
            
            if ($doors){
                translate ([14200, 43500, 0]) tuer_barrierefrei(); // basten/textil
                translate ([15500, 40200, 0]) tuer_barrierefrei(); // bibiothek
            };
        };
    
    if (og1)                    // Gemeinschaftsräume nordost
        color(color_public) translate([0, 0, h_bodenplatte]) {
            if ($rooms){
                {translate ([18200, 38100, 0]) cube([7200, 4800, 3000]); 
                translate ([19300, 38100, 0]) cube([2800, 6900, 3000]); 
                translate ([19300, 38100, 0]) cube([6100, 6200, 3000]);} // Spiele
                translate ([25600, 38100, 0]) cube([7400, 6200, 3000]); // Coworking spac3
                linear_extrude(3000) polygon([[41000, 28100], [41000, 28300], [33000, 38500],[33000, 41000], [29000, 38500], [29000, 36100], [36700, 26300], [39000, 28100]]);  // Coworking spac3 schräg
              
                translate ([19300, 45200, 0]) cube([2800, 3500, 3000]); // Gästezimmer 1
                translate ([22300, 44500, 0]) cube([2300, 4200, 3000]); // Gästezimmer 2
                translate ([24800, 43100, 0]) cube([900, 3200, 3000]);  // Flur zu Bad 1
                translate ([25900, 44500, 0]) cube([2500, 1800, 3000]);     // WC
                translate ([24800, 46500, 0]) cube([3600, 2200, 3000]);     // Gäste Bad
                translate ([28600, 44500, 0]) cube([2100, 4200, 3000]); // Gästezimmer 3
                translate ([30900, 44500, 0]) cube([2100, 4200, 3000]); // Gästezimmer 4
            }
            
            if ($doors){
                translate ([18400, 43400, 0]) tuer_barrierefrei();  // Treppenhaus Nord
                translate ([38500, 27000, 0]) rotate([0, 0, 38]) 
                    tuer_barrierefrei(); // Treppenhaus Ost
                translate ([19400, 44800, 0]) tuer_barrierefrei();  // Gästezimmer 1
                translate ([22400, 44000, 0]) tuer_barrierefrei();  // Gästezimmer 2
                translate ([26000, 44200, 0]) tuer_barrierefrei();  // WC
                translate ([24850, 46200, 0]) tuer_innen();         // Gäste Bad 
                translate ([28700, 44000, 0]) tuer_innen();         // Gästezimmer 3
                translate ([31000, 44000, 0]) tuer_innen();         // Gästezimmer 4
            }
        };
        
    if (eg) eg_innen();         // öffentliche Räume
}

module we_01_ally_innen() a11y_west(h_bodenplatte);
module we_02_ally_innen() a11y_west(h_bodenplatte + 2700);
module we_03_ally_innen() a11y_east(h_bodenplatte);
module we_04_ally_innen() a11y_east(h_bodenplatte + 2700);
    
module a11y(h) translate([0, 500]){
    if ($rooms) {
        translate ([6600, 1900, h]) cube([4000, 5200, 2500]);   // Süd
        translate ([10800, 1900, h]) bad_barrierefrei();
        translate ([10800, 4600, h]) bad_barrierefrei();
        translate ([13800, 1900, h]) cube([4000, 5200, 2500]);
        
        {translate ([3000, 7300, h]) cube([15800, 2000, 2500]); // Flur
        translate ([16000, 7300, h]) cube([2800, 4700, 2500]);}
        translate ([400, 7300, h]) cube([2400, 2000, 2500]);    // Gäste Toilette
        translate ([400, 1900, h]) cube([6000, 5200, 2500]);    // Küche 
        
        {translate ([400, 9500, h]) cube([4000, 5200, 2500]);   // Nord
        translate ([4600, 9500, h]) bad_barrierefrei();
        translate ([4600, 12200, h]) bad_barrierefrei();
        translate ([7600, 9500, h]) cube([4000, 5200, 2500]); 
        translate ([11800, 9500, h]) cube([4000, 5200, 2500]); 
        translate ([16000, 12200, h]) bad_barrierefrei();}
    }
    
    if ($doors){
        translate ([4600, 6750, h]) tuer_barrierefrei();
        translate ([7800, 6750, h]) tuer_barrierefrei();
        translate ([10400, 3300, h]) tuer_barrierefrei();
        translate ([12900, 4700, h]) tuer_barrierefrei();
        translate ([15400, 6750, h]) tuer_barrierefrei();
        translate ([2300, 7750, h]) tuer_barrierefrei();
        translate ([18300, 7750, h]) tuer_barrierefrei();
            
        translate ([3400, 8750, h]) tuer_barrierefrei();
        translate ([4200, 12250, h]) tuer_barrierefrei();
        translate ([7200, 10850, h]) tuer_barrierefrei();
        translate ([9400, 8750, h]) tuer_barrierefrei();
        translate ([13200, 8750, h]) tuer_barrierefrei();
        translate ([15200, 12250, h]) tuer_barrierefrei();
    }
    
    if ($windows) {
        for (x = [900, 2600, 4300, 7000, 9000, 11700, 14300, 16200])
            opening_south_ally(1200, 1300, x, 1350, h + 900);
        for (x = [-2000, -3900, -6600, -9200, -11100, -13500, -15200, -18000])
            rotate([0, 0, 180]) opening_south_ally(1200, 1300, x, -15250, h + 900);
    }
}

module a11y_east(h) {
    translate([40000, 0, 0]) mirror([1, 0, 0])  a11y(h);
    ally_windows_east(h);
}
module a11y_west(h) {
    a11y(h);
    ally_windows_west(h);
};
module ally_windows_west(h)
    if ($windows) for (y = [2500, 4200, 8200, 12200, 13900])
        opening_west_ally(1200, 1300, -200, y, h + 900);
    
module ally_windows_east(h)
    if ($windows) 
        rotate([0, 0, 180]) opening_west_ally(1200, 1300, -40150, -3800, h + 900);

module we_05() translate ([0,0, h_bodenplatte]){
    if ($rooms) {
        translate ([39800, 4600, 0]) cube([6800, 4500, 3000]);      // Küche / Wohnen
        translate ([39800, 9300, 0]) cube([1200, 17200, 3000]);     // Flur
        translate ([40000, 25600, 0]) cube([1200, 900, 3000]);      // Flur
        linear_extrude(3000) polygon([[39800, 26500], [37800, 24900], [39900, 22200]]); // Genkan
        
        translate ([41200, 9300, 0]) cube([5400, 4000, 3000]);  
        translate ([41200, 13500, 0]) cube([5400, 4000, 3000]);   
        translate ([41200, 17700, 0]) cube([5400, 4000, 3000]); 
        
        translate ([41200, 21900, 0]) cube([5400, 1500, 3000]);     // Bad Vorraum
        translate ([41200, 22400, 0]) cube([1200, 1800, 3000]);
        translate ([42600, 23600, 0]) cube([1800, 1800, 3000]);     // Duschraum
        translate ([44600, 23600, 0]) cube([2000, 1800, 3000]);     // Wannenraum
        translate ([41200, 24400, 0]) cube([1200, 1000, 3000]);     // Toilette
    }
    
    if ($doors) {
        translate ([40000,9000, 0]) tuer_innen();
        translate ([40900,11800, 0]) tuer_innen();
        translate ([40900,15800, 0]) tuer_innen();
        translate ([40900, 19800, 0]) tuer_innen();
        translate ([40900, 22400, 0]) tuer_innen();
        translate ([40900, 24400, 0]) tuer_innen();
        translate ([40900, 25700, 0]) tuer_innen();
        translate ([42700, 23100, 0]) tuer_innen();
        translate ([44700, 23100, 0]) tuer_innen();
    };
    
    if ($windows) {
    for (y = [-6500, -8500, -11000, -13000, -15200, -17200, -19400, -21400])
        rotate([0, 0, 180]) opening_west_3000(1200, 1800, -47200, y, 1000);
    for (y = [ -23100, -25000])
        rotate([0, 0, 180]) opening_west_3000(800, 1800, -47200, y, 1000);
    for (x = [ 40400, 42700, 45000])
        opening_south_ally(1200, 1800, x, 4050, 1000);
    };
};
    
module we_06(h) translate ([0,0, h]){
    if ($rooms) {
        translate ([39800, 4600, 0]) cube([6800, 4500, 3000]);      // Küche / Wohnen
        translate ([39800, 9300, 0]) cube([1200, 17200, 3000]);     // Flur
        translate ([39800, 25600, 0]) cube([1400, 1400, 3000]);     // Flur
        linear_extrude(3000) polygon([[39800, 26500], [37800, 24900], [39900, 22200]]); // Genkan
        
        translate ([41200, 9300, 0]) cube([5400, 4000, 3000]);  
        translate ([41200, 13500, 0]) cube([5400, 4000, 3000]);   
        translate ([41200, 17700, 0]) cube([5400, 4000, 3000]); 
        linear_extrude(3000) polygon([[39600, 27200],[41200, 27200],[41200, 28000],[38000, 32100], [34400, 29250], [37650, 25100], [39600, 26650]]); 
              
        translate ([41200, 21900, 0]) cube([5400, 1500, 3000]);     // Bad Vorraum
        translate ([41200, 22400, 0]) cube([1200, 1800, 3000]);
        translate ([42600, 23600, 0]) cube([1800, 1800, 3000]);    // Duschraum
        translate ([44600, 23600, 0]) cube([2000, 1800, 3000]);    // Wannenraum
        translate ([41200, 24400, 0]) cube([1200, 1000, 3000]); // Toilette
    }
    
    if ($doors){
        translate ([40000,9000, 0]) tuer_innen();
        translate ([40900,11800, 0]) tuer_innen();
        translate ([40900,15800, 0]) tuer_innen();
        translate ([40900, 19800, 0]) tuer_innen();
        translate ([40900, 22400, 0]) tuer_innen();
        translate ([40900, 24400, 0]) tuer_innen();
        translate ([40900, 25700, 0]) tuer_innen();
        translate ([42700, 23100, 0]) tuer_innen();
        translate ([44700, 23100, 0]) tuer_innen();
        translate ([40000, 26800, 0]) tuer_innen();
    };
    
    if ($windows) {
    for (y = [-6500, -8500, -11000, -13000, -15200, -17200, -19400, -21400])
        rotate([0, 0, 180]) opening_west_3000(1200, 1800, -47200, y, 1000);
    for (y = [ -23100, -25000])
        rotate([0, 0, 180]) opening_west_3000(800, 1800, -47200, y, 1000);
    for (x = [ 40400, 42700, 45000])
        opening_south_ally(1200, 1800, x, 4050, 1000);
    };
    
};
    
module we_08_paare(h) translate([0, 0, h]){
    if ($rooms) {
        translate ([400, 40200, 0]) cube([4500, 6400, 3000]); // Küche
        translate ([400, 46800, 0]) cube([4500, 1900, 3000]); // Bad
        translate ([400, 38100, 0]) cube([4500, 1900, 3000]); // Bad
        {translate ([5100, 43100, 0]) cube([9800, 900, 3000]);  // Flur
        translate ([13400, 42000, 0]) cube([1500, 1100, 3000]);}   // Genkan
        {translate ([9800, 38100, 0]) cube([3400, 4800, 3000]);
        translate ([9800, 38100, 0]) cube([5100, 3700, 3000]);}
        translate ([5100, 38100, 0]) cube([4500, 4800, 3000]);
        translate ([10100, 44200, 0]) cube([4800, 4500, 3000]); 
        translate ([5100, 44200, 0]) cube([4800, 4500, 3000]); 
    }
    
    if($doors) {
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
    }
    
};
    
module family(h) {
    if ($rooms) {
        {translate ([22300, 44500, h]) cube([3400, 4200, 3000]); 
        translate ([19300, 45200, h]) cube([6400, 3500, 3000]);};
            
        translate ([28600, 44500, h]) cube([4400, 4200, 3000]); 
        translate ([25900, 44500, h]) cube([2500, 1800, 3000]);     // Bad
        translate ([25900, 46500, h]) cube([2500, 2200, 3000]);     // Bad
        
        {translate ([19300, 43100, h]) cube([10700, 1200, 3000]);   // Flur
        translate ([19300, 43100, h]) cube([2800, 1900, 3000]);
        translate ([19300, 42100, h]) cube([900,1900, 3000]);
        translate ([18200, 42000, h]) cube([2000,900, 3000]);}
            
        translate ([15100, 38100, h]) cube([2900, 4800, 3000]);
        translate ([18200, 38100, h]) cube([3000, 3700, 3000]);
        translate ([20400, 38100, h]) cube([1500, 4800, 3000]);
        translate ([22100, 38100, h]) cube([3300, 4800, 3000]);
        translate ([25600, 38100, h]) cube([3300, 4800, 3000]);
        
        translate ([30200, 38100, h]) cube([2800, 6200, 3000]);     // Wohnzimmer
        translate ([29100, 38100, h]) cube([1200, 4800, 3000]);
    
        translate ([0, 0, h]) linear_extrude(3000) polygon([[35450, 35300], [33000, 38500],[33000, 41000], [29100, 38500], [29100, 36000], [31900, 32450]]);        // Küche 
        translate([34200, 29500, h]) rotate([0, 0, 38]) cube([4550, 3500, 3000]); // Kinderbad
        
     } 
    if ($doors) {
        translate ([18500, 43200, h]) tuer_barrierefrei();  
        translate ([17500, 42050, h]) tuer_innen();
        translate ([20500, 42200, h]) tuer_barrierefrei();
        translate ([23500, 42200, h]) tuer_barrierefrei();
        translate ([26500, 42200, h]) tuer_barrierefrei();
        translate ([23500, 44000, h]) tuer_barrierefrei();
        translate ([28800, 44000, h]) tuer_barrierefrei();
        translate ([28000, 45400, h]) tuer_innen();
        translate ([25500, 46600, h]) tuer_innen();
        translate ([29700, 43200, h]) tuer_barrierefrei();
        translate ([32500, 32000, h]) rotate([0, 0, 38]) tuer_barrierefrei();     // Bad 
    };
}

module eg_innen(){
    if ($rooms) color(color_full_public){
        translate ([40000, 4600, 0]) cube([6600, 20700, h_bodenplatte - d_bodenplatte]);
        translate ([40000, 25200, 0]) cube([1100, 2700, h_bodenplatte - d_bodenplatte]);
    };
 /*   if ($windows) 
        for (y = [-4000, -6000, -8000, -13000, -15000, -17000, -19000, -21000])
            rotate([0, 0, 180]) opening_west_3000(1500, 2000, -47200, y, 300);*/
};

module eg_aussen() color(color_walls) {
    translate ([39600, 4200, 0]) cube([7400, 24100, h_bodenplatte - d_bodenplatte - e]);
    if (eg || og1 || og2 || og3)
        translate ([14700, 42700, 0]) cube([4800, 6380, h_bodenplatte - d_bodenplatte - e]);
    if (eg || og1 || og2) 
        translate ([17600, 2000, 0]) cube([4800, 6000, h_bodenplatte - d_bodenplatte - e]);
}

module entrances() 
if ($entrance_doors){
    if (eg){
        entrance(1000, 2000, 19500, 1900, 0);                   // Eingang Süd
        entrance(1000, 2000, 47100, 26200, 0, 90);              // Eingang Ost
        entrance(1000, 2000, 17500, 49200, 0, 180);             // Eingang Nord
    }
    if (og1){
        entrance(1000, 2000, 20500, 15700, h_bodenplatte, 180); // Hof Süd
        entrance(1000, 2000, 16500, 37600, h_bodenplatte);      // Hof Nord
        entrance(1000, 2000, 36500, 25600, h_bodenplatte, -52); // Hof Ost
        entrance(1000, 2000, 2100, 37600, h_bodenplatte);       // Werkstatt
        entrance(1000, 2000, 7000, 37600, h_bodenplatte);       // Fahrradschuppen
        entrance(1000, 2000, 21500, 37600, h_bodenplatte);      // Hof Spiele 
    }
};

module grundplatte(d) 
    color(color_yard) translate ([0, 0, h_bodenplatte-d]) linear_extrude(d) 
        polygon([[0, 2000],[40000, 2000], [40000, 4200], [47000, 4200], [47000, 28300], [41500, 28300], [33400, 38700],[33400, 49080],[0, 49080]]);  

module hausform3000(d, h) //color(color_walls) 
    translate ([0, 0, h]) linear_extrude(d) 
        polygon([[47000, 4200], [47000, 28300], [41500, 28300], [33400, 38700], [33400, 49080],[0, 49080], [0, 37700], [28600, 37700], [28600, 36000], [39400, 22200], [39400, 4200]]);  
module hausform2500(d, h) //color(color_walls) 
{
    translate ([0, 2000, h]) cube([39400, 13600, d]);  
    translate ([0, 2000, h]) cube([40000, 2200, d]); 
}
    
module metall() color(color_metal){
    for (i=tree_placement) translate(i) baumzaun();
    for (y = [15300 : 120 : 37700]) 
        translate([20, y, h_bodenplatte]) cylinder(railing, 20, 20, $fn=fast_curves?4:30);
    translate ([0, 15200, h_bodenplatte + railing]) cube([40, 22500, 40], center = false); 
}
    
module baumzaun() 
    for (i= [1:6:360]) rotate([0, 0, i]) union(){
    translate ([1000, 0, h_bodenplatte + railing]) cube([40, 120, 40], center = true);   
    translate ([1000, 10]) cylinder(h_bodenplatte + railing, 20, 20, $fn=fast_curves?4:30);
}
    
module stuetzen_x() color(color_arches)
difference(){
    cube([stangen_x, dicke_saeule, stuetzen_z *2], true);
    translate([0, 0, -stuetzen_z]) resize([stangen_x, dicke_saeule*2, stuetzen_z * 2.5]) rotate([90, 0, 0]) 
        cylinder(300, stangen_x, stangen_x, true, $fn=fast_curves?10:30);
}
module stuetzen_y() color(color_arches)
difference(){
    cube([dicke_saeule, stangen_y, stuetzen_z*2], true);
    translate([0, 0, -stuetzen_z]) resize([dicke_saeule*2, stangen_y, stuetzen_z * 2.5]) rotate([0, 90, 0]) 
        cylinder(300, stangen_y, stangen_y, true, $fn=fast_curves?10:30);
}

module dach_sued(){
    rotate([0, 90, 0]) linear_extrude(40000) polygon([
        [-h_bodenplatte -5200, 1600],
        [-h_bodenplatte -5200, 16000], 
        [-h_bodenplatte -9000, 8800]]);  
    translate([0, 8800]) rotate([90, 90, 0]) linear_extrude(6800) polygon([
        [-h_bodenplatte -6500, 17800],
        [-h_bodenplatte -5200, 17800],
        [-h_bodenplatte -5200, 22200],
        [-h_bodenplatte -6500, 22200], 
        [-h_bodenplatte -9000, 20000]]);  
}
module dach_ost(){ 
    translate([0, 28300]) rotate([90, 90, 0]) linear_extrude(24100) polygon([
        [-h_bodenplatte -9400, 39000],
        [-h_bodenplatte -9400, 47500], 
        [-h_bodenplatte -14000, 43250]]);  
}
module dach_nord(){
    rotate([0, 90, 0]) linear_extrude(33400) polygon([
        [-h_bodenplatte -9400, 37200],
        [-h_bodenplatte -9400, 49600], 
        [-h_bodenplatte -14000, 43250]]);  
    translate([0, 49200]) rotate([90, 90, 0]) linear_extrude(6000) polygon([
        [-h_bodenplatte -11500, 14900],
        [-h_bodenplatte -9400, 14900],
        [-h_bodenplatte -9400, 19300],
        [-h_bodenplatte -11500, 19300], 
        [-h_bodenplatte -14000, 17100]]);  
}

module parking()translate([0, 2400, 0]){
    for (i=[500:stangen_x:35000]) translate([i, 0, 5000]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 2*stangen_y, 5000]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 3*stangen_y, 5000]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 5*stangen_y, 5000]) one_parking();
    for (i=[500:stangen_x:33000]) translate([i, 6*stangen_y, 5000]) one_parking();
    for (i=[500:stangen_x:33000]) translate([i, 8*stangen_y, 5000]) one_parking();
    for (i=[3500:stangen_x:37000]) translate([i, 0, 5000]) one_parking();
    for (i=[3500:stangen_x:37000]) translate([i, 2*stangen_y, 5000]) one_parking();
    for (i=[3500:stangen_x:37000]) translate([i, 3*stangen_y, 5000]) one_parking();
    for (i=[3500:stangen_x:37000]) translate([i, 5*stangen_y, 5000]) one_parking();
    for (i=[3500:stangen_x:33000]) translate([i, 6*stangen_y, 5000]) one_parking();
    for (i=[3500:stangen_x:33000]) translate([i, 8*stangen_y, 5000]) one_parking();
    
    };
module one_parking() color(color_parking) cube([2500, 5000, 1000]);

module room_text(text, size = 50, placement, height)
    color(color_text) linear_extrude(height) translate(placement) text(text, size=size);