# NanoVNA Console Enclosure — Project Changelog & Handoff

Dual NanoVNA-H4 + ESP32-C3 Super Mini console housing. v3 = two-part split body (`body_left`, `body_right`) + `back_plate`, printed in PETG on an Elegoo Neptune 4 Pro (Klipper / Moonraker / Fluidd).

| | |
|---|---|
| Last updated | 2026-10-31 10:00 EDT (session 3) |
| Time zone | EDT (UTC-4) unless marked UTC. DST ends 2026-11-01. The printer's own clock runs 12 h ahead of EDT (UTC+8). |
| Evidence tags | [fs] file timestamps / download provenance, [hdr] file header or comments, [gcode] gcode header / embedded config, [moonraker] printer job history, [klippy] Klipper log, [chat] exported chat, [render] OpenSCAD re-render, [inferred] deduced, not directly recorded |

How to maintain this file: add new entries at the TOP of section 3, append rows to sections 2, 5 and 7, keep the evidence tags, use EDT, and update section 1 and the "Last updated" line every session.

---

## 1. Status snapshot (2026-10-31 ~10:00 EDT)

| Part | Size (mm) | STL | Gcode to use | State |
|---|---|---|---|---|
| body_right | 28.5 x 116 x 22.5 | `NanoVNA_Console_v3_body_right.stl` | `NanoVNA_Console_v3_body_right.gcode` (old profile: 3 perimeters, 15 % gyroid) | **Printed** (job 00002C, Oct 29). Matt: "came out perfectly". Not re-sliced. |
| body_left | 143 x 116 x 22.5 | `NanoVNA_Console_v3_body_left.stl` | `NanoVNA_Console_v3_body_left_100pct.gcode` | **Not printed.** Two failed attempts with the old gcode (00002D, 00002E). New gcode is on the printer, not started. |
| back_plate | 167 x 116 x 11 | `NanoVNA_Console_v3_back_plate.stl` | `NanoVNA_Console_v3_back_plate_100pct.gcode` | **Not printed.** New gcode is on the printer, not started. |

- Printer at 09:56 EDT: Klipper `standby`, nozzle 20 C / bed 19 C, heaters off, no job, idle_timeout Idle.
- Both `_100pct` gcodes exist in three places with identical SHA-256: the work area, the printer's `gcodes` folder, and this folder.
- Nothing has been started since the last failed run. A print is only started after Matt explicitly says go: the bed must be clear of the earlier tangle and the nozzle checked for stuck PETG.
- Next actions: (1) Matt confirms bed clear, then start body_left (est. 3 h 26 m). (2) Watch layers 3-15 (Z 0.6-3.0 mm): the plate's top skin is where both earlier attempts died. (3) Then back_plate (est. 3 h 36 m). (4) Work through section 9.

---

## 2. Timeline (reconstructed from the files)

Sessions: **1** = earlier chats, individual chats not retrievable (design v1 to v3, STL export, slicing). **2** = claude.ai chat `<chat-id>`, Oct 30 16:47-20:07 (export in `outdated/`). **3** = this chat, Oct 30 ~20:08 onward, with an overnight pause.

