# NanoVNA Console Enclosure

Dual NanoVNA-H4 + ESP32 console housing. v3 is a two-part split body (`body_left`, `body_right`) plus `back_plate`, printed in PETG on an Elegoo Neptune 4 Pro (Klipper).

See [CHANGELOG.md](CHANGELOG.md) for the full project history and status.

| Dir | Contents |
|---|---|
| `openscad/` | Parametric sources (v3, v4) |
| `stl/` | v3 STLs: body_left, body_right, back_plate |
| `gcode/` | Sliced gcode (`*_100pct` = current profile; `body_right.gcode` = old profile, printed) |
| `profiles/` | PrusaSlicer-style profiles: `old_profile_as_printed.ini`, `profile_v3_robust.ini` |
| `tools/` | `audit_gcode.py` — per-layer gcode sanity audit |
| `outdated/` | Superseded v1/v2 designs, old gcode, exported chat |

Related: [nanovna-cable-test](https://github.com/mjdeiter/nanovna-cable-test) (cable tester, separate project).
