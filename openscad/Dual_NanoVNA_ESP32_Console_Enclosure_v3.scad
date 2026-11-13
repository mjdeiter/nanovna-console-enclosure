// =====================================================================
//  NanoVNA-H4 + ESP32-C3 Super Mini console  -  housing v3 (split + interlock)
// =====================================================================
//  PRINT     front face (z = 0) DOWN on the bed, no supports needed.
//  PARTS     part = "body_left" or "body_right" or "back"
//  CHECK     part = "preview"     : exploded view with ghost devices
//            part = "joint_check" : press F6. "Top level object is empty" means
//                                   the two halves touch but never collide.
//            part = "check"       : press F6. "Top level object is empty" means
//                                   no device touches the housing. Anything solid
//                                   is a collision.
//  HARDWARE  6x M3 heat-set insert (M3 x 5.7), 6x M3 x 8 flat-head screw,
//            2 mm adhesive foam tape behind each device.
//  ASSEMBLY  Push the halves together (the pins find their sockets first), glue
//            the seam with CA or 2-part epoxy (PETG solvent-welds poorly) and
//            leave the assembly face-down on a flat table until it sets. THEN
//            heat-set the six inserts: the two centre ones sit on the seam.
//
//  CHANGED FROM v2 (split)
//   1. The halves overlapped by 0.4 mm along the split. They now meet on one
//      plane (spine_x) and only the interlock features carry clearance.
//   2. Tongue-and-groove in the top and bottom walls (tongues on the left half).
//   3. Three alignment pins (left half) into sockets (right half). The sockets
//      sit in small pads on the ESP side of the divider: the divider is only
//      1.5 mm thick per half, far too thin to hold a socket itself.
//   4. Every joint feature is carved from the shared body(), so it follows the
//      housing when dimensions change. Left = body AND region; right = body
//      MINUS the same region grown by jclr.
//   5. 45-degree relief on the seam edge at the bed (elephant foot).
//   6. Size echo / bed warning back (now per half). Preview shows the halves
//      pulled apart (split_open); part = "joint_check" added.
// =====================================================================

$fn  = 48;
part = "preview";

// ---------------- printer (only used for the size warning) ------------
bed = [225, 225];                   // Elegoo Neptune 4 Pro

// ================= MEASUREMENTS =======================================
// NanoVNA-H4, landscape, UI upright. 2x SMA + USB-C on the BOTTOM edge,
// jog wheel + power slide switch on the TOP edge.
vna       = [133, 75, 18];          // [w, h, d]  published 133 x 75 x 18
vna_scr   = [24.5, 9.5, 84, 56];    // active display [x, y, w, h] from device lower-left
vna_bot_x = [18, 115];              // x-span of SMA + USB-C on the bottom edge
vna_top_x = [18, 115];              // x-span of jog + power switch on the top edge

// ESP32-C3 Super Mini + optional display module
esp       = [23, 19, 10];           // [w, h, d] board footprint ~22.5 x 18 mm + clearance
esp_scr   = [1.5, 2, 20, 15];       // active display area
esp_bot_x = [3, 20];                // USB-C port on bottom edge
esp_y_off = 0;                      // lift the ESP above the shared bottom edge (>= 0)
// ======================================================================

// ---------------- housing -------------------------------------------
wall      = 3;      // side walls
front_t   = 3;      // front plate = bezel lip around each window
back_t    = 3;      // back plate
clr       = 0.5;    // gap per side between a device and its locators
div_t     = 3;      // divider wall between the two devices
boss_d    = 9;      // screw post diameter
insert_d  = 4.0;    // hole for an M3 x 5.7 heat-set insert
insert_h  = 8;      // insert hole depth from the rear face
screw_d   = 3.4;    // M3 clearance hole in the back plate
csk_d     = 6.4;    // M3 flat-head countersink diameter
foam_t    = 2;      // foam tape thickness, uncompressed
foam_sq   = 0.5;    // how far the foam is squeezed when the plate is on
loc_w     = 8;      // width of the ledges / stops at each device corner
loc_t     = 3;      // thickness of the ledges / stops
win_m     = 1;      // window margin around the active display area
win_ch    = 1.2;    // 45-degree chamfer on the window's outer edge
port_zone = 24;     // free strip under both devices
top_strip = 10;     // free strip above the devices

