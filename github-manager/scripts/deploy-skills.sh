#!/bin/bash
# deploy-skills.sh - Deploy skills to OpenClaw from GitHub repository

set -e

REPO="${1:-zqr233qr/openclaw-skills}"
SKILLS_DIR="$HOME/openclaw-skills"
OPENCLAW_SKILLS_DIR="${2:-/root/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw/skills}"
BRANCH="${3:-main}"

echo "🚀 OpenClaw Skills Deployment"
echo "=============================="
echo "Repo: $REPO"
echo "Branch: $BRANCH"
echo "Target: $OPENCLAW_SKILLS_DIR"
echo ""

# Check GH_TOKEN
if [ -z "$GH_TOKEN" ]; then
    echo "❌ GH_TOKEN not set!"
    echo "Run: export GH_TOKEN=\"ghp_xxx\""
    exit 1
fi

# Clone or update repository
if [ -d "$SKILLS_DIR/.git" ]; then
    echo "📦 Updating existing skills repository..."
    cd "$SKILLS_DIR"
    git checkout "$BRANCH" 2>/dev/null || git checkout main
    git pull origin "$BRANCH"
else
    echo "📦 Cloning skills repository..."
    git clone "git@github.com:$REPO.git" "$SKILLS_DIR"
    cd "$SKILLS_DIR"
    git checkout "$BRANCH" 2>/dev/null || true
fi

echo ""
echo "📂 Skills available:"
ls -la "$SKILLS_DIR"

# Backup existing skills (if exists)
if [ -d "$OPENCLAW_SKILLS_DIR" ] && [ "$(ls -A $OPENCLAW_SKILLS_DIR 2>/dev/null)" ]; then
    BACKUP_DIR="$OPENCLAW_SKILLS_DIR.backup.$(date +%Y%m%d-%H%M%S)"
    echo ""
    echo "💾 Backing up existing skills to: $BACKUP_DIR"
    cp -r "$OPENCLAW_SKILLS_DIR" "$BACKUP_DIR"
fi

# Deploy skills
echo ""
echo "📤 Deploying skills to OpenClaw..."
mkdir -p "$OPENCLAW_SKILLS_DIR"
cp -r "$SKILLS_DIR"/* "$OPENCLAW_SKILLS_DIR/"

# Set permissions
chmod -R 755 "$OPENCLAW_SKILLS_DIR"/*

echo ""
echo "✅ Skills deployed successfully!"
echo ""
echo "📊 Deployed skills:"
ls -d "$OPENCLAW_SKILLS_DIR"/*/

echo ""
echo "🔄 Restart OpenClaw to load new skills:"
echo "   openclaw gateway restart"
