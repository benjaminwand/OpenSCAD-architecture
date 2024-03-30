/*
* Treppen einzeichnen
    * "$komplexe treppe" variable
    * modul importrieren
* Tonnengewölbe nord
* Tonnengewölbe ost
* Schnitt
    * Fundament einzeichnen
    * Schnitt(e) in Grundriss einzeichnen
* Fensterhöhe überprüfen
* Aussenwand stärken überprüfen
* alles exportieren
* Rohbau anlegen
    * Fahrstuhl
    * Dachluken
    * mode anlegen
* Wie viele quadratmeter pro person sind das?
* Farben Treppenhausfenster
* Dachfenster Farben anpassen nach öffentlich und privat
*/
/*
öffentlich räume:
unten
    * in dem Sinne wie das Wohnzimmer vieler Leute ein repräsentativer Raum ist in dem Menschn die Gelegenheit bekommen ihre kulturelle Identität auszudrücken, fände ich es gut wenn der "öffentliche" Raum am Park ein Raum ist der die Kultur der Bewohner*innen ausdrückt
    * es ist auch ein Raum in den bei Bedarf alle rein passen
    * wenn niemandem etwas einfällt, wird es ein Restaurant, Essen braucht immer mal jemand, sowohl die Personen im Haus als auch Gäste der Sportstätten

Hof
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
z_cutheight = 6000;
x_cutheight = 15500;
doorshigh = 0;          // einfacher zeichnen mit ober raus stehenden tueren
e = 5;                  // epsilon-wert, nummerisch in mm, zum Rendern 0 machen
eg = 1;
og1 = 1;
og2 = 1;
og3 = 1;
og4 = 1;
dach = 1;
ally = 1;
grundstueck = 0;        // Grundstücksgrenzen anzeigen
walls = 0;
openings_implied = 0;
fast_curves = 0;        // macht Vorschau schneller, zum Rendern 0 machen
metall = 0;             // Zäunchen
parking = 1;
color_index = 0;
storey_label = 0;
text = 0;               // Text in Innenräumen
line_width = 100;       // for drawing skylights on floor plans
barrel_vault = 1;
skylights = 1;

/*
0 komplettes Haus                   mit Innenräumen
1 Schnitt Schnitt-Höhe z_cutheight  mit Innenräumen
2 Innenhof                          ohne innenräume
3 Ally Haus                         ohne innenräume
4 hohes Haus                        ohne innenräume
5 Haus Ost                          ohne innenräume
6 Haus Nord und Nordost             ohne innenräume
7 komplettes Haus Ansicht außen     ohne innenräume
8 Haus in Nord-Süd-Richtung durchgeschnitten mit Innenräumen
9 Schnitt in Nord-Süd-Richtung, Projektion
*/
mode = 8;


{// Farben
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
color_skylight_floorplan = "lightgrey";
color_cut = "#8F3985";}

{// Maße
h_bodenplatte = 5000;
d_bodenplatte = 300;
d_floor = 200;
railing = 1100;
dicke_saeule = 500;
stangen_x = 6600;           // Parkplatz Struktur
stangen_y = 5187;
stangen_y_neu = [2000, 15100, 37700, 48600];
schwelle = 5;
tree_placement = [
    [stangen_x * 1.25 + 100, stangen_y * 5.5 + 2000],
    [stangen_x * 2.25 + 100, stangen_y * 3.5 + 2000],
    [stangen_x * 3.25 + 100, stangen_y * 5.5 + 2000],
    [stangen_x * 4.25 + 100, stangen_y * 3.5 + 2000]];
storey_height_ally = 3300;
storey_height_high = 3300;
roof_thickness = 300;

// Geschosshöhen
floor_1 = h_bodenplatte;
floor_2 = floor_1 + d_floor + storey_height_high;
floor_3 = floor_2 + d_floor + storey_height_high;
floor_4 = floor_3 + d_floor + storey_height_high;

// Sky lights
{
placement_skylights_ally_middle = [[1800, 8800, 12100],[5000, 8800, 12100],[8000, 8800, 12100],[11000, 8800, 12100],[14000, 8800, 12100],[17000, 8800, 12100],[20000, 8800, 12100],
[23000, 8800, 12100],[26000, 8800, 12100],[29000, 8800, 12100],[32000, 8800, 12100],[35000, 8800, 12100],[38200, 8800, 12100]];
placement_skylights_ally_north = [[6000, 11200, 12000],[20000, 11200, 12000],[34000, 11200, 12000]];
placement_skylights_ally_south = [[12200, 6400, 12000],[27800, 6400, 12000]];

placement_skylights_ost_flur = [[40400, 8200, 18500],[40400, 12200, 18500],[40400,16200, 18500],[40500, 20200, 18500],[40400, 24500, 18500]];
placement_skylights_ost_mitte = [[43300, 4500, 19050],[43300, 24600, 19050],[43300, 27000, 19050]];

placement_skylights_nord_flur = [[3500, 43500, 19100],[7000, 43500, 19100],[10500, 43500, 19100],[14000, 43500, 19100],[17500, 43500, 19100],[21000, 43500, 19100],[24500, 43500, 19100],[28000, 43500, 19100],[31500, 43500, 19100]];
placement_skylights_nord_bad1= [[3500, 47500, 18600]];
placement_skylights_nord_bad2= [[3500, 39300, 18600]];
placement_skylights_nord_dachboden1= [[17500, 40800, 18900],[21000, 40800, 18900],[24500, 40800, 18900],[28000, 40800, 18900],[31500, 40800, 18900]];

placement_skylights_nord_dachboden2 = [[21000, 46300, 18850],[24500, 46300, 18850],[28000, 46300, 18850],[31500, 46300, 18850]];

diameter_skylight_south = 1200;
diameter_skylight_east = 900;
diameter_skylight_north = 900;
}}

// flow control
if (mode==0)                // komplettes Haus
    haus($doors = 1, $rooms=1, $staircase=1, $windows=1, $elevator=1, $complex_stairs=0);
else if (mode==1)           // Horizontalschnitt auf Höhe z_cutheight
    projection() {
        intersection(){
            translate([0, 0, z_cutheight * scale]) cube([20000, 20000, 0.1], center=true);
            haus($doors = 1, $rooms=1, $staircase=1, $windows=1, $elevator=1, $complex_stairs=1);
        };
    }