// ---------------- split joint (centre plane x = spine_x) ------------
// Male features (tongues, pins) live on the LEFT half, female features
// (grooves, sockets) on the RIGHT half.
jclr        = 0.20; // clearance per side on every mating feature (slip fit; try 0.25 if PETG binds)
seam_gap    = 0.0;  // extra gap between the two flat seam faces (0 = touching)
seam_relief = 0.3;  // 45-degree relief on the seam edge at the bed, 0 = off
tg_w        = 1.0;  // tongue thickness in the 3 mm top / bottom wall
tg_d        = 2.0;  // tongue depth into the other half
tg_z0       = 1.0;  // tongue starts this high at the seam, then grows at 45 deg (no support)
pin_d       = 3.0;  // alignment pin diameter
pin_l       = 4.5;  // pin length past the seam (longer than tg_d: pins engage first)
pin_lead    = 0.6;  // lead-in chamfer on the pin tip and the socket mouth
pin_z       = 12;   // pin height above the bed
pin_y       = [58, 76, 94];   // pin positions along the seam (free zone above the ESP)
pad_w       = 8;    // width of each socket pad
sock_extra  = 0.5;  // socket depth beyond the pin tip
pad_back    = 1.5;  // plastic behind the bottom of each socket
split_open  = 10;   // preview only: how far the right half is pulled away

// ---------------- derived -------------------------------------------
vp_w = vna[0] + 2*clr;   vp_h = vna[1] + 2*clr;
ep_w = esp[0] + 2*clr;   ep_h = esp[1] + 2*clr;

dev_h = max(vp_h, esp_y_off + ep_h);
cav_w = vp_w + div_t + ep_w;
cav_h = port_zone + dev_h + top_strip;
cav_d = max(vna[2], esp[2]) + foam_t - foam_sq;

outer_w = cav_w + 2*wall;
outer_h = cav_h + 2*wall;
outer_d = front_t + cav_d;

div_x = wall + vp_w;
dv    = [wall + clr, wall + port_zone + clr];
de    = [div_x + div_t + clr, wall + port_zone + esp_y_off + clr];

br      = boss_d / 2;
spine_x = div_x + div_t / 2;
boss_pos = [
    [wall + br,           wall + br,           true],
    [outer_w - wall - br, wall + br,           true],
    [wall + br,           outer_h - wall - br, true],
    [outer_w - wall - br, outer_h - wall - br, true],
    [spine_x,             wall + br,           false],
    [spine_x,             outer_h - wall - br, false]
];

usb_y = [wall + boss_d + 0.5, dv[1] - loc_t - 0.5];

sx    = spine_x;                              // the split plane
pad_x = sx + pin_l + sock_extra + pad_back;   // right face of the socket pads

echo(str("Housing: ", outer_w, " x ", outer_h, " x ", outer_d, " mm"));
echo(str("Left half ", sx + pin_l, " mm wide (with pins), right half ", outer_w - sx, " mm wide"));
if (max(sx + pin_l, outer_w - sx) > bed[0] || outer_h > bed[1])
    echo("WARNING: a half is larger than the print bed");
assert(pin_l > tg_d, "pins should be longer than the tongues so they engage first");
assert(min(pin_y) - pad_w/2 > de[1] + esp[1] + clr + loc_t + 1, "lowest pad runs into the ESP locators");
assert(max(pin_y) + pad_w/2 < outer_h - wall - boss_d - 1,      "top pad runs into the spine post");

// ---------------- parts & modules -----------------------------------
if (part == "body_left")        body_left();
else if (part == "body_right")  body_right();
else if (part == "back")        back_plate_print();
else if (part == "joint_check") intersection() { body_left(); body_right(); }
else if (part == "check")
    union() {
        intersection() { union() { body_left(); body_right(); } ghosts(0.01); }
        intersection() { back_plate(); ghosts(0.01); }
    }
else                            preview_all();

module window(x, y, w, h) {
    translate([x, y, 0]) {
        hull() {
            translate([-win_ch, -win_ch, -0.01]) cube([w + 2*win_ch, h + 2*win_ch, 0.01]);
            translate([0, 0, win_ch - 0.01])     cube([w, h, 0.01]);
        }
        translate([0, 0, -0.01]) cube([w, h, front_t + 0.02]);
    }
}

