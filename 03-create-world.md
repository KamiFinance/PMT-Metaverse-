# Step 3 — Create the World Map

## Create a new level

1. In UE5, go to **File → New Level**
2. Select **Empty Level**
3. Save it: **File → Save Current Level As**
   - Save to: `Content/PMTMetaverse/Maps/`
   - Name: `MetaverseWorld`

## Add sky and lighting

In the top menu, click **Create** (the green + button) and add:

1. **Directional Light** — this is your moonlight
   - In Details panel: set Intensity = 1.5, Light Color = soft blue-purple (#8877cc)
   - ✅ Cast Shadows
   - ✅ Atmosphere & Cloud → Affect Atmospheric Scattering

2. **Sky Atmosphere** — creates realistic sky
   - Keep default settings
   - Rayleigh Scattering Color → make it dark blue-purple for night scene

3. **Exponential Height Fog** — atmospheric depth
   - Fog Density = 0.02
   - Fog Inscattering Color = very dark blue (#050514)
   - Start Distance = 200
   - Fog Cutoff Distance = 50000

4. **Sky Light** → set to **Real Time Capture** ON

## Set up the ground plane

1. Click **Create → Plane**
2. In Details → Transform: Scale = (120, 120, 1)
3. Create a Material (see Step 5) and apply it
4. In Details → ✅ Cast Shadows, ✅ Receive Decals

## Set World Position to night scene

In **World Settings** (Window → World Settings):
- Under Sky: set to night (or rotate Directional Light to face downward at -30°)

## Test: Press Play (green triangle)
You should see a dark atmospheric scene. Press Esc to stop.

**Next: [Step 4 — Create Blueprints](04-blueprints.md)**
