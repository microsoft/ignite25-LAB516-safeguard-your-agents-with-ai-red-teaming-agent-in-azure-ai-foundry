#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# Install uv
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv to PATH for this session (uv installs to ~/.local/bin)
export PATH="$HOME/.local/bin:$PATH"

# Install Python packages using uv (using sudo for system-wide installation)
echo "📚 Installing Python dependencies with uv..."
sudo $HOME/.local/bin/uv pip install --system -r requirements.txt

echo "✅ Post-create setup complete!"