| When (EDT) | Event | Evidence |
|---|---|---|
| 2026-10-21 16:45 | `Shared/nanovna_esp32_housing.scad` saved in cloud storage: "Dual NanoVNA-H4 and ESP32-S3 Bench Housing" (one-piece body + rear cover). Earliest dated design file. | [fs] [hdr] |
| 2026-10-24 20:54 | v1 body and v1 cover plate downloaded as `.scad.txt` from Claude artifacts (Floorp). Same 160x102x28 / 108x72x24 numbers. | [fs] |
| 2026-10-27 21:36 | Finder alias created pointing at the v1 file. | [fs] |
| 2026-10-28 05:35 | v2 ("audited") saved to cloud storage `3D Printer Diag/`. | [fs] [hdr] |
| 2026-10-28 20:09 | `v3.scad` downloaded from claude.ai (Brave): split housing, ESP32-C3 Super Mini. | [fs] [hdr] |
| 2026-10-28 20:11 | `export.stl` from the self-hosted OpenSCAD web UI: the default exploded PREVIEW, not a printable part. | [fs] [render] |
| 2026-10-28 20:54 | `v4.scad.txt` downloaded from a Claude artifact (Floorp). Header says v3.1 (adds joint test coupon). File is TRUNCATED at line 305. | [fs] [hdr] [render] |
| 2026-10-28 20:58 / 21:00 | `export(1).stl` and `export(2).stl`: two more preview exports (identical to each other). | [fs] |
| 2026-10-29 08:48 | `NanoVNA Shell.zip` (the three printable STLs) downloaded from claude.ai. | [fs] |
| 2026-10-29 09:45-09:49 | Loose STLs downloaded from claude.ai: body_right 09:45:57, back_plate 09:49:17, body_left 09:49:26. They match a fresh render of `v3.scad` exactly. | [fs] [render] |
| 2026-10-29 14:39-14:42 | Sliced in PrusaSlicer 2.9.6 on a laptop, old profile (identical config hash on all three): body_right 14:39:21, back_plate 14:41:52, body_left 14:42:41. | [gcode] |
| 2026-10-29 14:56 | `body_right.gcode` uploaded to the printer. | [moonraker] |
| 2026-10-29 17:51-19:25 | **Job 00002C body_right: completed** (82.5 min, 9,272 mm). | [moonraker] |
| 2026-10-29 20:32-20:33 | `body_left.gcode` uploaded; **job 00002D body_left started**. | [moonraker] |
| 2026-10-29 21:31:34 | 00002D ended `klippy_shutdown` after 47.4 min at layer 13 (Z 2.60, perimeter). Manual emergency stop ("Shutdown due to webhooks request"), not a fault. Klipper restarted 21:32:00, 21:32:37, 21:32:54. | [moonraker] [klippy] |
| 2026-10-30 07:30-08:41 | **Job 00002E body_left, second attempt: cancelled** after 59.1 min at layer 15 (Z 3.00, top solid infill). | [moonraker] [klippy] |
| 2026-10-30 08:50 | Emergency stop ~11 s into homing (no print running). Klipper restarted 08:51:20 and 08:51:37. | [klippy] |
| 2026-10-30 16:47-20:03 | Session 2 (6 messages): printer and log review, failure diagnosis, new slicing profile agreed. | [chat] |
| 2026-10-30 20:07 | Session 2 exported to JSON (now in `outdated/`). | [fs] |
| 2026-10-30 ~20:08 | Session 3 starts. STLs copied to the workstation 20:16. | [fs] |
| 2026-10-30 20:18 | Final re-slice with the agreed profile (gcode headers 00:18:17-18 UTC). | [gcode] |
| 2026-10-30 20:19 | `_100pct` gcodes uploaded to the printer (not started). | [moonraker] |
| 2026-10-31 ~05:00 | Project files moved into `NanoVNA_Console_Enclosure/`; superseded files into `outdated/` (finished 05:02). | [fs] |
| 2026-10-31 05:12 | `_100pct` gcodes copied to this folder (scp, hashes verified). | [fs] |
| 2026-10-31 09:56 | Printer confirmed idle. This changelog written. | live check |

---

## 3. Changelog (newest first)

### 2026-10-31 (session 3, continued)
- **Added** this `CHANGELOG.md`, built from file timestamps, download provenance, gcode headers, Moonraker history, the Klipper log, OpenSCAD re-renders and the session-2 chat export.
- **Added** `NanoVNA_Console_v3_body_left_100pct.gcode` and `NanoVNA_Console_v3_back_plate_100pct.gcode` to this folder. Copied between machines with scp. SHA-256 identical on the workstation, printer and laptop.
- **Changed** layout: project files moved out of a loose Downloads folder into this folder. Moved to `outdated/`: old-profile `body_left.gcode` and `back_plate.gcode`, the v1 scad files and alias, three preview `export*.stl`, the session-2 chat export. Kept here: current STLs, `v3.scad`, `v4.scad.txt` (v3.1 draft), `body_right.gcode` (the print that worked), `NanoVNA Shell.zip` (duplicate of the STLs).

### 2026-10-30 (session 3, evening)
- **Added** slicing profile `profile_v3_robust.ini` (work area) and re-sliced body_left and back_plate with it. Details in section 6.
- **Added** both `_100pct` gcodes to the printer's `gcodes` folder. Not started.
- **Found** `v3.scad` reproduces all three STLs exactly (bounding box, facet count, volume), so it is the true source. `v4.scad.txt` is a truncated v3.1 draft that does not compile. The three `export*.stl` are exploded-preview exports (177 x 116 x 39.5 mm with ghost devices).
- **Found** both body_left stops were manual (emergency stop, then cancel). No Klipper or MCU fault.
- **Corrected** an earlier claim: "55 print stalls" during the second attempt. The Klipper `print_stall` counter jumped 0 to 55 about two minutes after the Oct 29 E-stop (Klipper restarting) and reset at the next restart. It did not change during any of the three prints.
- **Found** old body_left, body_right and back_plate gcodes share one slicer config (hash 49333a5a4ab5e3a3). The same profile printed body_right perfectly, so the failure is specific to body_left's geometry (143 x 116 mm solid plate), not the printer or profile in general [inferred].

