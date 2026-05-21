#!/bin/bash
# Initialise local git repo and push to GitHub
# Usage: bash scripts/init-repo.sh YOUR_GITHUB_USERNAME

USERNAME=${1:-YOUR_USERNAME}
REPO="pmt-metaverse"

git init
git lfs install
git add .
git commit -m "feat: initial PMT Chain Metaverse project"
git remote add origin "https://github.com/$USERNAME/$REPO.git"
git branch -M main
git push -u origin main

echo "Pushed to https://github.com/$USERNAME/$REPO"
echo ""
echo "Add these GitHub Secrets (repo Settings -> Secrets -> Actions):"
echo "  SERVER_HOST, SERVER_USER, SERVER_SSH_KEY"
echo "  DEPLOYER_PRIVATE_KEY, PMT_RPC_URL, PMT_CHAIN_ID, UE5_API_KEY"
