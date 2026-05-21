# Step 8 — Connect UE5 to PMT Chain

UE5 talks to the blockchain through the Bridge API (Node.js server).

## Start the Bridge API

```bash
cd bridge-api/
cp .env.example .env
# Edit .env with your contract addresses
npm install
npm start
# Runs on http://localhost:4000
```

## BP_BridgeAPI Blueprint

Create this Blueprint to handle all API calls from UE5:

1. Right-click → Blueprint Class → Actor → `BP_BridgeAPI`
2. Add Variable: `BridgeURL` (String) = "http://localhost:4000"
3. Add Variable: `APIKey` (String) = your UE5_API_KEY from .env

### Function: LoadAllParcels

Nodes to connect:
```
[Custom Event: LoadAllParcels]
  → [Make HTTP Request]
      URL: BridgeURL + "/world/parcels"
      Verb: GET
      Headers: [("x-api-key", APIKey)]
      [On Complete]
        → [Get Response Content (as String)]
        → [Parse JSON (String)]
        → [For Each Element in "parcels" array]
            → [Spawn Actor: BP_ParcelActor]
                Location: (x * 1000, z * 1000, 0)  ← convert parcel to cm (UE uses cm)
                [Set Token ID = element.id]
                [Set Coord X  = element.x]
                [Set Coord Z  = element.z]
                [Set Zone ID  = element.zone]
                [Set Owner    = element.owner]
```

> Note: UE5 uses centimeters. 1 parcel = 10m = 1000cm. So parcel coord 5 = 5000cm.

### Function: LoadAvatarForWallet(address)

```
[Custom Event: LoadAvatarForWallet (address: String)]
  → [Make HTTP Request]
      URL: BridgeURL + "/world/avatars/" + address
      [On Complete]
        → [Parse JSON]
        → If hasAvatar = true:
            → [Spawn BP_MetaHumanAvatar]
            → [Call ApplyOnChainTraits with traits from JSON]
        → If hasAvatar = false:
            → [Show "Mint Avatar" prompt in HUD]
```

### WebSocket: Real-time Events

```
[Event BeginPlay]
  → [Create WebSocket Connection]
      URL: BridgeURL (replace http with ws) + "/ws"
      [On Message Received]
        → [Parse JSON]
        → Switch on "type":
            "parcel_minted" → Spawn new BP_ParcelActor at (x,z)
            "avatar_minted" → Play celebration Niagara effect
            "block"         → Update HUD block number text
```

## Test end-to-end

1. Start bridge-api: `npm start`
2. Launch UE5 with Pixel Streaming
3. Open browser → connect wallet
4. Browser overlay sends `wallet_connected` to UE5
5. UE5 calls `/world/avatars/YOUR_ADDRESS` → loads your avatar
6. All minted parcels appear as glowing tiles on the ground

**You now have a working photorealistic blockchain metaverse!**

See [Step 9 — Building with PCG](09-procedural-city.md) to auto-generate the city.
