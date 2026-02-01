# Complete Setup Guide

## Prerequisites

- Git installed
- GitHub Personal Access Token (PAT)
- SSH key added to GitHub (optional, for git operations)

## Step 1: Install Dependencies

### Linux (Ubuntu/Debian)
```bash
sudo apt update && sudo apt install -y git gh
```

### macOS
```bash
brew install git gh
```

## Step 2: Configure GitHub Token

### Create Token
1. Go to https://github.com/settings/tokens
2. Generate new token (classic):
   - Note: `openclaw-[hostname]`
   - Scopes: `repo`, `workflow`
   - Expiration: No expiration (or 90 days)

### Set Token
```bash
# Temporary (session only)
export GH_TOKEN="ghp_xxxxxxxxxxxx"

# Permanent
echo 'export GH_TOKEN="ghp_xxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc

# Verify
gh auth status
```

## Step 3: Configure SSH (Optional but Recommended)

### Check Existing SSH Key
```bash
ls -la ~/.ssh/
```

### Generate New SSH Key (if needed)
```bash
ssh-keygen -t ed25519 -C "89757@openclaw.local"
# Save to: ~/.ssh/id_ed25519_89757
# Passphrase: (optional, empty for automation)
```

### Add SSH Key to GitHub
```bash
# View public key
cat ~/.ssh/id_ed25519_89757.pub

# Add to: https://github.com/settings/keys
```

### Configure SSH Agent
```bash
# Add to ~/.bashrc for auto-load
cat >> ~/.bashrc << 'EOF'

# SSH Agent Auto-load
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null 2>&1
   ssh-add ~/.ssh/id_ed25519_89757 2>/dev/null
fi
EOF

# Apply
source ~/.bashrc

# Verify
ssh -T git@github.com
```

### Configure Git SSH Command
```bash
git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519_89757"
```

## Step 4: Configure Git User

```bash
git config --global user.name "89757"
git config --global user.email "89757@openclaw.local"
```

## Step 5: Verify Setup

```bash
# Git config
git config --global -l

# GitHub CLI auth
gh auth status

# SSH connection
ssh -T git@github.com

# Test clone
git clone git@github.com:zqr233qr/openclaw-skills.git
```

## Troubleshooting

### "gh: command not found"
```bash
# Linux
sudo apt install gh

# macOS
brew install gh
```

### "Permission denied (publickey)"
```bash
# Check if key is added
ssh-add -l

# Add key if missing
ssh-add ~/.ssh/id_ed25519_89757

# Test connection
ssh -T git@github.com
```

### "not logged into any GitHub hosts"
```bash
# Login with token
echo $GH_TOKEN | gh auth login --with-token

# Or login with SSH
gh auth login -h github.com -p ssh -w
```

### "Could not read from remote repository"
```bash
# Verify remote URL
git remote -v

# Should be: git@github.com:owner/repo.git
# If https://..., change to SSH
git remote set-url origin git@github.com:owner/repo.git
```

## Quick Setup Script

Run this for fresh installation:

```bash
#!/bin/bash
set -e

echo "Installing dependencies..."
sudo apt update && sudo apt install -y git gh

echo "Configuring Git..."
git config --global user.name "89757"
git config --global user.email "89757@openclaw.local"

echo "Setting up SSH..."
if [ ! -f ~/.ssh/id_ed25519_89757 ]; then
    ssh-keygen -t ed25519 -C "89757@openclaw.local" -f ~/.ssh/id_ed25519_89757 -N ""
fi
ssh-add ~/.ssh/id_ed25519_89757 2>/dev/null
git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519_89757"

echo "GitHub Public Key:"
cat ~/.ssh/id_ed25519_89757.pub
echo ""
echo "Add the above key to GitHub: https://github.com/settings/keys"

echo "Setup complete!"
```