else if (mode==2)           // Innenhof
difference(){
    haus($doors = 0, $rooms=0, $staircase=0, $windows=0, $elevator=0, $complex_stairs=0);
    scale(scale) difference(){
        union(){
            scale([1, 1, 5]) hausform2500(2500 - e, 0);
            scale([1, 1, 5]) hausform3000(3000 - e, 0);
        };
        translate([0, 14500, 0])cube([39400, 1500, 4500]);
        translate([0, 37000, 0])cube([27000, 1500, 4500]);
    };
}
else if (mode==3)           // Ally Haus
intersection(){
    haus($doors = 0, $rooms=0, $staircase=0, $windows=1, $elevator=0, $complex_stairs=0);
    scale(scale) difference(){
        scale([1, 1, 5]) hausform2500(2500 - e, 0);
        translate([0, 14500, 0])cube([39400, 1500, 4500]);
    };
}
else if (mode==4)           // Hohes Haus
intersection(){
    haus($doors = 0, $rooms=0, $staircase=0, $windows=1, $elevator=0, $complex_stairs=0);
    scale(scale) difference(){
        scale([1, 1, 5]) hausform3000(2500 - e, 0);
        translate([0, 14500, 0])cube([39400, 1500, 4500]);
        translate([0, 37000, 0])cube([27000, 1500, 4500]);
    };
}
else if (mode==5)           // Haus Ost
intersection(){
    haus($doors = 0, $rooms=0, $staircase=0, $windows=1, $elevator=0, $complex_stairs=0);
    scale(scale) difference(){
        scale([1, 1, 10]) rotate([0, 0, 90])translate ([2000, -47000, 0]) cube([26300, 7600, 2100]);
        translate([0, 14500, 0])cube([39400, 1500, 4500]);
        translate([0, 37000, 0])cube([27000, 1500, 4500]);
    };
}
else if (mode==6)           // Haus Nord und Nordost
intersection(){
    haus($doors = 0, $rooms=0, $staircase=0, $windows=1, $elevator=0, $complex_stairs=0);
    scale(scale) difference(){
        scale([1, 1, 10]) hausform3000(2500 - e, 0);
        translate([0, 37000, 0])cube([27000, 1500, 4500]);
        scale([1, 1, 10]) rotate([0, 0, 90])translate ([2000, -47000, 0]) cube([26300, 7600, 2100]);
    };
}
else if (mode==7)                // komplettes Haus
    haus($doors = 0, $rooms=0, $staircase=0, $windows=1, $elevator=0, $complex_stairs=0);

else if (mode==8)
    difference(){
        haus($doors = 1, $rooms=1, $staircase=1, $windows=1, $elevator=1, $complex_stairs = 1);
        color(color_cut) translate([-10, 0, 0]) cube([x_cutheight * scale +10, 250, 200], center=false);
    }
else if (mode==9)
    rotate([0, 0, 90]) projection() {
        intersection(){
            translate([0, 0, -x_cutheight * scale]) cube([2000, 2000, 0.1], center=true);
            rotate([0, 90, 0]) haus($doors = 1, $rooms=1, $staircase=1, $windows=1, $elevator=1, $complex_stairs=0);
        };
    }

module haus($elevator)
//rotate([0, 0, -rot])
scale(scale)
//translate([-22500, -22000])
{
    if (grundstueck) grundstueck();
    difference(){
        union(){
            if (og1) grundplatte(d_bodenplatte);
            if (eg) for (x=[0:stangen_x:35000], y=stangen_y_neu)
                translate([x, y]) bodensaeule();
            eg_aussen();
            if (walls){
                if (og1) hausform3000(og2?d_floor + storey_height_high - e:1000, floor_1);
                if (og2) hausform3000(og3?d_floor + storey_height_high - e:1100, floor_2);
                if (og3) hausform3000(og4?d_floor + storey_height_high - e:1000, floor_3);
                if (og4) union(){
                    color(color_yard) hausform3000(d_floor -e, h_bodenplatte + 2*d_floor + 3*storey_height_high);
                    color(color_walls) {
                        rotate([0, 0, 90]) translate ([2000, -47000, floor_4]) cube([26300, 7600, dach?d_floor:1500]);
                        translate ([0, 37700, floor_4]) cube([33500, 11400, dach?d_floor:1500]);
                    };
                };

                if (og1 && ally) hausform2500(og2?d_floor + storey_height_ally - e:1000, floor_1);
                if (og2 && og3 && ally) dachform2500(floor_2);
                if (og2 && !og3 && ally) hausform2500(1000, floor_2);

                if (dach) dachform_ost(h_bodenplatte + 3*storey_height_high+ 2* d_floor);
                if (dach) dachform_nord(h_bodenplatte + 3*storey_height_high+ 2* d_floor);
            };
            if (og1) parking_barrel_vaults();
            if (og2 && og3 && ally && skylights) skylights_ally_outside();
            if (dach && skylights) skylights_ost_outside();
            if (dach && skylights) skylights_nord_outside();
        }
        raeume_innen($text=0);
        entrances($entrance_doors=1);

        for (i=tree_placement) translate(i) cylinder(3 * h_bodenplatte, 1000, 1000, center = true, $fn=fast_curves?10:30);
    }
    if (og2 && !og3 && mode==0 && skylights)
        skylight_in_floor_plan(diameter_skylight_south, concat(placement_skylights_ally_middle, placement_skylights_ally_north, placement_skylights_ally_south));
    if (og4 && !dach && mode==0 && skylights) {
        skylight_in_floor_plan(diameter_skylight_east, concat(placement_skylights_ost_flur, placement_skylights_ost_mitte));
        skylight_in_floor_plan(diameter_skylight_north, concat(placement_skylights_nord_flur, placement_skylights_nord_bad1, placement_skylights_nord_bad2, placement_skylights_nord_dachboden1, placement_skylights_nord_dachboden2));
        }
    if (text) raeume_innen($doors = 0, $rooms=0, $staircase=0, $windows=0, $text=1, $elevator=0);
    if ($complex_stairs) stairs();
    if (metall) metall();
    if (parking && eg) parking();
  //  translate([35400, 31500, 6000]) rotate([0, 0, 40]) cube([5700, 25000,18000], center=true);

};

if (color_index)
    translate([-250, 50, 0]){
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
if (storey_label)
    translate([-50, 10, 0]) color("black") {
        if (eg) text("EG");
        if (og1) text("OG1");
        if (og2) text("OG2");
        if (og3) text("OG3");
        if (og4) text("OG4");
    };

module grundstueck() scale([1000, 1000, 1])
    translate([-113.3608, 44.89835]) rotate([0, 0, rot])
    import("grundr2.stl"); // Grundriss 1:1000
module bodensaeule()
    color(color_pillars) cube([dicke_saeule, dicke_saeule, og1?h_bodenplatte - e:1000]);
module bad_barrierefrei()
    cube([2800, 2500, storey_height_ally]);
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
/*module opening_south_3000(x, z, x_pos, y_pos, z_pos)
    if (openings_implied)
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([x, 300, z]);
        translate([x_pos, y_pos + 400, z_pos]) cube([x, 300, z]);
    };*/
module opening_west_ally(y, z, x_pos, y_pos, z_pos)
    if (openings_implied)
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
        translate([x_pos + 400, y_pos, z_pos]) cube([300, y, z]);
    };
