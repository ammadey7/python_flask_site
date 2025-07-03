#!/bin/bash

set -e  # Exit immediately if any command fails

# Step 1: Stop services
echo "🛑 Stopping Flask App..."
docker compose down || true

echo "🛑 Stopping Traefik..."
cd traefik
docker compose down || true
cd ..

# Step 2: Start services
echo "🚀 Starting Traefik..."
cd traefik
docker compose up -d
cd ..

echo "🚀 Starting Flask App..."
docker compose up -d

echo "✅ Stack restarted successfully."
