# Step 4 — Create the Blueprints (no coding!)

Blueprints are UE5's visual scripting system. You connect nodes with wires instead of writing code.

## Create BP_PMTGameMode

1. In **Content Browser**, right-click → **Blueprint Class**
2. Parent Class: **Game Mode Base** → click Select
3. Name it: `BP_PMTGameMode`
4. Double-click to open
5. Click **Event Graph** tab at the top

### Add startup logic (BeginPlay):

Right-click in the graph → search "Event BeginPlay" → add it

From the white arrow on BeginPlay, drag and add:
1. **Delay** node → Duration = 1.0 (wait for world to load)
2. **Create Widget** node → Widget Class = (create WBP_HUD first in step below)
3. **Add to Viewport** node

From BeginPlay also connect:
4. **HTTP Request** node (search "Make HTTP Request")
   - URL = `http://YOUR_SERVER:4000/world/parcels`
   - Verb = GET
   - On Complete → **Parse JSON** → loop through parcels → Spawn BP_ParcelActor for each

**Save (Ctrl+S)**

## Create WBP_HUD (the screen overlay)

1. Right-click → **User Interface → Widget Blueprint**
2. Name: `WBP_HUD`
3. Open it → Design tab

Add these Text elements (drag from Palette on left):
- **Text** (top-left): "⬡ PMT Chain" — set Font Size = 14, Color = purple
- **Text** (top-left): bind to variable `BlockNumber`
- **Text** (top-left): bind to `ZoneName`
- **Text** (bottom): "WASD to move · Click parcel to inspect"

Each Text widget: right-click → **Bind** → Create Binding → return the variable value.

## Create BP_ParcelActor

1. Right-click → **Blueprint Class** → Actor → name `BP_ParcelActor`
2. Open it → Add Component → **Static Mesh** (name it "TileMesh")
3. In Static Mesh details → select `Plane` (built-in UE5 plane mesh)
4. Scale the plane to (0.09, 0.09, 1) — makes it ~9m × 9m (parcel is 10m, border gap)

5. Add Component → **Box Collision** → Scale to match tile

### Variables (My Blueprint → Variables → + button):
Add these variables:
- `TokenID` (Integer)
- `CoordX` (Integer)
- `CoordZ` (Integer)
- `ZoneID` (Integer)
- `OwnerAddress` (String)
- `bDeveloped` (Boolean)

### BeginPlay in BP_ParcelActor:
1. Get `ZoneID` → Switch on Int:
   - 0 (Wilderness) → Set Material → M_Parcel_Wild (create in Step 5)
   - 1 (Gallery)    → Set Material → M_Parcel_Gallery
   - 2 (Arena)      → Set Material → M_Parcel_Arena
   - 3 (Market)     → Set Material → M_Parcel_Market
   - 4 (AvatarLab)  → Set Material → M_Parcel_AvatarLab
   - 5 (Central)    → Set Material → M_Parcel_Central

### On Clicked:
Add an **On Clicked (Box Collision)** event:
1. Print String (for debug): "Parcel TokenID: " + TokenID
2. Set WBP_HUD → Show Parcel Info Panel (pass TokenID, OwnerAddress, ZoneID)
3. If OwnerAddress is empty AND wallet connected → Show Mint Dialog

**Save all**

**Next: [Step 5 — Materials](05-materials.md)**