### 2026-10-30 (session 2, chat d4a74f82)
- **Reviewed** printer history and Klipper log: body_left stopped at layers 13 and 15, both manual stops.
- **Diagnosed** (working theory): the 3 mm base plate has a plate-wide bridge layer at layer 11 over 15 % gyroid, then the top skin at layers 12-15; hot PETG with only ~30 % fan, plus stringing, caused the tangle.
- **Agreed profile** for body_left and back_plate: 100 % infill, 5 perimeters, nozzle 235 C (240 first layer), bed 70 C, part fan capped 60-70 % after layer 2, solid-infill and bridge speed capped at 60 mm/s, 0.4 mm Z-hop.
- Recommended in that chat but NOT in the agreed list (status unknown): dry the spool, wipe on retract, skip the brim, print a joint/tolerance coupon first, test one heat-set insert pull-out on body_right.

### 2026-10-29
- **Added** printable STLs (08:48-09:49) generated from `v3.scad`.
- **Added** gcodes for all three parts (old profile, 14:39-14:42).
- **Printed** body_right successfully (00002C).
- **Failed** body_left attempt 1 (00002D): manual E-stop at layer 13 after 47 min.

### 2026-10-28
- **Added** v2 "audited" (05:35, cloud storage), then v3 split housing (20:09) and the v3.1 test-harness draft (20:54, truncated). Preview exports 20:11, 20:58, 21:00.

### 2026-10-21 to 2026-10-27
- **Added** the first one-piece housing designs (v1, ESP32-S3 assumption). See section 4.

---

## 4. Design history

| Ver | File / location | Date | What it is | Status |
|---|---|---|---|---|
| v1 bench | Cloud storage `Shared/nanovna_esp32_housing.scad` (3,670 B) | 2026-10-21 | "Bench Housing": `main_body` + `back_cover`, four corner bosses, gussets, front retention lips, blind M3 insert holes 12 mm deep from the rear, bosses added after the cavity cut. NanoVNA assumed 160x102x28, ESP32-S3 108x72x24. | Superseded. Its content looks newer than the Oct 24 v1 downloads although its date is older [inferred]; unresolved. |
| v1 | `outdated/Dual NanoVNA and ESP32 Console Enclosure.scad.txt` (2,477 B) + `...Cover Plate.scad.txt` (833 B) | 2026-10-24 (download) | Standalone one-piece body + cover, same dimensions. Bugs listed in the v2 header: bosses deleted by the cavity cut, M3 holes through the front, divider never modelled. | Outdated |
| v2 | Cloud storage `3D Printer Diag/Dual_NanoVNA_ESP32_Console_Enclosure_v2.scad` (11,808 B) | 2026-10-28 05:35 | "housing v2 (audited)": NanoVNA-H4 corrected to 133x75x18, windows follow the active display area, divider and USB-C pass-through, ledges and stops with foam tape, posts moved out of device footprints, blind inserts from the rear, back plate. ESP still S3 108x72x24 ("not verified"). | Superseded (kept in cloud storage) |
| v3 | `Dual_NanoVNA_ESP32_Console_Enclosure_v3.scad` (15,432 B) | 2026-10-28 20:09 | Split housing for the ESP32-C3 Super Mini. Halves meet on one plane; tongue-and-groove in top/bottom walls; three alignment pins into sockets; joint features derived from `body()`; 45 degree seam relief; per-half size echo; `joint_check` part. | **Current**, source of the STLs [render] |
| v3.1 draft | `Dual_NanoVNA_ESP32_Console_Enclosure_v4.scad.txt` (12,516 B) | 2026-10-28 20:54 | Header: "housing v3.1 (split + interlock + test harness)". Adds `joint_test_coupon(clearances)`, `socket_clr`, `left_region_clr`. Truncated at line 305 (ends in `for (i =`), no back_plate or preview modules. Does not parse in OpenSCAD 2021.01. | Unfinished, kept in main folder |

