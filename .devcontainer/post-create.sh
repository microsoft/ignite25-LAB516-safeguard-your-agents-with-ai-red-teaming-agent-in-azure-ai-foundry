#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# Install/Update Azure Developer CLI to latest version
echo "🔄 Installing/updating Azure Developer CLI (azd) to latest version..."
curl -fsSL https://aka.ms/install-azd.sh | bash

# Install Bicep CLI
echo "🔧 Installing Bicep CLI..."
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
bicep --version

# Install Python packages
echo "📚 Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Post-create setup complete!"
