#!/bin/bash

echo "===== SYSTEM AUDIT & DIAGNOSTICS ====="

echo "🔍 Public IP:"
curl -s ifconfig.me
echo -e "\\n"

echo "🌐 DNS resolution for hr.ptc.edu.mv:"
nslookup hr.ptc.edu.mv || echo "❌ DNS resolution failed. Check your Cloudflare A record."
echo -e "\\n"

echo "🔧 Docker version check:"
docker version || { echo "❌ Docker not running or not installed."; exit 1; }
echo -e "\\n"

echo "🔧 Docker Compose version:"
docker compose version || { echo "❌ Docker Compose not available."; exit 1; }
echo -e "\\n"

echo "🔐 Docker permissions test (listing containers):"
if ! docker ps &> /dev/null; then
    echo "⚠️ Docker access denied. Add your user to the docker group using:"
    echo "    sudo usermod -aG docker \$USER && newgrp docker"
else
    docker ps
fi
echo -e "\\n"

echo "📡 Checking if Traefik container is running:"
if docker ps --format '{{.Names}}' | grep -q traefik; then
    echo "✅ Traefik is running. Last 20 log lines:"
    docker logs traefik --tail 20
else
    echo "⚠️ Traefik container not found or not running."
fi
echo -e "\\n"

echo "🧱 Checking firewall status and open ports:"
sudo ufw status

echo "===== LOCAL ENDPOINT TESTS ====="
echo "Testing HTTP on localhost (port 80):"
curl -v http://localhost

echo -e "\\nTesting HTTP via host's public DNS:"
curl -v http://hr.ptc.edu.mv

echo -e "\\n===== DIAGNOSTICS COMPLETE ====="
