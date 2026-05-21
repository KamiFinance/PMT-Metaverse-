# PMT Chain Metaverse
> Photorealistic metaverse on PMT Chain (ChainID: 290290) — powered by Unreal Engine 5

[![Deploy Bridge API](https://github.com/YOUR_USERNAME/pmt-metaverse/actions/workflows/deploy-bridge-api.yml/badge.svg)](https://github.com/YOUR_USERNAME/pmt-metaverse/actions/workflows/deploy-bridge-api.yml)
[![Test Contracts](https://github.com/YOUR_USERNAME/pmt-metaverse/actions/workflows/test-contracts.yml/badge.svg)](https://github.com/YOUR_USERNAME/pmt-metaverse/actions/workflows/test-contracts.yml)

## What is this?

A fully on-chain metaverse where:
- Land parcels (2,048 total) are NFTs on PMT Chain
- Avatars with on-chain traits are MetaHuman characters in Unreal Engine 5
- Players open a browser — no game download needed (UE5 Pixel Streaming)
- All transactions use PMT (native token of PMT Chain)

## Repository structure

```
pmt-metaverse/
├── contracts/              Smart contracts (Solidity + Hardhat)
│   ├── contracts/          PMTLand, PMTAvatar, PMTMarketplace, PMTEvents
│   └── scripts/deploy.js   Master deploy script
│
├── bridge-api/             Node.js API — UE5 ↔ PMT Chain bridge
│   ├── server.js           Express + WebSocket server
│   └── routes/             /world, /transactions, /events
│
├── pixel-streaming/        Browser interface
│   ├── web-client/         HTML + MetaMask overlay
│   └── signaling/          WebRTC signaling server config
│
├── ue5-project/            Unreal Engine 5 project
│   ├── Config/             Engine + game settings (Nanite, Lumen, RT on)
│   └── Content/Blueprints/ Blueprint documentation
│
├── docs/ue5-guide/         Step-by-step UE5 guide (no developer needed)
│   ├── 01-install.md       Install UE5
│   ├── 02-open-project.md  Open this project
│   ├── 03-create-world.md  Build the world map
│   ├── 04-blueprints.md    Create visual scripts
│   ├── 05-materials.md     PBR materials
│   ├── 06-avatars.md       MetaHuman avatars
│   ├── 07-pixel-streaming.md Stream to browser
│   ├── 08-blockchain.md    Connect to PMT Chain
│   └── 09-procedural-city.md Auto-generate city
│
├── scripts/
│   ├── server-setup.sh     One-click GPU server setup
│   └── init-repo.sh        Push to GitHub
│
├── .github/workflows/      CI/CD automation
│   ├── deploy-bridge-api.yml
│   ├── deploy-web-client.yml
│   ├── deploy-contracts.yml
│   ├── test-contracts.yml
│   └── server-setup.yml
│
└── docker-compose.yml      Full stack (bridge-api + signaling + nginx)
```

## Quick Start

### 1 — Clone and push to YOUR GitHub

```bash
git clone https://github.com/YOUR_USERNAME/pmt-metaverse.git
cd pmt-metaverse
bash scripts/init-repo.sh YOUR_USERNAME
```

### 2 — Set GitHub Secrets

Go to your repo on GitHub → **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Value |
|--------|-------|
| `SERVER_HOST` | Your GPU server IP address |
| `SERVER_USER` | `ubuntu` (or your username) |
| `SERVER_SSH_KEY` | Your SSH private key (paste the whole key) |
| `DEPLOYER_PRIVATE_KEY` | Wallet private key for contract deployment |
| `PMT_RPC_URL` | `https://node1-ipm.dweb3.wtf` |
| `PMT_CHAIN_ID` | `290290` |
| `UE5_API_KEY` | Any random secret string |

### 3 — Deploy contracts

Go to **GitHub → Actions → Deploy Smart Contracts → Run workflow**
- Network: `pmtchain`
- Confirm: type `DEPLOY`

Contract addresses are saved automatically to GitHub Secrets.

### 4 — Set up GPU server

Get a GPU server from AWS (g4dn.xlarge ~$0.53/hr) or any cloud.

Then run: **GitHub → Actions → Initial Server Setup → Run workflow**
(paste your server IP)

### 5 — Start bridge API

**GitHub → Actions → Deploy Bridge API → Run workflow**

Or locally:
```bash
cd bridge-api && npm install
cp .env.example .env   # fill in contract addresses
npm start              # → http://localhost:4000
```

### 6 — Build UE5

Follow the step-by-step guide: **[docs/ue5-guide/01-install.md](docs/ue5-guide/01-install.md)**

No UE5 experience needed — every step is explained with screenshots and node-by-node Blueprint instructions.

### 7 — Launch

```bash
docker-compose up    # starts signaling server + bridge API
# Launch UE5 game
# Open browser → http://YOUR_SERVER_IP
```

## PMT Chain Configuration

| Property | Value |
|---|---|
| Chain ID | 290290 |
| RPC URL | https://node1-ipm.dweb3.wtf |
| Native Token | PMT |
| Land parcels | 2,048 (64×32 grid) |
| Avatar supply | 10,000 |

## UE5 Visual Quality

| Technology | Effect |
|---|---|
| Nanite | Zero visible polygons at any distance |
| Lumen | Real-time global illumination + reflections |
| Virtual Shadow Maps | Ultra-sharp shadows at all distances |
| MetaHuman | Film-quality photorealistic avatars |
| Hardware Ray Tracing | Optional — maximum realism |
| Temporal Super Resolution | 4K quality at half rendering cost |

## Contributing

See [GitHub Issues](issues) for the current task list. Each issue is tagged with:
- `contracts` — Solidity work
- `bridge-api` — Node.js work  
- `ue5` — Unreal Engine work
- `web-client` — Browser overlay work

## Need help?

Open an issue or ask directly in [Discussions](discussions).
For UE5 questions, see the [step-by-step guide](docs/ue5-guide/).