### v3 key parameters (from `v3.scad`)
- Print orientation: front face (z=0) down, no supports. Parts: `part = "body_left" | "body_right" | "back"`; checks: `"preview"`, `"joint_check"`, `"check"`.
- NanoVNA-H4 (landscape, UI upright; 2x SMA + USB-C on the bottom edge, jog wheel + power switch on the top edge): `vna=[133,75,18]`, pocket clearance `clr=0.5` per side, display window from `vna_scr=[24.5,9.5,84,56]`, `win_m=1`, 45 degree window chamfer `win_ch=1.2`.
- ESP32-C3 Super Mini: `esp=[23,19,10]`, optional display `esp_scr=[1.5,2,20,15]`, USB-C x-span `[3,20]`.
- Walls `wall=3`, `front_t=3`, `back_t=3`, `div_t=3`. Free strips: `port_zone=24` under the devices, `top_strip=10` above.
- Hardware: 6x M3 heat-set inserts (M3x5.7; `insert_d=4.0`, `insert_h=8`), posts `boss_d=9`, 6x M3x8 flat-head screws (`screw_d=3.4`, `csk_d=6.4`), 2 mm adhesive foam tape behind each device (`foam_t=2`, squeeze 0.5).
- Joint: `jclr=0.20` per side (slip fit; comment says try 0.25 if PETG binds), `seam_relief=0.3`, tongues 1.0 x 2.0 mm, pins dia 3.0 x 4.5 mm at y = 58 / 76 / 94 mm, z = 12 mm, socket pads 8 mm wide.
- Derived: assembled body 167 x 116 x 22.5 mm. body_left is 143 wide because its 4.5 mm pins stick out past the seam (seam at x=138.5); body_right is 28.5 wide [inferred; matches the measured bounding boxes exactly]. The scad bed-size warning uses 225x225; the slicer bed shape is 230x230.
- Assembly (v3 header): push halves together (pins engage first), glue the seam with CA or 2-part epoxy (PETG solvent-welds poorly), leave face-down on a flat table until set, THEN heat-set the six inserts (the two centre ones sit on the seam).

---

## 5. Print log

| Job | Part | Profile | Start - end (EDT) | Result | Print time | PETG | Stopped at |
|---|---|---|---|---|---|---|---|
| 00002C | body_right | old | 10-29 17:51:29 - 19:25:16 | completed, "perfect" | 82.5 min (est. 1 h 28 m) | 9,272 mm (28.3 g) | - |
| 00002D | body_left | old | 10-29 20:33:08 - 21:31:34 | `klippy_shutdown` = manual E-stop | 47.4 min | 7,125 mm | layer 13, Z 2.60, perimeter |
| 00002E | body_left | old | 10-30 07:30:34 - 08:41:42 | cancelled by Matt | 59.1 min | 9,210 mm | layer 15, Z 3.00, top solid infill |
| (none) | body_left | new | not started | | est. 3 h 25 m 35 s | est. 22,627 mm (69.1 g) | |
| (none) | back_plate | new | not started | | est. 3 h 35 m 33 s | est. 24,561 mm (75.0 g) | |

The two failed attempts used 16,335 mm of PETG, about 50 g (at 3.055 mg/mm from the old gcode). Other jobs on the printer since Oct 24 are unrelated (mounts, scraper, shell, gantry-level, Printhead, spring-gauge).

---

## 6. Slicing profiles

PrusaSlicer 2.9.6, printer "Elegoo Neptune 4 Pro 0.4", print preset "0.20mm NORMAL @Neptune4Pro", filament "Generic PETG @Neptune4Pro". All three old gcodes carry the same config (SHA-256 49333a5a4ab5e3a3 of the embedded block).

| Setting | Old (as printed) | New (`profile_v3_robust.ini`) |
|---|---|---|
| Infill | 15 % gyroid | 100 %, pattern rectilinear |
| Perimeters | 3 | 5 |
| Nozzle | 245 C first layer / 240 C | 240 C first layer / 235 C |
| Bed | 80 C first layer / 75 C | 70 C / 70 C |
| Part fan | min 30 / max 50 / bridges 70 %; off for layer 1 | min 60 / max 70 / bridges 70 %; off for layers 1-2 (M106 S153 = 60 % from layer 3) |
| Infill / solid / bridge / top-solid speed | 150 / 120 / 40 / 60 mm/s | 60 / 60 / 60 / 60 mm/s |
| Z-hop (retract_lift) | 0.2 mm | 0.4 mm |
| Retraction | 0.8 mm | 0.8 mm (unchanged) |
| Estimate body_left | 2 h 18 m 58 s, 17,463 mm, 53.3 g | 3 h 25 m 35 s, 22,627 mm, 69.1 g |
| Estimate back_plate | 2 h 2 m 24 s, 17,099 mm, 52.2 g | 3 h 35 m 33 s, 24,561 mm, 75.0 g |

