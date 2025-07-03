#!/bin/bash

set -e  # Exit on any error

# Define ACME file path
ACME_FILE="./traefik/letsencrypt/acme.json"

echo "🛑 Stopping Flask App..."
docker compose down || true

echo "🛑 Stopping Traefik..."
cd traefik
docker compose down || true


# Step 1: Clean up acme.json
echo "🧹 Removing old acme.json..."
rm -f "$ACME_FILE"

echo "📝 Recreating acme.json..."
touch "$ACME_FILE"
chmod 600 "$ACME_FILE"

# Step 2: Start stack
echo "🚀 Starting Traefik..."
cd traefik
docker compose up -d
cd ..

echo "🚀 Starting Flask App..."
docker compose up -d

echo "✅ Stack fully restarted with fresh ACME config."
