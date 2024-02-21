/*
öffentliche Räume entlang des hofes
juged wg
pärchen WG
2. fahrstuhl präzisieren
texts anlegen
noch eine kann-laufen-WG

... fenster (SPÄTER)
Dach noch danach

öffentlich räume:
unten
    * Café + Coworking
    * Plenumsraum / Meetingraum, evtl. beides mit Falttür
    * bestuhlter Raum für Vorträge/Musik/Kino
    
hof
    * Werkstatt (Fahrrad, Basteleien etc.)
    * Gemeinschaftsgarten im Hof + auf Dachterrasse, Gewächshaus
    * Fahrradschuppen
    * Makerspace
    
Fahrstuhl Süd
    * Gemeinschaftsraum Senioren und nebenan Co-Parenting Raum
    * Basteln/Textil
    * Bibliothek
    
Dach
    * Spa/Sauna/Sport
    * Waschküche
    * Gästezimmer
    
Fahrstuhl Nord
    * Youtube sudio
    * Bibliothek
*/

scale = 1/100;
rot = -16.39; // Grundstück nach Norden ausrichten und zurück
h_bodenplatte = 4000;
z_cut = 0;
z_cutheight = 5000;
doorshigh = 1;  // einfacher zeichnen mit ober reus stehenden türen
e = 1; // epsilon value to make things visible and remove later

// flow control
module haus()
scale(scale){
grundstueck (); 
for (x=[0:5150:46500], y=[1500:5250:49000])
    translate([x, y]) color("lightblue") bodensaeule();

raeume_innen();
};


//rotate([0, 0, -rot])
if (z_cut) projection() 
intersection(){
    translate([0, 0, z_cutheight * scale]) cube([20000, 20000, 0.1]);
    haus(); 
}
else haus();
    
    
module grundstueck() color("black") scale([1000, 1000, 1])
    translate([-113.3608, 44.89835]) rotate([0, 0, rot])
    import("grundr2.stl"); // Grundriss 1:1000
module bodensaeule() cube([300, 300, 4000]);
module bad_barrierefrei() cube([2800, 2500, 2500]);
module tuer_barrierefrei() 
cube([1000, 1000, doorshigh?3000:2000]);
module tuer_innen() 
    cube([800, 800, doorshigh?3500:2000]);
module tuer_klein() 
    cube([600, 600, doorshigh?3500:2000]);

module raeume_innen() {
    we_1_innen(h1=h_bodenplatte, h2=h_bodenplatte+3200);    // 6
    we_2_innen();                                           // 6
    we_3_innen();                                           // 6 
    we_4_innen();                                           // 6
    we_1_innen(h1=h_bodenplatte + 6400, h2=h_bodenplatte+3200*3);  // = WE 5, 6
    family1();                                           // 3 erwachsen, 4 kinder
    family2();                                           // 3 erwachsen, 8 kinder
    family3();                                           // 3 erwachsen, 8 kinder
    
    color("blue") translate ([28000, 1900, 0]) cube([4000, 5200, h_bodenplatte+7900]); // Treppenhaus südost
    color("blue") translate ([29000, 7100, h_bodenplatte]) cube([2000, 4200, 7900]); // Gang zum Hof
    color("blue") translate ([8200, 11300, 0]) cube([2000, 5000, 15000]); // Treppenhaus süd west
    color("blue") translate ([9000, 38000, 0]) cube([4000, 5200, h_bodenplatte+7900]); // Treppenhaus südost
    color("green") translate ([31200, 7300, h_bodenplatte]) cube([4800, 4000, 2500]); // Spielzimmer
    color("green") translate ([31200, 7300, h_bodenplatte + 2700]) cube([4800, 4000, 2500]); // basteln/textil
    color("green") translate ([31200, 7300, h_bodenplatte + 5400]) cube([4800, 4000, 2500]); // Bibliothek
    
    color("green") translate ([36200, 11500, h_bodenplatte]) cube([4600, 13900, 3000]); // Werkstatt / Makerspace
    }
    
    