Three overrides beyond the agreed list, and why:
1. `fill_pattern` gyroid to rectilinear: PrusaSlicer refuses gyroid at 100 % density.
2. `infill_speed` 150 to 60: at 100 % density PrusaSlicer prints the interior as plain "infill", not "solid infill", so the 60 mm/s solid-infill cap did not reach it (it ran about 120 mm/s). Costs about 20 min on body_left and 35 min on back_plate.
3. Fan minimum raised to 60: PrusaSlicer only ramps toward the maximum on short layers; long layers (the big plate) run at the minimum, so capping only the maximum would have left the plate at 30 %.

Not applied (recommended in session 2, not in the agreed list): wipe on retract, brim (none used).

Verified in the new gcodes [gcode]: bed 70 C for the whole print; nozzle 140 C during homing, `M109 S240`, `M104 S235` from layer 2; fan on right before layer 3 (Z 0.6); body_left stays at S153 (60 %), back_plate reaches S176 (69 %) on short layers; every Z-lift is exactly 0.4 mm; infill, solid and top-solid never exceed 3600 mm/min (60 mm/s); no Bridge infill or Overhang perimeter extrusion in either file; body_left layers 11-15 (where the old runs died) are solid fill with no internal bridge (the old layer 11 was ~1.16 m of Bridge infill at 40 mm/s); body_left covers X 40-186, Y 54-176 mm and back_plate X 28-202, Y 54-176 mm on the 230x230 bed, clear of the purge line at Y ~5. body_left has 113 layers, back_plate 55.

Start gcode (custom, unchanged): `SET_GCODE_OFFSET Z=-3.150 MOVE=0` (calibrated nozzle-to-bed offset, "CAL1 sweep 2026-10-15"; set in the gcode because the touchscreen sets -3.2 but Fluidd and API starts set none), `M104 S140` during homing (nozzle-contact probe), `M190` bed wait before homing, `G28`, `BED_MESH_PROFILE LOAD=6`, `M109`. End gcode resets the offset to 0.

Reproduce:
```
cd <work-area>
prusa-slicer --export-gcode --load profile_v3_robust.ini \
  --output NanoVNA_Console_v3_<part>_100pct.gcode NanoVNA_Console_v3_<part>.stl
python3 audit_gcode.py NanoVNA_Console_v3_<part>_100pct.gcode   # temps, fan, Z-hop, speeds, types per layer
```
`profile_v3_robust.ini` was built from the config block embedded in the old gcode (`; prusaslicer_config = begin ... end`, leading `; ` stripped) plus the overrides above. `old_profile_as_printed.ini` is the untouched original.

---

## 7. File inventory (SHA-256 prefix)

Main folder:
| File | SHA-256 | Bytes | Role |
|---|---|---|---|
| `Dual_NanoVNA_ESP32_Console_Enclosure_v3.scad` | 608b0d2f3e89 | 15,432 | current source |
| `Dual_NanoVNA_ESP32_Console_Enclosure_v4.scad.txt` | c7fc1fb0c5cf | 12,516 | v3.1 draft, truncated |
| `NanoVNA_Console_v3_body_left.stl` | c40b1058d443 | 245,866 | current |
| `NanoVNA_Console_v3_body_right.stl` | 14bc17efa7de | 255,117 | current |
| `NanoVNA_Console_v3_back_plate.stl` | 5abbcb8c9e13 | 382,042 | current |
| `NanoVNA Shell.zip` | 0bd1679d3ecd | 68,033 | the same three STLs (redundant) |
| `NanoVNA_Console_v3_body_right.gcode` | 1ae6eb8294e4 | 3,731,921 | the print that worked (old profile) |
| `NanoVNA_Console_v3_body_left_100pct.gcode` | a163a8e8c979 | 4,047,901 | new profile, on the printer |
| `NanoVNA_Console_v3_back_plate_100pct.gcode` | d00b0db9baa9 | 1,357,027 | new profile, on the printer |
| `CHANGELOG.md` | n/a | n/a | this file |