/*module opening_west_3000(y, z, x_pos, y_pos, z_pos)
    if (openings_implied)
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
    else {
        translate([x_pos, y_pos, z_pos]) cube([300, y, z]);
        translate([x_pos + 400, y_pos, z_pos]) cube([300, y, z]);
    };*/

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
    union(){
        if (og1 && ally) we_01_ally_innen();                // 5
        if (og2 && ally) we_02_ally_innen();                // 5
        if (og1 && ally) we_03_ally_innen();                // 5
        if (og2 && ally) we_04_ally_innen();                // 5

        if (og1) we_05(floor_1);                            // 4
        if (og1 && $windows) opening_ost_hof_1(floor_1);
        if (og2) we_06(floor_2);                            // 5
        if (og2 && $windows) opening_ost_hof_unten(floor_2);
        if (og3) we_06(floor_3);                            // 5
        if (og3 && $windows) opening_ost_hof_unten(floor_3);
        if (og4) we_09(floor_4);                            // 4

        if (og2) we_08_paare(floor_2);                      // 4
        if (og3) we_08_paare(floor_3);                      // 4
        if (og4) we_08_paare(floor_4);                      // 4
        if (og2) family(floor_2);                           // 7
        if (og3) family(floor_3);                           // 7
        //-> 60, davon 20 explizit barrierefrei und 8 Kinder
    };

    if ($staircase && mode!=8 && mode!=9)
        color(color_access) {       // Treppenhaus süd + Probenraum
            translate ([18000, 2400, 0]) cube([4000, 5200, floor_4]); // Treppenhaus süd
            if (og1)        // Gang zum Hof am treppenhaus süd
                translate ([19000, 7600, h_bodenplatte]) cube([2000, 7600, storey_height_ally]); 
            if (og2) // Treppenhaus Süd
                translate ([19000, 7600, floor_2]) cube([2000, 2000, storey_height_ally]); 
        };
    if ($elevator && mode!=8 && mode!=9) 
        color(color_elevator) translate ([19067.5, 3467.5, 0])
            cube([1865, 2845, floor_4]);            // Fahrstuhl süd

    if ($windows && mode!=8 && mode!=9) 
        {opening_south_ally(2000, 1300, 19000, 1850, h_bodenplatte -1000);
        opening_south_ally(2000, 1300, 19000, 1850, h_bodenplatte + 2500);}

    if ($rooms && og2 && mode!=8 && mode!=9) 
    color(color_public) translate([0, 0, floor_2])    // Musikraum
        {translate ([19100, 9900, 0]) cube([1800, 5300, storey_height_ally]); // Musik Proberaum
        if ($doors) translate ([19500, 9500, 0]) tuer_barrierefrei(); // Tür Musik Proberaum
        };
    if ($windows) color(color_public) rotate([0, 0, 180])
        opening_south_ally(1200, 1100, -20600, -15750, h_bodenplatte + storey_height_ally + d_bodenplatte + 700);
    if ($text && og2) rotate([0, 0, -90])
        translate([0, 0, h_bodenplatte + storey_height_ally + d_floor])
            room_text("Musik", size = 700, placement=[-12800, 19100, 0]);

    if ($staircase && mode!=8 && mode!=9) color(color_access) {                   // Treppenhaus ost
        translate ([41400, 25600, 0])
            cube([5200, 2300, 4* storey_height_high + h_bodenplatte+3*d_floor]);
        translate ([0, 0, h_bodenplatte]) linear_extrude(storey_height_high)
            polygon([[41500, 27900], [41500, 26700], [39700, 26700], [37700, 25100],[36900, 26100], [39200, 27900]]);
        translate ([39800, 26700, 3* storey_height_high + h_bodenplatte + 3*d_floor])
            cube([1600, 1200, storey_height_high]);
        };

    if ($windows) color(color_public)
        for (z = [h_bodenplatte - 300, h_bodenplatte - 300 +storey_height_high, h_bodenplatte - 300 + 2*storey_height_high, h_bodenplatte - 300 + 3*storey_height_high])
            opening_3000(1200, 1500, 47150, 26200, z, 90);

    if ($staircase) color(color_access) {        // Treppenhaus nord
        difference(){
        translate ([15100, 43500, 0]) cube([4000, 5200, floor_4+storey_height_high]); // Treppenhaus Nord
        cube([1865, 2845, floor_4+5]); 
        }
        if (og1)                   // Gang zum Hof am treppenhaus nord
            translate ([16000, 38100, h_bodenplatte]) cube([2000, 7600, storey_height_high]);
        };

    if ($elevator) color(color_elevator) translate ([16200, 44700, 0])
        cube([1865, 2845, floor_4+5]);            // Fahrstuhl nord

    if (og1)                    // Gemeinschaftsräume nordwest
        union(){
        color(color_public) translate([0, 0, floor_1]) {
            if ($rooms){
                translate ([400, 38100, 0]) cube([4500, 10600, storey_height_high]); // werkstatt
                translate ([10100, 38100, 0]) cube([5700, 5200, storey_height_high]); // basteln/textil
                translate ([5100, 38100, 0]) cube([4800, 10600, storey_height_high]); // fahrradschuppen
                translate ([10100, 43500, 0]) cube([4800, 5200, storey_height_high]); // bibiothek
            };

            if ($doors){
                translate ([14200, 43600, 0]) tuer_barrierefrei(); // bibiothek
                translate ([15500, 40300, 0]) tuer_barrierefrei(); // basten/textil
            };
        };

            if ($text) translate([0, 0, h_bodenplatte]) {
               room_text("Werkstatt", size = 700, placement=[400, 38100, 0]);
               room_text("Fahrräder", size = 700, placement=[5100, 38100, 0]);
               room_text("Bibliothek", size = 700, placement=[10100, 43500, 0]);
               room_text("Basteln/Textil", size = 700, placement=[10100, 38100, 0]);
            }
        };

    if (og1)            // Gemeinschaftsräume nordost
        union(){
        color(color_public) translate([0, 0, floor_1]) {
            if ($rooms && mode!=8 && mode!=9){
                union(){
                translate ([18200, 38100, 0]) cube([7500, 5200, storey_height_high]);
                translate ([19300, 38100, 0]) cube([2800, 6900, storey_height_high]);
                translate ([19300, 38100, 0]) cube([6100, 6200, storey_height_high]);} // Spiele
                translate ([25900, 38100, 0]) cube([7100, 6200, storey_height_high]); // Coworking space3
                linear_extrude(storey_height_high) polygon([[41400, 28100], [33000, 38100],[33000, 41000], [26500, 38500], [36700, 26300], [39000, 28100]]);  // Coworking space3 schräg

                translate ([19300, 45200, 0]) cube([2800, 3500, storey_height_high]); // Gästezimmer 1
                translate ([22300, 44500, 0]) cube([2300, 4200, storey_height_high]); // Gästezimmer 2
                translate ([24800, 43100, 0]) cube([900, 3200, storey_height_high]);  // Flur zu Bad 1
                translate ([25900, 44500, 0]) cube([2500, 1800, storey_height_high]);     // WC
                translate ([24800, 46500, 0]) cube([3600, 2200, storey_height_high]);     // Gäste Bad
                translate ([28600, 44500, 0]) cube([2100, 4200, storey_height_high]); // Gästezimmer 3
                translate ([30900, 44500, 0]) cube([2100, 4200, storey_height_high]); // Gästezimmer 4
            }

            if ($doors && mode!=8 && mode!=9){
                translate ([18400, 43600, 0]) tuer_barrierefrei();  // Treppenhaus Nord
                translate ([38500, 27000, 0]) rotate([0, 0, 38])
                    tuer_barrierefrei(); // Treppenhaus Ost
                translate ([25400, 43000, 0]) tuer_barrierefrei();  // Spiele/Coworking
                translate ([19400, 44800, 0]) tuer_barrierefrei();  // Gästezimmer 1
                translate ([22400, 44000, 0]) tuer_barrierefrei();  // Gästezimmer 2
                translate ([26000, 44200, 0]) tuer_barrierefrei();  // WC
                translate ([24850, 46200, 0]) tuer_innen();         // Gäste Bad
                translate ([28700, 44000, 0]) tuer_innen();         // Gästezimmer 3
                translate ([31000, 44000, 0]) tuer_innen();         // Gästezimmer 4
            }

            if ($windows){
                for (x = [ 5500, 10500, 13000, 19800, 23300])  // zum Hof
                    opening_3000(1200, 1100, x, 37550, 800);

                opening_3000(1100, 1100, 26400, 37600, 800, 310);   // zum Hof schräg
                opening_3000(1200, 1100, 27850, 35900, 800, 310);
                opening_3000(1200, 1100, 29500, 33900, 800, 310);
                opening_3000(1200, 1100, 32100, 30900, 800, 310);
                opening_3000(1200, 1100, 34300, 28100, 800, 310);

            if (mode!=8 && mode!=9){
                for (x = [7000, 9000, 12000, 14000, 21000, 23800, 27200, 30100, 32600])
                    opening_3000(1200, 1100, x, 49250, 800, 180);   // zum Sportplatz

                opening_3000(1200, 1100, 41600, 28800, 800, 130);  // zum Sportplatz

                for (x = [21000, 23800, 27200, 30100, 32600])
                    opening_3000(1200, 1100, x, 49250, 800, 180);   // zum Sportplatz
                for (y = [42600, 40600, 38600])
                    opening_3000(1200, 1100, 33650, y, 800, 90);

                opening_3000(1200, 1100, 37500, 33650, 800, 130);}


                for (y = [42000, 44000, 46000])
                    opening_3000(1200, 1500, -150, y, 800, 270);   // zur Durchfahrt
                for (y = [39800, 48000])
                    opening_3000(900, 1100, -150, y, 800, 270);   // zur Durchfahrt

                // Treppenhaus fenster
                for (z = [ -300, -300 +storey_height_high, -300 + 2*storey_height_high,  - 300 + 3*storey_height_high])  // nach Norden
                    opening_3000(1200, 1500, 17700, 49250, z, 180);
            }
        };

            if ($text) translate([0, 0, h_bodenplatte]) {
               room_text("Spiele/Spielen", size = 700, placement=[18200, 38100, 0]);
               room_text("Coworking", size = 700, placement=[29900, 34800, 0]);
               room_text("Teeküche", size = 700, placement=[28500, 41000, 0]);

               room_text("Gast", size = 700, placement=[19300, 45200, 0]);
               room_text("Gast", size = 700, placement=[22300, 44500, 0]);
               room_text("Gast", size = 700, placement=[28600, 44500, 0]);
               room_text("Gast", size = 700, placement=[30900, 44500, 0]);

               room_text("Bad", size = 700, placement=[24800, 46500, 0]);
               room_text("WC", size = 700, placement=[25900, 44500, 0]);
            }
        };


    if (og4)
        translate([0, 0, floor_4])
            union(){                   // Wäscheboden nordost oben
                color(color_public) {
                    if ($rooms){
                        translate ([15100, 38100, 0]) cube([7500, 6000, storey_height_high]);
                        translate ([19300, 38100, 0]) cube([13800, 10600, storey_height_high]);
                    }

                    if($windows){
                        for (x = [ 16400, 19800, 23300, 27000])        // zum Hof
                            opening_3000(1200, 1100, x, 37550, 800 );

                        for (x = [21000, 23800, 27200, 30100, 32600])  // nach Norden
                            opening_3000(1200, 1100, x, 49250, 800, 180);   // zum Sportplatz
                        for (y = [42600, 40600, 38600])                 // nach Osten
                            opening_3000(1200, 1100, 33650, y, 800, 90);
                    };
                };
                if ($text) color(color_text)
                   room_text("Wäscheboden", size = 700, placement=[15200, 38100, 0]);
            };


    if (eg) eg_innen();         // öffentliche Räume
}

