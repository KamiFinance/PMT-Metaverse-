# Step 9 — Procedural City with PCG

PCG (Procedural Content Generation) builds the city automatically from rules.
No need to place every building manually.

## Install free building assets

Get these free assets from Fab.com (Epic's marketplace):
1. Open Epic Launcher → **Fab** (top nav)
2. Search and add to project:
   - "City Sample Buildings" (free with UE5)
   - "Megascans Urban" (free Quixel assets)
   - "Modular Sci-Fi Buildings" (free)
3. These give you 100+ photorealistic building meshes with Nanite

## Create PCG Graph for each zone

1. Right-click Content Browser → **Procedural Content Generation → PCG Graph**
2. Name: `PCG_GalleryDistrict`

In the PCG Graph editor:

```
[Surface Sampler]             ← scatter points across zone area
    Grid Size: 15 (15m spacing between buildings)
    ↓
[Density Filter]              ← remove some points for variation  
    Min/Max Density: 0.4 / 1.0
    ↓
[Point Transform Modifier]    ← randomise rotation and scale
    Rotation Jitter Z: 0-360°
    Scale Jitter: 0.6 - 2.5×
    ↓
[Static Mesh Spawner]         ← place building meshes
    Mesh entries: [list of gallery-appropriate buildings]
    Use Nanite: ✅
```

## Add PCG Volume to the map

1. Drag a **PCG Volume** actor from the Create menu into your world
2. Set its bounds to cover the Gallery District area (from -2.5 to 2.5 km in X, appropriate Z)
3. In Details → Assign your PCG_GalleryDistrict graph

Press **Generate** — buildings spawn instantly!

## Zone sizes (in UE5 cm — remember ×100 vs meters):

| Zone | Center X | Center Z | Size |
|---|---|---|---|
| NFT Gallery | 180000 | -60000 | 400m × 400m |
| Event Arena | -180000 | -40000 | 400m × 400m |
| Token Exchange | 0 | -210000 | 300m × 300m |
| Avatar Lab | -150000 | 140000 | 300m × 300m |
| Marketplace | 0 | 210000 | 400m × 400m |
| Central Hub | 0 | 0 | 200m × 200m |

## Add Lumen neon lights

Inside each PCG volume, also scatter **Rect Lights** (area lights):
- Color: zone accent color (teal for gallery, red for arena, etc.)
- Intensity: 500–2000 lux
- These make Lumen GI fill buildings with the correct zone color

## End result

When you press Play, you will see:
- Photorealistic Nanite buildings procedurally filling each zone
- Lumen GI bouncing the neon light off all surfaces
- MetaHuman avatar standing in the scene
- Glowing parcel tiles between buildings
- Live blockchain data updating in real time

**This is genuinely photorealistic.** No web renderer can match this.
