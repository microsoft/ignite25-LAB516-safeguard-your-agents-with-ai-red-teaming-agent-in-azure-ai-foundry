#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# Verify Azure Developer CLI version
echo "🔍 Verifying Azure Developer CLI (azd) version..."
INSTALLED_VERSION=$(azd version --output json 2>/dev/null | grep -o '"azd version [0-9.]*' | grep -o '[0-9.]*' || echo "0.0.0")
MINIMUM_VERSION="1.20.3"

# Compare versions (simple string comparison works for semantic versioning)
if [ "$(printf '%s\n' "$MINIMUM_VERSION" "$INSTALLED_VERSION" | sort -V | head -n1)" = "$MINIMUM__VERSION" ]; then
    echo "   ✅ Azure Developer CLI version is $INSTALLED_VERSION (>= $MINIMUM_VERSION)"
else
    echo "   ⚠️  Warning: Azure Developer CLI version $INSTALLED_VERSION is older than required $MINIMUM_VERSION"
    echo "   Consider updating the devcontainer feature or manually updating azd"
fi

# Install Python packages
echo "📚 Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Post-create setup complete!"
