# Step 5 — Create PBR Materials

Materials in UE5 define how surfaces look. We use PBR (Physically Based Rendering) for photorealism.

## Create M_Ground_Reflective

1. In Content Browser → right-click → **Material** → name `M_Ground_Reflective`
2. Double-click to open the Material Editor

Add these nodes (right-click to search):
- **Constant3Vector** → set to dark navy blue `(0.01, 0.01, 0.06)` → connect to **Base Color**
- **Constant** → value `0.92` → connect to **Metallic**
- **Constant** → value `0.05` → connect to **Roughness**
- **Constant** → value `0.5`  → connect to **Specular**

Click **Apply** then **Save**

## Create Zone Parcel Materials

For each zone, create a material. Here is the pattern (repeat for each color):

**M_Parcel_Gallery:**
- Base Color: `(0.01, 0.08, 0.04)` (dark teal)
- Metallic: 0.1, Roughness: 0.6
- Add **Emissive Color**: `(0.0, 0.6, 0.3)` × 0.4 (subtle glow)

**M_Parcel_Arena:**
- Base Color: `(0.08, 0.01, 0.01)` (dark red)
- Emissive: `(0.8, 0.15, 0.0)` × 0.4

**M_Parcel_Market:**
- Base Color: `(0.08, 0.05, 0.0)`
- Emissive: `(0.8, 0.55, 0.0)` × 0.4

**M_Parcel_AvatarLab:**
- Base Color: `(0.05, 0.0, 0.08)`
- Emissive: `(0.6, 0.0, 0.9)` × 0.4

**M_Parcel_Central:**
- Base Color: `(0.02, 0.0, 0.1)`
- Emissive: `(0.3, 0.15, 1.0)` × 0.6

**M_Parcel_Wild:**
- Base Color: `(0.01, 0.01, 0.03)`
- Emissive: `(0.05, 0.04, 0.2)` × 0.15

**M_Parcel_Owned:**
- Base Color: `(0.0, 0.1, 0.03)`
- Emissive: `(0.0, 1.0, 0.4)` × 0.8 (bright green — your parcels!)

## Add a Pulsing Emissive (advanced, optional)

In the material, before connecting to Emissive Color:
1. Add **Sine** node
2. Input: **Time** node × 0.8
3. Remap Sine output (−1..1) to (0.6..1.0) using **Multiply** + **Add**
4. Multiply the emissive color vector by this pulsing value

This creates a subtle breathing glow effect on all parcel tiles.

**Next: [Step 6 — Avatar System](06-avatars.md)**
