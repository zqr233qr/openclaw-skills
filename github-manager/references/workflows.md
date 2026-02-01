# Common Workflows

## 1. Start New Feature

```bash
# 1. Ensure main is up to date
github-manager sync-main

# 2. Create feature branch
github-manager start-feature feature-name

# 3. Work on feature...

# 4. Commit changes
git add .
git commit -m "feat: implement feature-name"

# 5. Push branch
git push -u origin feature-name

# 6. Create PR (optional)
gh pr create --title "Feature: feature-name" --body "Description"
```

## 2. Clone and Deploy Skills to New Server

```bash
# On new server:
# 1. Setup authentication
github-manager setup

# 2. Clone skills repository
github-manager clone-skills

# 3. Deploy to OpenClaw
github-manager deploy

# 4. Restart OpenClaw if needed
openclaw gateway restart
```

## 3. Update Skills from Repository

```bash
# Pull latest changes
github-manager update

# Or manually:
cd ~/openclaw-skills
git pull origin main
cp -r ~/openclaw-skills/* /path/to/openclaw/skills/
```

## 4. Create and Push New Skill

```bash
# 1. Create skill structure
mkdir -p skills/new-skill
cd skills/new-skill

# 2. Create SKILL.md
cat > SKILL.md << 'EOF'
---
name: new-skill
description: "Description of what the skill does."
metadata:
  openclaw:
    emoji: 🎯
    requires:
      bins: []
---

# New Skill

Instructions...
EOF

# 3. Initialize and push
github-manager init-push "Add new-skill"
```

## 5. Sync Fork with Upstream

```bash
# Add upstream (first time)
github-manager add-upstream original-owner/original-repo

# Sync
github-manager sync-fork
```

## 6. Create Release

```bash
# Create tag
github-manager create-tag v1.0.0

# Create release notes
gh release create v1.0.0 --title "Release v1.0.0" --notes "Release notes..."
```

## 7. Backup Skills

```bash
# Create timestamped backup
github-manager backup

# Push to GitHub backup branch
github-manager backup-push
```

## 8. Quick Status Check

```bash
# Check all in one
github-manager --status

# Output example:
# ✅ Git configured
# ✅ GitHub CLI authenticated
# ✅ SSH connected
# ✅ Skills synced: 2026-02-01 10:00
```
