# Step 6 — MetaHuman Avatars

MetaHuman Creator makes photorealistic characters that are impossible to distinguish from real humans.

## Create your first MetaHuman

1. Go to **https://metahuman.unrealengine.com**
2. Sign in with your Epic account
3. Click **Create New MetaHuman**
4. Choose a starting preset (this is the base body/face)
5. Customize:
   - Face shape, skin tone, eye color, hair
   - Body type (will be overridden by on-chain traits)
6. Click **Export to UE5**

## Download into your project

1. In Epic Games Launcher → **Fab** tab (formerly Quixel Bridge)
2. Search **MetaHuman** → find your created character
3. Click **Add to Project** → select PMTMetaverse project

After downloading, in UE5 Content Browser you'll see:
`Content/MetaHumans/YourCharacter/`

## Create BP_MetaHumanAvatar

1. Right-click → Blueprint Class → parent: `BP_MetaHumanBase` (from MetaHuman plugin)
2. Name: `BP_MetaHumanAvatar`
3. Add these Variables:
   - `AvatarID` (Integer)
   - `SkinToneIndex` (Integer 0-9)
   - `OutfitIndex` (Integer 0-29)
   - `HairIndex` (Integer 0-19)
   - `AuraLevel` (Integer 0-9)
   - `Rarity` (Integer: 0=Common, 1=Rare, 2=Epic, 3=Legendary)

### Apply Traits Function:

Create a function `ApplyOnChainTraits(traits struct)`:

1. Set Material Parameter:
   - Target: Body mesh
   - Parameter Name: "SkinColor"
   - Value: Get element `SkinToneIndex` from array of 10 Color values

2. Set Material Parameter:
   - Parameter Name: "OutfitColor"  
   - Value: Get element `OutfitIndex` from 30-color array

3. **Switch on Rarity**:
   - 0 (Common):    Do nothing
   - 1 (Rare):      Spawn Niagara System `NS_Aura_Blue` at actor location
   - 2 (Epic):      Spawn `NS_Aura_Purple`
   - 3 (Legendary): Spawn `NS_Aura_Gold` + Post Process → slight bloom increase

## Movement Setup

1. Add **Character Movement Component** (already on BP_MetaHumanAvatar)
2. In the Event Graph:

**InputAxis MoveForward** → Get Actor Forward Vector → Add Movement Input

**InputAxis MoveRight** → Get Actor Right Vector → Add Movement Input

**InputAction Jump** → Jump

3. Set up Enhanced Input:
   - Create IA_Move, IA_Look, IA_Jump (Input Actions)
   - Create IMC_Default (Input Mapping Context)
   - Map WASD + Mouse to these actions

## Player Start

Add a **Player Start** actor to the map at position (0, 0, 100) — this is where the player spawns.

**Next: [Step 7 — Pixel Streaming Setup](07-pixel-streaming.md)**