module we_01_ally_innen() a11y_west(floor_1);
module we_02_ally_innen() a11y_west(floor_2);
module we_03_ally_innen() a11y_east(floor_1);
module we_04_ally_innen() a11y_east(floor_2);

module a11y(h) translate([0, 500]){
    if ($rooms) color(color_private) intersection(){
        union(){
            translate ([6600, 1900, h]) cube([4000, 5200, storey_height_ally]);   // Süd
            translate ([10800, 1900, h]) bad_barrierefrei();
            translate ([10800, 4600, h]) bad_barrierefrei();
            translate ([13800, 1900, h]) cube([4000, 5200, storey_height_ally]);

            {translate ([3000, 7300, h]) cube([15800, 2000, storey_height_ally]); // Flur
            translate ([16000, 7300, h]) cube([2800, 4700, storey_height_ally]);}
            translate ([400, 7300, h]) cube([2400, 2000, storey_height_ally]);    // Gäste Toilette
            translate ([400, 1900, h]) cube([6000, 5200, storey_height_ally]);    // Küche

            {translate ([400, 9500, h]) cube([4000, 5200, storey_height_ally]);   // Nord
            translate ([4600, 9500, h]) bad_barrierefrei();
            translate ([4600, 12200, h]) bad_barrierefrei();
            translate ([7600, 9500, h]) cube([4000, 5200, storey_height_ally]);
            translate ([11800, 9500, h]) cube([4000, 5200, storey_height_ally]);
            translate ([16000, 12200, h]) bad_barrierefrei();}
        };
        if (barrel_vault) inner_ally_vault(h);
    };

