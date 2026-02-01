---
name: git-manager
description: "Comprehensive Git and GitHub management with SSH authentication. Use for: (1) Cloning/pushing/pulling repositories via SSH, (2) Committing with 89757 identity, (3) Creating branches and managing workflows, (4) Managing skills and deploying across multiple servers, (5) GitHub operations when gh CLI is authenticated."
metadata:
  openclaw:
    emoji: 🔧
    requires:
      bins: ["git"]
      env:
        - "GIT_SSH_COMMAND=ssh -i ~/.ssh/id_ed25519_1panel"
    install:
      - id: apt
        kind: apt
        package: git
        bins: ["git"]
        label: "Install Git (apt)"
      - id: brew
        kind: brew
        formula: git
        bins: ["git"]
        label: "Install Git (brew)"
---

# Git Manager Skill

Manage Git repositories and GitHub operations with SSH-based authentication. Identity: `89757 <89757@openclaw.local>`

## Quick Start

```bash
# Verify setup
git-manager --status

# Clone a repository
git-manager clone owner/repo

# Push changes
git-manager push "Your commit message"
```

## SSH Configuration

This skill uses SSH key `~/.ssh/id_ed25519_1panel` for GitHub authentication.

### Auto-load SSH Agent

Add to `~/.bashrc` for persistent SSH agent:
```bash
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null 2>&1
   ssh-add ~/.ssh/id_ed25519_1panel 2>/dev/null
fi
```

### Manual SSH Agent Setup
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_1panel
ssh -T git@github.com  # Verify connection
```

## Git Operations

### Clone Repository
```bash
git clone git@github.com:owner/repo.git
# or with explicit SSH command
git -c core.sshCommand="ssh -i ~/.ssh/id_ed25519_1panel" clone git@github.com:owner/repo.git
```

### Commit and Push
```bash
# Add all changes
git add .

# Commit with 89757 identity
git commit -m "Your commit message"

# Push to current branch
git push origin $(git branch --show-current)
```

### Branch Management
```bash
# Create and switch to new branch
git checkout -b feature/my-feature

# Push new branch
git push -u origin $(git branch --show-current)

# List all branches
git branch -a

# Delete merged branch
git branch -d feature/my-feature
```

### Pull with Rebase
```bash
git pull --rebase origin $(git branch --show-current)
```

## Skill Management

### Create New Skill
```bash
mkdir -p skills/my-skill
cd skills/my-skill

# Create SKILL.md
cat > SKILL.md << 'EOF'
---
name: my-skill
description: "Brief description of what the skill does."
metadata:
  openclaw:
    emoji: 🎯
    requires:
      bins: []
---

# My Skill

Instructions for using this skill...
EOF
```

### Push Skill to GitHub
```bash
cd skills/my-skill

# Initialize git if needed
git init
git add .
git commit -m "Add my-skill"

# Add remote (first time)
git remote add origin git@github.com:yourname/openclaw-skills.git

# Push
git push -u origin main
```

### Sync Skills from GitHub
```bash
# Clone or update skills repository
git clone git@github.com:yourname/openclaw-skills.git ~/openclaw-skills
cd ~/openclaw-skills

# Pull latest changes
git pull origin main

# Copy to OpenClaw skills directory
cp -r ~/openclaw-skills/* /root/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw/skills/
```

## Multi-Server Deployment

### Deploy Skills to New Server

1. **SSH into new server**
2. **Install dependencies**
   ```bash
   sudo apt update && sudo apt install -y git
   ```
3. **Copy SSH key**
   ```bash
   mkdir -p ~/.ssh
   scp user@original-server:~/.ssh/id_ed25519_1panel user@new-server:~/.ssh/
   chmod 600 ~/.ssh/id_ed25519_1panel
   ```
4. **Clone skills repository**
   ```bash
   git clone git@github.com:yourname/openclaw-skills.git ~/openclaw-skills
   cd ~/openclaw-skills
   ```
5. **Install skills**
   ```bash
   cp -r ~/openclaw-skills/* /path/to/openclaw/skills/
   ```

### Backup Current Setup
```bash
# Archive skills
tar -czf openclaw-skills-backup-$(date +%Y%m%d).tar.gz /path/to/openclaw/skills/

# Or push to GitHub
cd /path/to/openclaw/skills
git add .
git commit -m "Backup $(date)"
git push
```

## GitHub API Operations (with gh CLI)

If `gh` CLI is authenticated:
```bash
# List repositories
gh repo list yourname

# Create repository
gh repo create new-repo --public --description "Description"

# View PR checks
gh pr checks --repo owner/repo

# List workflow runs
gh run list --repo owner/repo --limit 10
```

## Common Workflows

### Feature Development
```bash
# 1. Start from main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/my-feature

# 3. Work... (commit as needed)
git add .
git commit -m "Implement feature"

# 4. Push branch
git push -u origin feature/my-feature

# 5. Create PR (via GitHub UI or gh CLI)
gh pr create --title "My Feature" --body "Description"
```

### Hotfix
```bash
git checkout -b hotfix/critical-fix main
# ... fix ...
git add .
git commit -m "HOTFIX: Critical fix"
git push -u origin hotfix/critical-fix
# Create PR immediately
```

### Sync Fork
```bash
git remote add upstream git@github.com:original-owner/repo.git
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Troubleshooting

### SSH Permission Denied
```bash
# Verify SSH key is added
ssh-add -l

# Test GitHub connection
ssh -T git@github.com

# Add key if missing
ssh-add ~/.ssh/id_ed25519_1panel
```

### Detached HEAD
```bash
git checkout main
git pull
```

### Merge Conflicts
```bash
# See conflicts
git status

# Resolve: edit files, then
git add .
git commit -m "Resolve merge conflicts"
```

### Large File Issues
```bash
# Install git-lfs for large files
git lfs install

# Track large files
git lfs track "*.zip"
git add .gitattributes
```