module we_1_innen(h1, h2) {
    translate ([400, 1900, h1]) cube([5000, 4000, 3000]); // Küche
    translate ([400, 6100, h1]) cube([3800, 5000, 3000]); 
    translate ([4400, 6100, h1]) cube([1000, 5000, 3000]); // Flur
    translate ([4400, 10100, h1]) cube([2200, 1000, 3000]);
    translate ([5600, 10100, h1]) cube([1000, 6000, 3000]);
    translate ([5600, 12500, h1]) cube([2400, 3800, 3000]);
    translate ([6800, 11300, h1]) cube([1200, 1000, 3000]);      // Toilette 
    translate ([7400, 13100, h1]) color("lightblue") cylinder(6200 + e, 600, 600);
    translate ([400, 11300, h1]) cube([5000, 3800, 3000]);
    translate ([400, 15300, h1]) cube([5000, 3800, 3000]);
    translate ([4500, 5800, h1]) tuer_innen();
    translate ([4000, 10100, h1]) tuer_innen();
    translate ([6100, 11400, h1]) tuer_innen();
    translate ([5100, 14100, h1]) tuer_innen();
    translate ([5100, 15400, h1]) tuer_innen();
    translate ([7600, 15400, h1]) tuer_innen();
    
    translate ([400, 1900, h2]) cube([2000, 2000, 3000]);   // Wadewanne
    translate ([400, 4100, h2]) cube([2000, 1800, 3000]);   // Dusche
    translate ([2600, 1900, h2]) cube([2800, 4000, 3000]);   // Bad Vorraum
    translate ([400, 6100, h2]) cube([3800, 5000, 3000]); 
    translate ([4400, 6100, h2]) cube([1000, 5000, 3000]); // Flur
    translate ([4400, 10100, h2]) cube([2200, 1000, 3000]);
    translate ([5600, 10100, h2]) cube([1000, 6000, 3000]);
    translate ([5600, 12500, h2]) cube([2400, 3800, 3000]);
    translate ([6800, 11300, h2]) cube([1200, 1000, 3000]);      // Toilette 
    translate ([400, 11300, h2]) cube([5000, 3800, 3000]);
    translate ([400, 15300, h2]) cube([5000, 3800, 3000]);
    translate ([4500, 5800, h2]) tuer_innen();
    translate ([4000, 10100, h2]) tuer_innen();
    translate ([6100, 11400, h2]) tuer_innen();
    translate ([5100, 14100, h2]) tuer_innen();
    translate ([5100, 15400, h2]) tuer_innen();
    translate ([7600, 15400, h2]) tuer_innen();
    }
module we_2_innen() a11y(h_bodenplatte);
module we_3_innen() a11y(h_bodenplatte + 2700);
module we_4_innen() a11y(h_bodenplatte + 5400);
    
module a11y(h) translate([-1400, 0, 0])
    {
    translate ([0, 0, h]) linear_extrude(2500) polygon([[7000, 1900], [10600, 1900],[10600, 4600],[13600, 4600],[13600, 9300],[11600, 9300],[11600, 11100],[8200, 11100],[8200, 9900],[7000, 9900]]);         // Küche / Abstell
    translate ([13000, 7750, h]) tuer_barrierefrei();
    {
    translate ([10800, 1900, h]) bad_barrierefrei();     // Süd
    translate ([13000, 3300, h]) tuer_barrierefrei();
    translate ([13800, 1900, h]) cube([4000, 5200, 2500]); 
    translate ([14600, 6750, h]) tuer_barrierefrei();
    translate ([18000, 1900, h]) cube([4000, 5200, 2500]); 
    translate ([19600, 6750, h]) tuer_barrierefrei();
    translate ([22200, 1900, h]) bad_barrierefrei();
    translate ([21800, 3300, h]) tuer_barrierefrei();
    translate ([22200, 4600, h]) bad_barrierefrei();
    translate ([24300, 4700, h]) tuer_barrierefrei();
    translate ([25200, 1900, h]) cube([4000, 5200, 2500]);
    translate ([25600, 6750, h]) tuer_barrierefrei();} 
    {translate ([13800, 7300, h]) cube([16400, 2000, 2500]); // Flur
    translate ([27400, 7300, h]) cube([2800, 4700, 2500]);}
    {translate ([11800, 9500, h]) cube([4000, 5200, 2500]); // Nord
    translate ([14600, 8750, h]) tuer_barrierefrei();
    translate ([16000, 9500, h]) bad_barrierefrei();
    translate ([15600, 12250, h]) tuer_barrierefrei();
    translate ([16000, 12200, h]) bad_barrierefrei();
    translate ([18600, 10850, h]) tuer_barrierefrei();
    translate ([19000, 9500, h]) cube([4000, 5200, 2500]); 
    translate ([19600, 8750, h]) tuer_barrierefrei();
    translate ([23200, 9500, h]) cube([4000, 5200, 2500]); 
    translate ([25600, 8750, h]) tuer_barrierefrei();
    translate ([27400, 12200, h]) bad_barrierefrei();
    translate ([26600, 12250, h]) tuer_barrierefrei();}
    translate ([29700, 7750, h]) tuer_barrierefrei();
    }