    if ($doors) color(color_private) {
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

    if ($windows) color(color_private) {
        for (x = [900, 2600, 4300, 7000, 9000, 11700, 14300, 16200])
            opening_south_ally(1200, 1100, x, 1350, h + 800);
        for (x = [-2000, -3900, -6600, -9200, -11100, -13500, -15200, -18000])
            rotate([0, 0, 180]) opening_south_ally(1200, 1100, x, -15250, h + 800);
    }
}

module a11y_east(h) {
    if (mode!=8 && mode!=9) translate([40000, 0, 0]) mirror([1, 0, 0]) a11y(h);
    if ($text) color(color_text) translate([0, 0, h])  {
        room_text("Bad", size = 700, placement=[10800, 2300, 0]);
        room_text("Bad", size = 700, placement=[10800, 5100, 0]);

        room_text("Bad", size = 700, placement=[4600, 10000, 0]);
        room_text("Bad", size = 700, placement=[4600, 12900, 0]);
        room_text("Bad", size = 700, placement=[16000, 12900, 0]);

        room_text("Küche", size = 700, placement=[500, 2300, 0]);
        room_text("WC", size = 700, placement=[500, 7800, 0]);
    }
}
module a11y_west(h) {
    a11y(h);
    ally_windows_west(h);
    if ($text) color(color_text) translate([0, 0, h])  {
        room_text("Bad", size = 700, placement=[26500, 2300, 0]);
        room_text("Bad", size = 700, placement=[26500, 5100, 0]);

        room_text("Bad", size = 700, placement=[33000, 10000, 0]);
        room_text("Bad", size = 700, placement=[33000, 12900, 0]);
        room_text("Bad", size = 700, placement=[21500, 12900, 0]);

        room_text("Küche", size = 700, placement=[33800, 2300, 0]);
        room_text("WC", size = 700, placement=[37300, 7800, 0]);
    }

};
module ally_windows_west(h)
    if ($windows) color(color_private)
        for (y = [2500, 4200, 8200, 12200, 13900])
            opening_west_ally(1200, 1100, -200, y, h + 800);

module we_05(h) translate ([0,0, h]){
    if ($rooms && mode!=8 && mode!=9) color(color_private) {
        translate ([39800, 6300, 0]) cube([1200, 20200, storey_height_high]);     // Flur
        translate ([40000, 25600, 0]) cube([1200, 900, storey_height_high]);      // Flur
        linear_extrude(3000) polygon([[39800, 26500], [37800, 24900], [39900, 22400]]); // Genkan

        translate ([41200, 6300, 0]) cube([5400, 3800, storey_height_high]);
        translate ([41200, 10300, 0]) cube([5400, 3800, storey_height_high]);
        translate ([41200, 14300, 0]) cube([5400, 3800, storey_height_high]);
        translate ([41200, 18300, 0]) cube([5400, 3800, storey_height_high]);

        translate ([41200, 22300, 0]) cube([5400, 1400, storey_height_high]);     // Bad Vorraum
        translate ([41200, 22300, 0]) cube([1200, 1900, storey_height_high]);
        translate ([42600, 23900, 0]) cube([1800, 1500, storey_height_high]);    // Duschraum
        translate ([44600, 23900, 0]) cube([2000, 1500, storey_height_high]);    // Wannenraum
        translate ([41200, 24400, 0]) cube([1200, 1000, storey_height_high]); // Toilette
        translate ([39800, 2400, 0]) cube([6800, 3700, storey_height_high]);      // Küche / Wohnen
    }

    if ($doors && mode!=8 && mode!=9) color(color_private) {
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
    };

    if ($windows && mode!=8 && mode!=9) color(color_private) {
    for (y = [4700, 6700, 8700, 10700, 12700, 14700, 16700, 18700, 20700]) // Zimmer
        opening_3000(1200, 1100, 47150, y, 800, 90);
    for (y = [ 22500, 24100])                                   // Bad
        opening_3000(1000, 1100, 47150, y, 800, 90);
    for (x = [ 40400, 42700, 45000])                                // Küche
        opening_3000(1200, 1100, x, 1850, 800);
    };

    if ($text) color(color_text) {
        room_text("Küche", size = 700, placement=[40000, 2300, 0]);
        room_text("WC", size = 500, placement=[41100, 24400, 0]);
        room_text("Dusche", size = 350, placement=[42600, 24000, 0]);
        room_text("Wanne", size = 400, placement=[44700, 24000, 0]);
        room_text("Bad-Vorraum", size = 500, placement=[41100, 22400, 0]);
    }
};
module opening_ost_hof_unten(z)
    if($windows) color(color_private) {
        for (y = [18000, 20700])                                   // Flur
            opening_3000(1200, 1100, 39250, y, z+800, -90);
            opening_3000(1200, 1100, 38000, 23800, z+800, 310);      // Genkan

            opening_3000(1200, 1100, 34300, 28100, z+800, 310); // Zimmer
            opening_3000(1200, 1100, 36100, 26100, z+800, 310);

            opening_3000(1200, 1100, 41600, 28800, z+800, 130);  // zum Sportplatz
    }

module opening_ost_hof_1(z) if($windows) color(color_private) {
    for (y = [18000, 20700])                                   // Flur
        opening_3000(1200, 1100, 39250, y, z+800, -90);
        opening_3000(1200, 1100, 38000, 23800, z+800, 310);      // Genkan
}

module we_06(h) translate ([0,0, h]){
    we_05(0);
    if (mode!=8 && mode!=9){
        if ($rooms) color(color_private)  // Zimmer Nord
            linear_extrude(3000) polygon([[41200, 26700],[41200, 28100],[41400, 28100],[38000, 32100], [34350, 29000], [37650, 25100], [39700, 26700]]);

        if ($doors) color(color_private) translate ([40000, 26300, 0]) tuer_innen();
    }
};

module we_09(h) translate ([0,0, h]){
    difference(){
        we_05(0);
        translate([34800, 22000]) cube([5000, 5000, 5000]);
    }
};

module we_08_paare(h) translate([0, 0, h]){
    if ($rooms) color(color_private) {
        translate ([400, 40200, 0]) cube([4500, 6400, storey_height_high]);       // Küche
        translate ([400, 46800, 0]) cube([4500, 1900, storey_height_high]);       // Bad
        translate ([400, 38100, 0]) cube([4500, 1900, storey_height_high]);       // Bad
        {translate ([5100, 43100, 0]) cube([9800, 900, storey_height_high]);      // Flur
        translate ([13400, 42000, 0]) cube([1500, 1100, storey_height_high]);}    // Genkan
        {translate ([9800, 38100, 0]) cube([3400, 4800, storey_height_high]);
        translate ([9800, 38100, 0]) cube([5100, 3700, storey_height_high]);}
        translate ([5100, 38100, 0]) cube([4500, 4800, storey_height_high]);
        {translate ([10100, 44200, 0]) cube([3500, 4500, storey_height_high]);
        translate ([10100, 44600, 0]) cube([4800, 4100, storey_height_high]);}
        translate ([5100, 44200, 0]) cube([4800, 4500, storey_height_high]);
    }

    if($doors) color(color_private) {
        translate ([4800, 39000, 0]) tuer_innen();
        translate ([4800, 47000, 0]) tuer_innen();
        translate ([4800, 43150, 0]) tuer_innen();                  // Küche
        translate ([6000, 42700, 0]) tuer_innen();
        translate ([11000, 42700, 0]) tuer_innen();
        translate ([8000, 43700, 0]) tuer_innen();
        translate ([12000, 43700, 0]) tuer_innen();
        translate ([13800, 43600, 0]) scale([2, 1, 1])tuer_innen();  // Wohnungstür
        translate ([9500, 45150, 0]) tuer_innen();
        translate ([9500, 39000, 0]) tuer_innen();
    }

