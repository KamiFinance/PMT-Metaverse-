#!/bin/bash
# PMT Metaverse GPU Server Setup — Ubuntu 22.04
# Run as root: sudo bash server-setup.sh

set -e
echo "=== PMT Metaverse Server Setup ==="

apt-get update -y && apt-get install -y curl git unzip wget build-essential

# Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs
npm install -g pm2
pm2 startup systemd -u ubuntu --hp /home/ubuntu

# Docker
curl -fsSL https://get.docker.com | bash
usermod -aG docker ubuntu
systemctl enable docker

# NVIDIA drivers for UE5 rendering
apt-get install -y ubuntu-drivers-common
ubuntu-drivers autoinstall
apt-get install -y nvidia-cuda-toolkit

# Git LFS for UE5 assets
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt-get install -y git-lfs && git lfs install

# Nginx
apt-get install -y nginx
cat > /etc/nginx/sites-available/pmt <<NGINX
server {
  listen 80;
  location / {
    proxy_pass http://localhost:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
  }
  location /api/ { proxy_pass http://localhost:4000/; }
  location /ws    {
    proxy_pass http://localhost:4000/ws;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
NGINX
ln -sf /etc/nginx/sites-available/pmt /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

ufw allow 22/tcp && ufw allow 80/tcp && ufw allow 443/tcp
ufw allow 8888/tcp && ufw allow 19302/udp && ufw --force enable

echo "=== Setup complete — reboot then install UE5 ==="