module family1() translate ([0,0, h_bodenplatte]){
    {translate ([32200, 1900, 0]) cube([4400, 3000, 2500]); // Kind 1
    translate ([34200, 1900, 0]) cube([2400, 3800, 2500]);}
    translate ([36800, 1900, 0]) cube([4000, 3800, 2500]); // Kind 2
    {translate ([32200, 5900, 0]) cube([8600, 1200, 2500]);  // flur
    translate ([32200, 5100, 0]) cube([1800, 1200, 2500]);}
    translate ([41000, 1900, 0]) cube([5600, 5200, 3000]);  // Küche / Wohnen
    translate ([36200, 7300, 0]) cube([3000, 4000, 2500]);  // Kinderbad
    translate ([39400, 7300, 0]) cube([1400, 1000, 3000]);  // Toilette
    translate ([39400, 8500, 0]) cube([1400, 1000, 3000]);  // Toilette
    translate ([39400, 9700, 0]) cube([1400, 1600, 3000]);  // Abstelkammer
    translate ([41000, 7300, 0]) cube([1200, 15400, 3000]);  // Flur
    translate ([42400, 7300, 0]) cube([4200, 4000, 3000]);  
    translate ([42400, 11500, 0]) cube([2000, 2000, 3000]);  
    translate ([44600, 11500, 0]) cube([2000, 2000, 3000]);  
    translate ([42400, 13700, 0]) cube([4200, 5000, 3000]);  
    translate ([42400, 18900, 0]) cube([4200, 3800, 3000]);  
    translate ([41000, 22900, 0]) cube([5600, 2500, 3000]);  
    translate ([32000, 6000, 0]) tuer_innen();
    translate ([34500, 5500, 0]) tuer_innen();
    translate ([38500, 5500, 0]) tuer_innen();
    translate ([36500,6600, 0]) tuer_innen();
    translate ([40500,6100, 0]) tuer_innen();
    translate ([41200,7000, 0]) tuer_innen();
    translate ([40500,7400, 0]) tuer_innen();
    translate ([40500,8600, 0]) tuer_innen();
    translate ([40500,10400, 0]) tuer_innen();
    translate ([42000,8600, 0]) tuer_innen();
    translate ([42000,15600, 0]) tuer_innen();
    translate ([42000,20000, 0]) tuer_innen();
    translate ([43500,13000, 0]) tuer_innen();
    translate ([44700,11000, 0]) tuer_innen();
    translate ([41200,22500, 0]) tuer_innen();
    }
    