    if($windows) color(color_private) {
        for (x = [ 5500, 7800, 10500, 13000])               // zum Hof
            opening_3000(1200, 1100, x, 37550, 800);
        for (x = [7000, 9000, 12000, 14000])
            opening_3000(1200, 1100, x, 49250, 800, 180);   // zum Sportplatz
        for (y = [42000, 44000, 46000])
            opening_3000(1200, 1500, -150, y, 800, 270);    // zur Durchfahrt
        for (y = [39800, 48000])
            opening_3000(900, 1100, -150, y, 800, 270);     // zur Durchfahrt
    }

    if ($text) color(color_text) {
       room_text("Bad", size = 700, placement=[400, 38100, 0]);
       room_text("Küche", size = 700, placement=[400, 40300, 0]);
       room_text("Bad", size = 700, placement=[400, 47000, 0]);
    }
};

module family(h) {
    if ($rooms) color(color_private) {
        if (mode!=8 && mode!=9)
        {translate ([22300, 44500, h]) cube([3400, 4200, storey_height_high]);    // Eltern Paar
        translate ([19300, 45200, h]) cube([6400, 3500, storey_height_high]);
        translate ([28600, 44500, h]) cube([4500, 4200, storey_height_high]);    // Eltern Single
        translate ([25900, 44500, h]) cube([2500, 1800, storey_height_high]);     // Bad
        translate ([25900, 46500, h]) cube([2500, 2200, storey_height_high]);}     // Bad

        translate ([19300, 43100, h]) cube([10700, 1200, storey_height_high]);   // Flur
        translate ([19300, 43100, h]) cube([2800, 1900, storey_height_high]);
        translate ([19300, 42700, h]) cube([900,1900, storey_height_high]);
        translate ([18200, 42400, h]) cube([2000,900, storey_height_high]);

        translate ([15100, 38100, h]) cube([2900, 5200, storey_height_high]);     // Kinderzimmer
        if (mode!=8 && mode!=9)
        {translate ([18200, 38100, h]) cube([3000, 4100, storey_height_high]);
        translate ([20400, 38100, h]) cube([1500, 4800, storey_height_high]);
        translate ([22100, 38100, h]) cube([3300, 4800, storey_height_high]);
        translate ([25600, 38100, h]) cube([3300, 4800, storey_height_high]);
        translate ([27600, 37000, h]) rotate([0, 0, 40]) cube([1700, 1800, storey_height_high]);

        translate ([30200, 38100, h]) cube([2900, 6200, storey_height_high]);     // Wohnzimmer
        translate ([29100, 38100, h]) cube([1200, 4800, storey_height_high]);

        translate ([0, 0, h]) linear_extrude(storey_height_high) polygon([[35450, 35200], [33100, 38000],[33100, 41000], [29100, 38100], [29100, 38000], [27700, 36850], [31800, 32100]]);        // Küche
        translate([34200, 29200, h]) rotate([0, 0, 40]) cube([4800, 3500, storey_height_high]);} // Kinderbad

     }
    if ($doors) color(color_private) {
        translate ([18500, 43600, h]) tuer_barrierefrei();     // Wohnungstür
        translate ([17500, 42450, h]) tuer_innen();
        translate ([20500, 42200, h]) tuer_barrierefrei();
        translate ([22500, 42200, h]) tuer_barrierefrei();
        translate ([27500, 42200, h]) tuer_barrierefrei();
        translate ([24000, 44000, h]) tuer_barrierefrei();
        translate ([28800, 44000, h]) tuer_barrierefrei();
        translate ([28000, 45400, h]) tuer_innen();
        translate ([25500, 46600, h]) tuer_innen();
        translate ([29700, 43200, h]) tuer_barrierefrei();
        translate ([32500, 32000, h]) rotate([0, 0, 40]) tuer_barrierefrei();     // Bad
    };


    if($windows) color(color_private) {
        for (x = [ 16400, 19800, 23300])        // zum Hof
            opening_3000(1200, 1100, x, 37550, 800 + h);
        opening_3000(1100, 1100, 26400, 37600, h+800, 310);
        opening_3000(1200, 1100, 27850, 35900, h+800, 310);
        opening_3000(1200, 1100, 29500, 33900, h+800, 310);
        opening_3000(1200, 1100, 32100, 30900, h+800, 310);

        if (mode!=8 && mode!=9){
        for (x = [21000, 23800, 27200, 30100, 32600])
            opening_3000(1200, 1100, x, 49250, h+800, 180);   // zum Sportplatz
        for (y = [42600, 40600, 38600])
            opening_3000(1200, 1100, 33650, y, h+800, 90);

        opening_3000(1200, 1100, 37500, 33650, h+800, 130);}
    };

