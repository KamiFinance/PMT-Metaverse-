# Step 2 — Open the PMT Metaverse Project

## Clone the GitHub repo

Open a terminal (Command Prompt or PowerShell on Windows):

```bash
git clone https://github.com/YOUR_USERNAME/pmt-metaverse.git
cd pmt-metaverse
git lfs pull
```

## Open in Unreal Engine

1. In Epic Games Launcher → **Unreal Engine → Library**
2. Under **My Projects**, click **Browse**
3. Navigate to `pmt-metaverse/ue5-project/`
4. Select **PMTMetaverse.uproject**
5. Click **Open** — UE5 will compile shaders (takes 10–20 min first time)

## When UE5 opens you will see:
- A large empty grey viewport (the world)
- Content Browser at the bottom
- World Outliner on the right
- Details panel on the right

## Enable required plugins

Go to **Edit → Plugins** and make sure these are enabled (tick the box):
- ✅ Pixel Streaming
- ✅ MetaHuman
- ✅ Procedural Content Generation (PCG)
- ✅ Enhanced Input

Click **Restart Now** if asked.

## Project settings

Go to **Edit → Project Settings**:
- Under **Maps & Modes**: DefaultGameMode → create BP_PMTGameMode (Step 4)
- Under **Rendering**: 
  - ✅ Hardware Ray Tracing → Enable
  - ✅ Lumen → Enable
  - ✅ Nanite → Enable
  - ✅ Virtual Shadow Maps → Enable

**Next: [Step 3 — Create the World Map](03-create-world.md)**