module notches() {
    translate([dv[0] + vna_bot_x[0], -1, front_t + 3])
        cube([vna_bot_x[1] - vna_bot_x[0], wall + 1.5, cav_d + 1]);
    translate([de[0] + esp_bot_x[0], -1, front_t + 3])
        cube([esp_bot_x[1] - esp_bot_x[0], wall + 1.5, cav_d + 1]);
    translate([dv[0] + vna_top_x[0], outer_h - wall - 0.5, front_t + 3])
        cube([vna_top_x[1] - vna_top_x[0], wall + 1.5, cav_d + 1]);
}

module post2d(p) {
    x  = p[0]; y = p[1];
    yw = (y < outer_h / 2) ? wall - 0.5 : outer_h - wall + 0.5;
    translate([x, y]) circle(d = boss_d);
    translate([x - br, min(y, yw)]) square([boss_d, abs(y - yw)]);
    if (p[2]) {
        xw = (x < outer_w / 2) ? wall - 0.5 : outer_w - wall + 0.5;
        translate([min(x, xw), y - br]) square([abs(x - xw), boss_d]);
    }
}

module divider() {
    difference() {
        translate([div_x, wall - 0.5, front_t - 0.5])
            cube([div_t, cav_h + 1, cav_d + 0.5]);
        translate([div_x - 1, usb_y[0], front_t + 3])
            cube([div_t + 2, usb_y[1] - usb_y[0], cav_d + 1]);
    }
}

module corner_locators(d0, size) {
    xl = d0[0] - clr; xr = d0[0] + size[0] + clr;
    for (x0 = [xl - 0.5, xr - loc_w]) {
        translate([x0, d0[1] - loc_t, front_t - 0.5])
            cube([loc_w + 0.5, loc_t, size[2] + 0.5]);
        translate([x0, d0[1] + size[1] + clr, front_t - 0.5])
            cube([loc_w + 0.5, loc_t, size[2] + 0.5]);
    }
}

// full-height blocks on the ESP side of the divider that receive the pins.
// They sit in the empty strip above the ESP and cost nothing in the device pockets.
module joint_pads() {
    x0 = div_x + div_t - 0.5;
    for (y = pin_y)
        translate([x0, y - pad_w/2, front_t - 0.5])
            cube([pad_x - x0, pad_w, outer_d - front_t + 0.5]);
}

module body() {
    difference() {
        union() {
            difference() {
                cube([outer_w, outer_h, outer_d]);
                translate([wall, wall, front_t]) cube([cav_w, cav_h, cav_d + 1]);
                window(dv[0] + vna_scr[0] - win_m, dv[1] + vna_scr[1] - win_m, vna_scr[2] + 2*win_m, vna_scr[3] + 2*win_m);
                window(de[0] + esp_scr[0] - win_m, de[1] + esp_scr[1] - win_m, esp_scr[2] + 2*win_m, esp_scr[3] + 2*win_m);
                notches();
            }
            for (p = boss_pos) translate([0, 0, front_t - 0.5]) linear_extrude(cav_d + 0.5) post2d(p);
            divider();
            corner_locators(dv, vna);
            corner_locators(de, esp);
            joint_pads();
        }
        for (p = boss_pos) translate([p[0], p[1], outer_d - insert_h]) cylinder(d = insert_d, h = insert_h + 1);
    }
}

// ---------------- the split joint -----------------------------------
// round profile with 45-degree points top and bottom: prints without supports
// when it lies on its side, as a pin and as a hole
module lemon(d) {
    r = d / 2;
    hull() {
        circle(r = r);
        for (s = [-1, 1]) translate([0, s * r * sqrt(2)]) square(0.01, center = true);
    }
}

// alignment pin: origin on the seam, grows toward +x, 45-degree lead-in tip
module pin() {
    rotate([90, 0, 90]) {
        linear_extrude(height = pin_l - pin_lead) lemon(pin_d);
        translate([0, 0, pin_l - pin_lead]) hull() {
            linear_extrude(height = 0.01) lemon(pin_d);
            translate([0, 0, pin_lead - 0.01]) linear_extrude(height = 0.01) lemon(pin_d - 2*pin_lead);
        }
    }
}