`outdated/`:
| File | SHA-256 | Bytes | Why outdated |
|---|---|---|---|
| `NanoVNA_Console_v3_body_left.gcode` | fd7d25039002 | 3,916,558 | old profile, failed twice; still on the printer |
| `NanoVNA_Console_v3_back_plate.gcode` | b72ef5764d15 | 2,480,206 | old profile, never printed |
| `export.stl` | 78402d11cff0 | 245,384 | exploded preview with ghost devices, not printable |
| `export(1).stl`, `export(2).stl` | c20a86c9258f | 245,384 each | same, identical to each other |
| `Dual NanoVNA and ESP32 Console Enclosure.scad.txt` | b99debe38045 | 2,477 | v1 body |
| `Dual NanoVNA and ESP32 Console Enclosure Cover Plate.scad.txt` | 7b2df8c4a783 | 833 | v1 cover |
| `Dual NanoVNA and ESP32 Console Enclosure.scad alias` | 9442df5d58b4 | 1,012 | Finder alias to the v1 file |
| `3D-printed_NanoVNA_console_housing_2026-10-30.json` | 757a1b86bcb6 | 9,555 | export of session 2 |

Elsewhere:
- Printer (gcodes root): `NanoVNA_Console_v3_body_right.gcode`, `NanoVNA_Console_v3_body_left.gcode` (OLD, do not start), `NanoVNA_Console_v3_body_left_100pct.gcode`, `NanoVNA_Console_v3_back_plate_100pct.gcode`, plus unrelated `spring-gauge.gcode`.
- Work area: STL copies, both `_100pct` gcodes, `profile_v3_robust.ini`, `old_profile_as_printed.ini`, `audit_gcode.py`.
- Cloud storage: `Shared/nanovna_esp32_housing.scad`, `3D Printer Diag/Dual_NanoVNA_ESP32_Console_Enclosure_v2.scad`.
- Self-hosted OpenSCAD web UI (source of the preview exports).
- Related but separate, left alone: `NanoVNA-H4-ZK_20260516.dfu` (NanoVNA-H4 firmware image); the `nanovna-cable-test` project (cable tester: Python batch test + ESP32-S3 firmware).

---

## 8. Findings and decisions

1. Failure location: both body_left runs died inside the 3 mm base plate (143 x 116 mm). Attempt 1 at layer 13 (perimeter), attempt 2 at layer 15 (top solid infill). Old layer 11 is a plate-wide bridge over 15 % gyroid.
2. Both stops were manual (webhooks emergency stop; user cancel). No MCU or Klipper fault. The 08:50 Oct 30 shutdown was another E-stop during homing.
3. No host starvation: `print_stall` did not move during any print (see section 3, 2026-10-30).
4. The same profile printed body_right perfectly, so the problem is body_left's geometry: a large solid plate with sparse infill and a bridge layer [inferred].
5. STLs are exact renders of `v3.scad` (not v3.1). Anything changed in the design must be exported again from `v3.scad` (or a repaired v3.1).
6. `gcode_editor.py audit-flow` reports `stationary-extrusion 1.600mm` and `long-retract 6.63mm` on these gcodes. These are false positives: the tool mishandles relative extrusion (M83). The known-good `body_right.gcode` trips the same flags. The real retraction is 0.8 mm everywhere.

---

## 9. Open items and risks

- [ ] Start body_left (needs Matt's go-ahead). Then back_plate.
- [ ] Bed 70 C is 5-10 C below what the good body_right ran at (80 / 75) on a 143 x 116 mm solid plate. Watch the first layers for corner lift; fallback is a re-slice at 75-80 C (edit `bed_temperature` and `first_layer_bed_temperature`).
- [ ] Spool dryness unconfirmed. Stringing across the windows looked like damp PETG in session 2; slicer settings cannot compensate. Typical drying: about 65 C for 4-6 h.
- [ ] body_right was printed with 3 perimeters / 15 % gyroid, so its insert bosses are thinner-walled than the new halves. Consider a test heat-set insert (pull-out) before assembly.
- [ ] Joint fit is untested (`jclr=0.20`, "try 0.25 if PETG binds"). The v3.1 test coupon was never completed (file truncated). Either repair `v4.scad.txt` or print a manual tolerance check before gluing.
- [ ] Old `NanoVNA_Console_v3_body_left.gcode` is still on the printer next to the new one; easy to start the wrong file. Consider deleting or renaming it.
- [ ] `NanoVNA Shell.zip` duplicates the STLs and can be deleted.
- [ ] Downloads is a fragile home for a long-lived project; consider moving this folder somewhere synced or backed up (cloud storage).
- Unknowns: which exact chats produced v1/v2/v3 and the STLs; why the Oct 21 cloud storage file has newer content than the Oct 24 v1 downloads.
