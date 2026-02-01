#!/bin/bash
# setup-gh.sh - Configure GitHub CLI with token
# Usage: ./setup-gh.sh [TOKEN]

set -e

TOKEN="${1:-$GH_TOKEN}"

echo "🐙 GitHub CLI Setup"
echo "===================="

# Check if token provided
if [ -z "$TOKEN" ]; then
    echo "❌ No token provided!"
    echo "Usage: ./setup-gh.sh [TOKEN]"
    echo ""
    echo "Generate token at: https://github.com/settings/tokens"
    echo "Required scopes: repo, workflow"
    exit 1
fi

# Set token for current session
export GH_TOKEN="$TOKEN"

# Store in .bashrc for persistence (but only once)
echo ""
echo "📝 Storing token in ~/.bashrc..."
if ! grep -q "export GH_TOKEN=" ~/.bashrc 2>/dev/null; then
    echo "export GH_TOKEN=\"$TOKEN\"" >> ~/.bashrc
    echo "✅ Token saved to ~/.bashrc"
else
    echo "⚠️ Token already exists in ~/.bashrc"
fi

# Use gh auth login to store token securely
echo ""
echo "🔐 Authenticating with GitHub CLI..."
echo "$TOKEN" | gh auth login --with-token

# Verify auth
echo ""
echo "🔐 Verifying GitHub authentication..."
gh auth status

echo ""
echo "✅ GitHub CLI setup complete!"