    if ($text) color(color_text) translate([0, 0, h]) {
        room_text("Kind", size = 700, placement=[15300, 38100, 0]);
        room_text("Kind", size = 700, placement=[18400, 38100, 0]);
        room_text("Kind", size = 700, placement=[22400, 38100, 0]);
        room_text("Kind", size = 700, placement=[25800, 38100, 0]);

        room_text("Eltern-Paar", size = 700, placement=[19400, 45100, 0]);
        room_text("Eltern-", size = 700, placement=[28800, 45700, 0]);
        room_text("Single", size = 700, placement=[28800, 44700, 0]);

        room_text("Bad", size = 700, placement=[26000, 44700, 0]);
        room_text("Bad", size = 700, placement=[26000, 46700, 0]);

        room_text("Küche", size = 700, placement=[28300, 36100, 0]);
        room_text("Bad", size = 700, placement=[32500, 31200, 0]);
    }
}

module eg_innen() if (mode!=8 && mode!=9){          // öffentlicher Raum
    if ($rooms) color(color_full_public){
        translate ([39900, 2400, 0]) cube([6700, 22900, h_bodenplatte - d_bodenplatte]);
        translate ([39900, 25200, 0]) cube([1200, 2700, h_bodenplatte - d_bodenplatte]);
    };
    if ($windows) color(color_full_public) {
    for (y = [4700, 6700, 8700, 10700, 12700, 14700, 16700, 18700, 20700])
        opening_3000(1200, 1500, 47150, y, 800, 90);
    for (y = [ 22500, 24100])
        opening_3000(1000, 1500, 47150, y, 800, 90);
    for (x = [ 40400, 45000])                                // zur Straße
        opening_3000(1200, 1500, x, 1850, 800);
    };
    if($text)
        room_text("Öffentlich", placement=[39900, 2500, 0]);
};

module eg_aussen() color(color_walls) {
    translate ([39500, 2000, 0]) cube([7500, 26300, og1?h_bodenplatte - d_bodenplatte - e:1000]);
    if (eg || og1 || og2 || og3 || og4)
        translate ([14700, 43100, 0]) cube([4800, 6000, og1?h_bodenplatte - d_bodenplatte -e:1000]);
    if (eg) 
        {translate ([13600, stangen_y_neu[3], 0]) cube([1100, dicke_saeule, og1?h_bodenplatte - d_bodenplatte - e:1000]);
        translate ([19300, stangen_y_neu[3], 0]) cube([1000, dicke_saeule, og1?h_bodenplatte - d_bodenplatte - e:1000]);
        }
    if (eg || og1 || og2)
        translate ([17600, 2000, 0]) cube([4800, 6000, og1?h_bodenplatte - d_bodenplatte - e:1000]);
}

module entrances()
if ($entrance_doors){
    if (eg){
        entrance(1000, 2000, 19500, 1900, 0);                   // Eingang Süd
        entrance(1000, 2000, 47100, 26200, 0, 90);              // Eingang Ost
        entrance(1000, 2000, 17500, 49200, 0, 180);             // Eingang Nord
        entrance(1200, 2300, 42700, 1900, 0);                   // Eingang Restaurant
    }
    if (og1){
        entrance(1000, 2000, 20500, 15700, floor_1, 180);   // Hof Süd
        entrance(1000, 2000, 16500, 37600, floor_1);        // Hof Nord
        entrance(1000, 2000, 36500, 25600, floor_1, -50);   // Hof Ost
        entrance(1000, 2000, 2100, 37600, floor_1);         // Werkstatt
        entrance(1000, 2000, 7900, 37600, floor_1);         // Fahrradschuppen
        entrance(1000, 2000, 21500, 37600, floor_1);        // Hof Spiele
    }
    if (og4)
        entrance(1000, 2000, 39300, 27800, floor_4, 270);   // Dachterasse Ost
        entrance(1000, 2000, 30000, 37600, floor_4);        // Dachterasse Nord
};

module grundplatte(d)
    color(color_yard) translate ([0, 0, h_bodenplatte-d]) linear_extrude(d)
        polygon([[0, 2000], [47000, 2000], [47000, 28300], [41800, 28300], [33500, 38200],[33500, 49100],[0, 49100]]);

module hausform3000(d, h) color(color_walls)
    translate ([0, 0, h]) linear_extrude(d)
        polygon([[47000, 2000], [47000, 28300], [41800, 28300], [33500, 38200], [33500, 49100],[0, 49100], [0, 37700], [26500, 37700], [39400, 22300], [39400, 2000]]);
module hausform2500(d, h) color(color_walls)
    translate ([0, 2000, h]) cube([39400, 13600, d]);

module dachform2500(h) color(color_walls)
union(){
    translate ([0, 2000, h]) cube([39400, 13600, 2000]);
    translate([-e, 2000+13600/2, h + 2000+d_floor])
        resize([39400+2*e, 13600, storey_height_ally*2- 2000*2+roof_thickness*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:30);
}

module dachform_ost(h) color(color_walls)
rotate([0, 0, 90]) union(){
    translate ([2000, -47000, h]) cube([26300, 7600, 2100]);
    translate([2000-e, -50000+13600/2, h + 2000+d_floor])
        resize([26300+2*e, 7600, storey_height_ally*2- 2000*2+roof_thickness*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:50);
}

module dachform_nord(h) color(color_walls)
union(){
    translate ([0, 37700, h]) cube([33500, 11400, 2200]);
    translate([-e, 37700+11400/2, h + 2000+d_floor])
        resize([33500+2*e, 11400, storey_height_ally*2- 2000*2+roof_thickness*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:30);
}

module inner_ally_vault(h){
    translate ([0, 1900, h]) cube([39400, 12800, 2000]);
    translate([-e, 1500+13600/2, h + 2000])
        resize([39400+2*e, 12800, storey_height_ally*2- 2000*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:30);
};

module inner_ost_vault(h){
rotate([0, 0, 90]) union(){
    translate ([2000, -46900, h]) cube([26300, 6800, 2100]);
    translate([2000-e, -49500+13600/2, h + 2000])
        resize([26300+2*e, 6800, storey_height_ally*2- 2000*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:50);
}};

module inner_ord_vault(h){
union(){
    translate ([0, 37600, h]) cube([33500, 10600, 2200]);
    translate([-e, 37200+11400/2, h + 2000])
        resize([33500+2*e, 10600, storey_height_ally*2- 2000*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:30);
}};

module skylight_ally() resize([diameter_skylight_south, diameter_skylight_south, 500])
    sphere(1, $fn=fast_curves?10:30);
module skylights_ally_outside() {
    for(i=placement_skylights_ally_middle) translate(i) skylight_ally();
    for(i=placement_skylights_ally_north) translate(i) rotate([-5, 0, 0]) skylight_ally();
    for(i=placement_skylights_ally_south) translate(i) rotate([5, 0, 0]) skylight_ally();
};

module skylight_ost() resize([diameter_skylight_east, diameter_skylight_east, 500])
    sphere(1, $fn=fast_curves?10:30);
module skylights_ost_outside() {
    for(i=placement_skylights_ost_flur) translate(i) rotate([0, -25, 0]) skylight_ost();
    for(i=placement_skylights_ost_mitte) translate(i) skylight_ost();
    };

module skylight_nord() resize([diameter_skylight_north, diameter_skylight_north, 500])
    sphere(1, $fn=fast_curves?10:30);
module skylights_nord_outside() {
    for(i=placement_skylights_nord_flur) translate(i) skylight_nord();
    for(i=placement_skylights_nord_bad1) translate(i) rotate([-15, 0, 0]) skylight_nord();
    for(i=placement_skylights_nord_bad2) translate(i) rotate([15, 0, 0]) skylight_nord();
    for(i=placement_skylights_nord_dachboden1) translate(i) rotate([10, 0, 0])skylight_nord();
    for(i=placement_skylights_nord_dachboden2) translate(i) rotate([-10, 0, 0])skylight_nord();
}

module skylight_in_floor_plan(diameter, placement)
    color(color_skylight_floorplan) for (i=placement) translate(i)
difference(){
    cylinder(5, diameter/2, diameter/2, true, $fn=fast_curves?10:30);
    cylinder(10, diameter/2-line_width, diameter/2-line_width, true, $fn=fast_curves?10:30);
}

module metall() color(color_metal){
    for (i=tree_placement) translate(i) baumzaun();
    gerader_zaun(22500, [0, 15200, h_bodenplatte]);
    gerader_zaun(20000, [44550, -8100, h_bodenplatte + 3*d_floor + 3*storey_height_high], 40);
    gerader_zaun(12800, [50150, -5200, h_bodenplatte + 2*d_floor + 3*storey_height_high], 40);
}

module baumzaun()
    for (i= [1:6:360]) rotate([0, 0, i]) union(){
    translate ([1000, 0, h_bodenplatte + railing]) cube([40, 120, 40], center = true);
    translate ([1000, 10]) cylinder(h_bodenplatte + railing, 20, 20, $fn=fast_curves?4:30);
}

module gerader_zaun(length, placememt, angle = 0) rotate([0, 0, angle]) union() {
    for (y = [0 : 120 : length])
        translate(placememt + [20, y, 0]) cylinder(railing, 20, 20, $fn=fast_curves?4:30);
    translate (placememt + [0, 0, railing]) cube([40, length, 40], center = false);
}

module stairs_simple(h, t, b, floor_height = d_floor) 
    let(
        anzahl = round(h/180), 
        stufentiefe = min(300, t/anzahl), 
        stufenhoehe = h/anzahl,
        versatz = max(0, t - anzahl*stufentiefe)/2,
        stufe_unten = [for (i=[0:anzahl]) [i*stufentiefe + versatz,stufenhoehe*i]], 
        stufe_oben = [for (i=[0:anzahl]) [i*stufentiefe + versatz, stufenhoehe*(i+1)]]
    ) 

    rotate([90, 0, 0]) linear_extrude(b) 
        polygon(points = [
            for (i= [0:(len(stufe_unten) + len(stufe_oben)-2)]) 
                (i % 2 == 0) ? stufe_unten[i/2] : stufe_oben[i/2],
            [t,anzahl*stufenhoehe],
            [t,anzahl*stufenhoehe-floor_height],
            [t-versatz,anzahl*stufenhoehe-floor_height],
            [versatz, -floor_height],
            [0, -floor_height],
            [0, 0],
        ]);
    
module stairs() color(color_access)
{
    // north
    translate ([19100, 43500]) rotate([0, 0, 180]) 
        stairs_simple(floor_1*0.2, 5200, 1080);
    translate ([15100, 43500, floor_1*0.2]) rotate([0, 0, 90]) 
        stairs_simple(floor_1*0.3, 5200, 1080);
    translate ([15100, 48700, floor_1*0.5]) rotate([0, 0, 0]) 
        stairs_simple(floor_1*0.2, 4000, 1170);
    translate ([19100, 48700, floor_1*0.7]) rotate([0, 0, -90]) 
        stairs_simple(floor_1*0.3, 5200, 1070);
    translate ([15100, 43500, floor_1-d_floor]) cube([4000, 1200, d_floor]);
    
    translate ([15100, 43500, floor_1]) rotate([0, 0, 90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1080);
    translate ([15100, 48700, floor_1 +storey_height_high*0.4]) rotate([0, 0, 0]) 
        stairs_simple(storey_height_high*0.2, 4000, 1170);
    translate ([19100, 48700, floor_1 +storey_height_high*0.6]) rotate([0, 0, -90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1070);
    translate ([15100, 43500, floor_2-d_floor]) cube([4000, 1200, d_floor]);
    
    translate ([15100, 43500, floor_2]) rotate([0, 0, 90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1080);
    translate ([15100, 48700, floor_2 +storey_height_high*0.4]) rotate([0, 0, 0]) 
        stairs_simple(storey_height_high*0.2, 4000, 1170);
    translate ([19100, 48700, floor_2 +storey_height_high*0.6]) rotate([0, 0, -90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1070);
    translate ([15100, 43500, floor_3-d_floor]) cube([4000, 1200, d_floor]);
        
    translate ([15100, 43500, floor_3]) rotate([0, 0, 90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1080);
    translate ([15100, 48700, floor_3 +storey_height_high*0.4]) rotate([0, 0, 0]) 
        stairs_simple(storey_height_high*0.2, 4000, 1170);
    translate ([19100, 48700, floor_3 +storey_height_high*0.6]) rotate([0, 0, -90]) 
        stairs_simple(storey_height_high*0.4, 5200, 1070);
    translate ([15100, 43500, floor_4-d_floor]) cube([4000, 1200, d_floor]);

    
    
    }

module parking()translate([0, 2400, 0]){
    for (i=[500:stangen_x:12000]) translate([i, 0, 0]) one_parking();
    for (i=[500+4*stangen_x:stangen_x:35000]) translate([i, 0, 0]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 2*stangen_y, 0]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 3*stangen_y, 0]) one_parking();
    for (i=[500:stangen_x:35000]) translate([i, 5*stangen_y, 0]) one_parking();
    for (i=[500:stangen_x:33000]) translate([i, 6*stangen_y, 0]) one_parking();
    for (i=[500:stangen_x:13000]) translate([i, 8*stangen_y, 0]) one_parking();
    for (i=[500+3*stangen_x:stangen_x:30000]) translate([i, 8*stangen_y, 0]) one_parking();
    for (i=[3800:stangen_x:15000]) translate([i, 0, 0]) one_parking();
    for (i=[3800+4*stangen_x:stangen_x:37000]) translate([i, 0, 0]) one_parking();
    for (i=[3800:stangen_x:37000]) translate([i, 2*stangen_y, 0]) one_parking();
    for (i=[3800:stangen_x:37000]) translate([i, 3*stangen_y, 0]) one_parking();
    for (i=[3800:stangen_x:35000]) translate([i, 5*stangen_y, 0]) one_parking();
    for (i=[3800:stangen_x:33000]) translate([i, 6*stangen_y, 0]) one_parking();
    for (i=[3800]) translate([i, 8*stangen_y, 0]) one_parking();
    for (i=[3800+3*stangen_x:stangen_x:32000]) translate([i, 8*stangen_y, 0]) one_parking();

    for (i=[500+2*stangen_x]) translate([i, 0, 0]) ally_parking();
    for (i=[3000+3*stangen_x]) translate([i, 0, 0]) ally_parking();
    for (i=[3800+stangen_x]) translate([i, 8*stangen_y, 0]) ally_parking();
};
module one_parking() color(color_parking) cube([2500, 5000, 10]);
module ally_parking() color(color_parking) cube([3500, 5000, 10]);

module room_text(text, size = 1000, placement, height = 1000)
    color(color_text) linear_extrude(height) translate(placement + [100, 200, 0])
        text(text, size=size);

module barrel_vault(height_middle, height_side, width, length, distances)
color(color_arches)
difference(){
    translate([0, 0, -height_middle + height_side])
        cube([length, width, height_middle- height_side], false);
    translate([-5, width/2, -height_middle + height_side])
        resize([length+10, width - distances*2, height_middle*2- height_side*2])
            rotate([0, 90, 0]) cylinder(1, 1, 1, false, $fn=fast_curves?10:30);
}
module parking_barrel_vaults() translate([0, 0, -e]) {
    translate([0, 2000, h_bodenplatte - d_bodenplatte])
        barrel_vault(height_middle = 3800, height_side = 2500, width = 13600, length = 39600, distances = dicke_saeule);
    intersection(){
        translate([0, 15100, h_bodenplatte - d_bodenplatte])
        barrel_vault(height_middle = 3800, height_side = 2500, width = 23100, length = 42000, distances = dicke_saeule);
        grundplatte(h_bodenplatte);
    }
    translate([0, 37700, h_bodenplatte - d_bodenplatte])
        barrel_vault(height_middle = 3800, height_side = 2500, width = 11400, length = 33500, distances = dicke_saeule);
};