module family2() {
    translate ([0,0, h_bodenplatte + 2700]){
        {translate ([32200, 1900, 0]) cube([4400, 3000, 2500]); // Kind 1
        translate ([34200, 1900, 0]) cube([2400, 3800, 2500]);}
        translate ([36800, 1900, 0]) cube([4000, 3800, 2500]); // Kind 2
        {translate ([32200, 5900, 0]) cube([7800, 1200, 2500]);  // flur
        translate ([32200, 5100, 0]) cube([1800, 1200, 2500]);}
        color("lightblue") translate ([40000, 5900, 0]) cube([800, 1200, 2500]);
        translate ([36200, 7300, 0]) cube([3000, 4000, 2500]);  // Kinderbad
        translate ([32000, 6000, 0]) tuer_innen();
        translate ([34500, 5500, 0]) tuer_innen();
        translate ([38500, 5500, 0]) tuer_innen();
        translate ([36500,6600, 0]) tuer_innen();
    }
    translate ([0,0, h_bodenplatte + 3200]){
        translate ([41000, 1900, 0]) cube([5600, 5200, 3000]);  // Küche / Wohnen
        translate ([39400, 7300, 0]) cube([1400, 1000, 3000]);  // Toilette
        translate ([39400, 8500, 0]) cube([1400, 1000, 3000]);  // Toilette
        translate ([39400, 9700, 0]) cube([1400, 1600, 3000]);  // Abstelkammer
        translate ([41000, 7300, 0]) cube([1200, 15400, 3000]);  // Flur
        translate ([42400, 7300, 0]) cube([4200, 4000, 3000]);  
        translate ([42400, 11500, 0]) cube([2000, 2000, 3000]);  
        translate ([44600, 11500, 0]) cube([2000, 2000, 3000]);  
        translate ([42400, 13700, 0]) cube([4200, 5000, 3000]);  
        translate ([42400, 18900, 0]) cube([4200, 3800, 3000]);  
        translate ([41000, 22900, 0]) cube([5600, 2500, 3000]);  
        translate ([36200, 11500, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 15025, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 18550, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 22075, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([40500,6100, 0]) tuer_innen();
        translate ([41200,7000, 0]) tuer_innen();
        translate ([40500,7400, 0]) tuer_innen();
        translate ([40500,8600, 0]) tuer_innen();
        translate ([40500,10400, 0]) tuer_innen();
        translate ([40500,12400, 0]) tuer_innen();
        translate ([40500,16400, 0]) tuer_innen();
        translate ([40500,19400, 0]) tuer_innen();
        translate ([40500,22100, 0]) tuer_klein();
        translate ([42000,8600, 0]) tuer_innen();
        translate ([42000,15600, 0]) tuer_innen();
        translate ([42000,20000, 0]) tuer_innen();
        translate ([43500,13000, 0]) tuer_innen();
        translate ([44700,11000, 0]) tuer_innen();
        translate ([41200,22500, 0]) tuer_innen();
        }
    }
module family3() {
    translate ([0,0, h_bodenplatte + 5400]){
        {translate ([32200, 1900, 0]) cube([4400, 3000, 2500]); // Kind 1
        translate ([34200, 1900, 0]) cube([2400, 3800, 2500]);}
        translate ([36800, 1900, 0]) cube([4000, 3800, 2500]); // Kind 2
        {translate ([32200, 5900, 0]) cube([7800, 1200, 2500]);  // flur
        translate ([32200, 5100, 0]) cube([1800, 1200, 2500]);}
        color("lightblue") translate ([39500, 5900, 0]) cube([1250, 1200, 2500]);
        translate ([36200, 7300, 0]) cube([3000, 4000, 2500]);  // Kinderbad
        translate ([32000, 6000, 0]) tuer_innen();
        translate ([34500, 5500, 0]) tuer_innen();
        translate ([38500, 5500, 0]) tuer_innen();
        translate ([36500,6600, 0]) tuer_innen();
    }
    translate ([0,0, h_bodenplatte + 6400]){
        translate ([41000, 1900, 0]) cube([5600, 5200, 3000]);  // Küche / Wohnen
        translate ([39400, 7300, 0]) cube([1400, 1000, 3000]);  // Toilette
        translate ([39400, 8500, 0]) cube([1400, 1000, 3000]);  // Toilette
        translate ([39400, 9700, 0]) cube([1400, 1600, 3000]);  // Abstelkammer
        translate ([41000, 7300, 0]) cube([1200, 15400, 3000]);  // Flur
        translate ([42400, 7300, 0]) cube([4200, 4000, 3000]);  
        translate ([42400, 11500, 0]) cube([2000, 2000, 3000]);  
        translate ([44600, 11500, 0]) cube([2000, 2000, 3000]);  
        translate ([42400, 13700, 0]) cube([4200, 5000, 3000]);  
        translate ([42400, 18900, 0]) cube([4200, 3800, 3000]);  
        translate ([41000, 22900, 0]) cube([5600, 2500, 3000]);  
        translate ([36200, 11500, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 15025, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 18550, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([36200, 22075, 0]) cube([4600, 3325, 3000]);  // Kind
        translate ([40500,6100, 0]) tuer_innen();
        translate ([41200,7000, 0]) tuer_innen();
        translate ([40500,7400, 0]) tuer_innen();
        translate ([40500,8600, 0]) tuer_innen();
        translate ([40500,10400, 0]) tuer_innen();
        translate ([40500,12400, 0]) tuer_innen();
        translate ([40500,16400, 0]) tuer_innen();
        translate ([40500,19400, 0]) tuer_innen();
        translate ([40500,22100, 0]) tuer_klein();
        translate ([42000,8600, 0]) tuer_innen();
        translate ([42000,15600, 0]) tuer_innen();
        translate ([42000,20000, 0]) tuer_innen();
        translate ([43500,13000, 0]) tuer_innen();
        translate ([44700,11000, 0]) tuer_innen();
        translate ([41200,22500, 0]) tuer_innen();
        }
    }