---
name: github-manager
description: "Complete GitHub management: repository operations, skills deployment, multi-server sync. Use when: (1) Creating/cloning/pushing repositories, (2) Managing skills across multiple servers, (3) GitHub API operations (PR, issues, workflows), (4) Setting up new development environments, (5) Automating deployments."
metadata:
  openclaw:
    emoji: 🐙
    requires:
      bins: ["git", "gh"]
      env:
        - "GH_TOKEN"  # GitHub Personal Access Token
        - "GIT_SSH_COMMAND=ssh -i ~/.ssh/id_ed25519_1panel"
    install:
      - id: apt-git
        kind: apt
        package: git
        bins: ["git"]
        label: "Install Git (apt)"
      - id: apt-gh
        kind: apt
        package: gh
        bins: ["gh"]
        label: "Install GitHub CLI (apt)"
      - id: brew-git
        kind: brew
        formula: git
        bins: ["git"]
        label: "Install Git (brew)"
      - id: brew-gh
        kind: brew
        formula: gh
        bins: ["gh"]
        label: "Install GitHub CLI (brew)"
---

# GitHub Manager Skill

Comprehensive GitHub management with **SSH + Token** dual authentication.

## Quick Start

```bash
# Check setup status
github-manager --status

# Clone skills repository
github-manager clone-skills

# Deploy to current server
github-manager deploy

# Create new repository
github-manager create-repo my-project
```

## Dual Authentication

| Method | Use For | Setup |
|--------|---------|-------|
| **SSH** | Git clone/push/pull | `scripts/setup-ssh.sh` |
| **Token (PAT)** | GitHub API operations | `scripts/gh-auth.sh` |

Both can be used together for complete access.

## Core Commands

### Repository Operations
```bash
# Clone repository
github-manager clone owner/repo [local-name]

# Create new repository
github-manager create-repo repo-name [--private]

# Push local repo to GitHub
github-manager init-push "Initial commit message"
```

### Skills Management
```bash
# Clone skills to current server
github-manager clone-skills

# Deploy skills from repository
github-manager deploy

# Backup current skills
github-manager backup
```

### Development Workflow
```bash
# Start feature development
github-manager start-feature feature-name

# Create PR
github-manager create-pr "Feature name"

# Sync fork
github-manager sync-fork
```

## Multi-Server Deployment

See [DEPLOY.md](references/deploy.md) for complete deployment guide.

```bash
# On new server:
github-manager setup   # Configure SSH + GitHub CLI
github-manager clone-skills  # Get skills
github-manager deploy  # Install to OpenClaw
```

## See Also

- [SETUP.md](references/setup.md) - Complete setup guide
- [WORKFLOWS.md](references/workflows.md) - Common workflows
- [TROUBLESHOOTING.md](references/troubleshooting.md) - Problem solutions
