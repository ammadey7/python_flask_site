#!/bin/bash

set -e  # Exit immediately if any command fails

# Step 1: Start Traefik
echo "🚀 Starting Traefik..."
cd traefik
docker compose up -d
cd ..

# Step 2: Start Main Flask App
echo "🚀 Starting Flask App..."
docker compose up -d

echo "✅ All services started successfully."
