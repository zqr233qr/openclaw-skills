# Troubleshooting Guide

## SSH Issues

### "Permission denied (publickey)"

```bash
# Check SSH agent
ssh-add -l

# If empty, add key
ssh-add ~/.ssh/id_ed25519_89757

# Test connection
ssh -T git@github.com
```

### "Could not open a connection to your authentication agent"

```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519_89757
```

### SSH key not working after reboot

```bash
# Add to bashrc for auto-load
cat >> ~/.bashrc << 'EOF'

if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null 2>&1
   ssh-add ~/.ssh/id_ed25519_89757 2>/dev/null
fi
EOF

source ~/.bashrc
```

## GitHub CLI Issues

### "You are not logged into any GitHub hosts"

```bash
# Login with token
echo $GH_TOKEN | gh auth login --with-token

# Or login with web browser
gh auth login -h github.com -p ssh -w
```

### "gh: command not found"

```bash
# Linux
sudo apt install gh

# macOS
brew install gh
```

### Token expired or revoked

```bash
# Generate new token: https://github.com/settings/tokens
# Update token
export GH_TOKEN="ghp_new_token_here"
echo 'export GH_TOKEN="ghp_new_token_here"' >> ~/.bashrc
```

## Git Operations

### "Could not read from remote repository"

```bash
# Check remote URL
git remote -v

# Should be SSH format:
# origin  git@github.com:owner/repo.git (fetch)

# If HTTPS, change to SSH
git remote set-url origin git@github.com:owner/repo.git
```

### Detached HEAD

```bash
# Go to main branch
git checkout main

# Pull latest
git pull
```

### Merge Conflicts

```bash
# See conflicted files
git status

# View conflicts
git diff

# Resolve (edit files), then:
git add .
git commit -m "Resolve merge conflicts"
```

### "Nothing to commit, working tree clean"

```bash
# Check current branch
git branch

# Pull latest changes
git pull origin $(git branch --show-current)
```

## Multi-Server Deployment

### Skills not appearing after deploy

```bash
# Check if skills were copied
ls /path/to/openclaw/skills/

# Check OpenClaw logs
openclaw logs

# Restart gateway
openclaw gateway restart
```

### SSH key not working on new server

```bash
# Copy key to new server
scp ~/.ssh/id_ed25519_89757 user@new-server:~/.ssh/

# Set permissions
chmod 600 ~/.ssh/id_ed25519_89757

# Test connection
ssh -T git@github.com
```

### Repository not found on new server

```bash
# Check GitHub token on new server
gh auth status

# Re-authenticate if needed
echo $GH_TOKEN | gh auth login --with-token
```

## OpenClaw Specific

### Skills not loading

```bash
# Check skill structure
ls -la /path/to/openclaw/skills/github-manager/

# Verify SKILL.md
head -5 /path/to/openclaw/skills/github-manager/SKILL.md

# Restart OpenClaw
openclaw gateway restart
```

### Permission denied on skill files

```bash
# Fix permissions
sudo chown -R $USER:$USER /path/to/openclaw/skills/
chmod -R 755 /path/to/openclaw/skills/
```

## Debug Commands

```bash
# Full status check
echo "=== Git Config ==="
git config --global -l

echo "=== GitHub Auth ==="
gh auth status 2>&1 || echo "Not authenticated"

echo "=== SSH ==="
ssh -T git@github.com 2>&1

echo "=== Remote ==="
git remote -v

echo "=== Token ==="
echo "GH_TOKEN set: $([ -n "$GH_TOKEN" ] && echo 'Yes' || echo 'No')"
```