// the pin grown by jclr, deeper by sock_extra, with a chamfered mouth
module socket() {
    d = pin_d + 2*jclr;
    rotate([90, 0, 90]) {
        translate([0, 0, -0.01]) hull() {
            linear_extrude(height = 0.01) lemon(d + 2*pin_lead);
            translate([0, 0, pin_lead]) linear_extrude(height = 0.01) lemon(d);
        }
        linear_extrude(height = pin_l + sock_extra) lemon(d);
    }
}

// wall tongue centred on y0, grown by c. The underside climbs at 45 degrees from
// tg_z0 so the tongue prints without support and nothing shows on the front face.
module tongue(y0, c = 0) {
    translate([0, y0 + tg_w/2 + c, 0]) rotate([90, 0, 0])
        linear_extrude(height = tg_w + 2*c)
            offset(delta = c)
                polygon([[sx - 1,    tg_z0],
                         [sx,        tg_z0],
                         [sx + tg_d, tg_z0 + tg_d],
                         [sx + tg_d, outer_d + 2],
                         [sx - 1,    outer_d + 2]]);
}

// The space the LEFT half owns. g = 0: exactly that. g = 1: the same space with
// every mating feature grown by jclr - the right half must keep out of it.
module left_region(g = 0) {
    c = g * jclr;
    translate([-5, -5, -5]) cube([sx + g*seam_gap + 5, outer_h + 10, outer_d + 10]);
    for (y0 = [wall/2, outer_h - wall/2]) tongue(y0, c);
    for (y = pin_y) translate([sx, y, pin_z]) {
        if (g == 0) pin();
        else        socket();
    }
}

// 45-degree relief on the seam edge at the bed, so the elephant foot of each
// half cannot stop the seam from closing on the front face
module relief_cut(left = true) {
    r  = seam_relief;
    e  = 0.01;
    xf = left ? sx : sx + seam_gap;
    if (r > 0)
        translate([0, outer_h + 1, 0]) rotate([90, 0, 0]) linear_extrude(height = outer_h + 2)
            polygon(left ? [[xf - r - e, -e], [xf + e, -e], [xf + e, r + e]]
                         : [[xf + r + e, -e], [xf - e, -e], [xf - e, r + e]]);
}

module body_left() {
    difference() {
        intersection() { body(); left_region(0); }
        relief_cut(true);
    }
}

module body_right() {
    difference() {
        body();
        left_region(1);
        relief_cut(false);
    }
}

// ---------------- back plate ----------------------------------------
module pad(d0, size) {
    ph = cav_d - size[2] - (foam_t - foam_sq);
    if (ph > 0.2) translate([d0[0] + 5, d0[1] + 5, outer_d - ph]) cube([size[0] - 10, size[1] - 10, ph + 0.01]);
}

module back_plate() {
    csk_h = (csk_d - screw_d) / 2;
    difference() {
        union() {
            translate([0, 0, outer_d]) cube([outer_w, outer_h, back_t]);
            pad(dv, vna); pad(de, esp);
        }
        for (p = boss_pos) {
            translate([p[0], p[1], outer_d - 1]) cylinder(d = screw_d, h = back_t + 2);
            translate([p[0], p[1], outer_d + back_t - csk_h]) cylinder(d1 = screw_d, d2 = csk_d + 0.4, h = csk_h + 0.2);
        }
    }
}

module back_plate_print() {
    translate([0, outer_h, outer_d + back_t]) rotate([180, 0, 0]) back_plate();
}

// ---------------- ghosts + preview ----------------------------------
module ghost_vna(eps = 0) {
    translate([dv[0] + eps, dv[1] + eps, front_t + eps]) cube([vna[0] - 2*eps, vna[1] - 2*eps, vna[2] - 2*eps]);
}

module ghost_esp(eps = 0) {
    translate([de[0] + eps, de[1] + eps, front_t + eps]) cube([esp[0] - 2*eps, esp[1] - 2*eps, esp[2] - 2*eps]);
}

module ghosts(eps = 0) { ghost_vna(eps); ghost_esp(eps); }

module preview_all() {
    color([0.75, 0.80, 0.90]) body_left();
    color([0.90, 0.80, 0.65]) translate([split_open, 0, 0]) body_right();
    translate([0, 0, 14]) back_plate();
    color([0.2, 0.45, 0.9, 0.5]) {
        ghost_vna(0);
        translate([split_open, 0, 0]) ghost_esp(0);
    }
}
