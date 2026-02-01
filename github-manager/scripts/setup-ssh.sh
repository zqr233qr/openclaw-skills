#!/bin/bash
# setup-ssh.sh - Configure SSH for GitHub

set -e

SSH_KEY_PATH="${1:-$HOME/.ssh/id_ed25519_89757}"
GITHUB_USER="${2:-zqr233qr}"

echo "🐙 GitHub SSH Setup"
echo "===================="

# Check if key exists
if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "📝 Generating new SSH key..."
    ssh-keygen -t ed25519 -C "89757@openclaw.local" -f "$SSH_KEY_PATH" -N ""
    echo ""
    echo "✅ SSH key generated: $SSH_KEY_PATH.pub"
else
    echo "✅ SSH key exists: $SSH_KEY_PATH"
fi

# Start SSH agent
echo ""
echo "🔐 Starting SSH agent..."
eval "$(ssh-agent -s)"

# Add key to agent
echo "📎 Adding key to agent..."
ssh-add "$SSH_KEY_PATH"

# Configure git to use SSH
echo ""
echo "⚙️ Configuring Git SSH command..."
git config --global core.sshCommand "ssh -i $SSH_KEY_PATH"

# Configure git user
echo ""
echo "👤 Configuring Git user..."
if [ -z "$(git config --global user.name)" ]; then
    git config --global user.name "89757"
fi
if [ -z "$(git config --global user.email)" ]; then
    git config --global user.email "89757@openclaw.local"
fi

# Output public key
echo ""
echo "🔑 Add this key to GitHub:"
echo "   https://github.com/settings/keys"
echo ""
cat "${SSH_KEY_PATH}.pub"
echo ""

# Test connection
echo "🧪 Testing connection..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH connection successful!"
else
    echo "⚠️ SSH connection test (check above key is added to GitHub)"
fi

echo ""
echo "✅ SSH setup complete!"
echo "📁 Key: $SSH_KEY_PATH"
