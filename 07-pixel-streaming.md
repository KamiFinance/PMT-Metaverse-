# Step 7 — Enable Pixel Streaming

Pixel Streaming lets anyone play in a browser without downloading UE5.

## Enable the Plugin

1. Edit → Plugins → search "Pixel Streaming" → ✅ Enable → Restart Editor

## Launch with Pixel Streaming

### In UE5 Editor (for testing):

1. Go to **Edit → Editor Preferences → Level Editor → Play**
2. Under **Play in New Window**: add these Additional Launch Parameters:
   ```
   -PixelStreamingURL=ws://localhost:8888
   -AudioMixer
   ```
3. Press **Play** (the green button) → choose **Standalone Game**

### On your server (production):

```bash
# After building the project (Platforms → Windows → Package Project)
PMTMetaverse.exe \
  -PixelStreamingURL=ws://localhost:8888 \
  -AudioMixer \
  -RenderOffScreen \
  -ResX=1920 \
  -ResY=1080 \
  -ForceRes
```

## Start the Signaling Server

The signaling server connects the UE5 stream to browsers:

```bash
cd pixel-streaming/
docker-compose up signaling
```

## Open in browser

Navigate to `http://YOUR_SERVER_IP` and click **Play**.

You should see the UE5 world streamed live in your browser!

## Sending data from Browser to UE5

The web client can send JSON messages to UE5:

```javascript
// In pmt-overlay.js
pixelStreaming.emitUIInteraction({
  type: "wallet_connected",
  address: "0x123..."
});
```

In UE5 (BP_PMTGameMode), receive this:
1. Add **Pixel Streaming Input** component to GameMode
2. Bind event **On Input Event**
3. Parse the JSON → extract `type` and `address`
4. If type = "wallet_connected": store address, highlight owned parcels

**Next: [Step 8 — Connect to PMT Chain](08-blockchain.md)**
