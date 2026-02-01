---
name: openspec-dev
description: "Spec-Driven Development using OpenSpec with Claude Code. Use when: (1) Starting new projects with structured planning, (2) Creating feature specifications with proposal → specs → design → tasks workflow, (3) Implementing features using /opsx:apply, (4) Managing complex projects with AI assistance, (5) Need consistent development methodology across projects."
metadata:
  openclaw:
    emoji: 📋
    requires:
      bins: ["node", "npm"]
      npm: ["@fission-ai/openspec"]
    install:
      - id: openspec
        kind: npm
        package: "@fission-ai/openspec@latest"
        bins: ["openspec"]
        label: "Install OpenSpec (npm)"
---

# OpenSpec Dev Skill

Spec-Driven Development using OpenSpec with Claude Code for structured, AI-assisted project development.

## Quick Start

```bash
# 1. Install OpenSpec
npm install -g @fission-ai/openspec@latest

# 2. Initialize project
cd your-project
openspec init --tools claude

# 3. Start Claude Code in tmux session
tmux new -s <session-name>
cd your-project
claude

# 4. In Claude Code, create a new change
/opsx:new feature-name -m "Description of what to build"

# 5. Generate all planning docs in one command
/opsx:ff

# 6. Implement
/opsx:apply

# 7. Deploy to server (223.109.141.179:8080)
/opsx:deploy

# 8. Archive when done
/opsx:archive
```

## Server Environment

**Production Server**: `223.109.141.179:8080`

**Deployment Method**:
```bash
# Deploy static site to server port 8080
cd /root/.openclaw/workspace/your-project
python3 -m http.server 8080

# Or use pm2 for production
pm2 start "python3 -m http.server 8080" --name "your-project"
```

**Development Pattern**:
- All projects deployed to `223.109.141.179:8080`
- Each project in `/root/.openclaw/workspace/` directory
- Restart server after changes:
  ```bash
  pkill -f "http.server 8080"
  python3 -m http.server 8080 &
  ```

## Installation

### Prerequisites
- Node.js 20.19.0 or higher
- npm (comes with Node.js)
- Claude Code installed
- tmux (recommended for session management)

### Install OpenSpec
```bash
# Global install (recommended)
npm install -g @fission-ai/openspec@latest

# Verify installation
openspec --version
```

### Initialize Project
```bash
cd your-project
openspec init --tools claude
```

This creates:
- `.claude/commands/opsx/` - Slash command definitions
- `openspec/` - OpenSpec configuration

## Workflow

### Phase 1: Create Change
```
/opsx:new <change-name> -m "<description>"
```

Example:
```
/opsx:new add-dark-mode -m "Add dark mode support to the application with system preference detection"
```

This creates: `openspec/changes/<change-name>/`

### Phase 2: Generate Planning Docs
```
/opsx:ff  # fast-forward
```

This generates all 4 artifacts:
1. **proposal.md** - Why we're doing this, what changes
2. **specs/** - Detailed requirements for each capability
3. **design.md** - Technical approach and architecture
4. **tasks.md** - Implementation checklist

### Phase 3: Implement
```
/opsx:apply
```

Claude Code will:
- Read the tasks.md
- Execute tasks in order
- Update tasks.md as completed
- Report progress

### Phase 4: Deploy
```
/opsx:deploy
```

Deploys to server `223.109.141.179:8080`:
```bash
# Updates running server
pkill -f "http.server 8080"
cd /root/.openclaw/workspace/your-project
python3 -m http.server 8080 &
```

### Phase 5: Archive
```
/opsx:archive
```

Moves completed change to `openspec/changes/archive/` for historical reference.

## OpenSpec Commands

### Core Commands

| Command | Description |
|---------|-------------|
| `/opsx:new <name>` | Create new change |
| `/opsx:ff` | Fast-forward: generate all planning docs |
| `/opsx:apply` | Implement tasks from tasks.md |
| `/opsx:deploy` | Deploy to server (223.109.141.179:8080) |
| `/opsx:archive` | Archive completed change |
| `/opsx:continue` | Create next artifact in sequence |
| `/opsx:sync` | Sync agent context with OpenSpec |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/opsx:verify` | Verify implementation against specs |
| `/opsx:explore` | Explore codebase for patterns |
| `/opsx:bulk-archive` | Archive multiple changes |
| `/opsx:onboard` | Re-initialize OpenSpec in project |

## Project Structure

```
project/
├── openspec/
│   ├── changes/
│   │   ├── <change-name>/
│   │   │   ├── proposal.md
│   │   │   ├── design.md
│   │   │   ├── tasks.md
│   │   │   └── specs/
│   │   │       └── <capability>/
│   │   │           └── spec.md
│   │   └── archive/
│   │       └── <date>-<change-name>/
│   └── templates/
├── .claude/
│   └── commands/
│       └── opsx/
│           ├── apply.md
│           ├── archive.md
│           ├── deploy.md
│           ├── ff.md
│           ├── new.md
│           └── ...
└── (your application code)
```

## Artifact Templates

### proposal.md
```markdown
## Why
[Explain the motivation - problem statement or opportunity]

## What Changes
- [List key changes]
- [Use bullet points]

## Capabilities
### New Capabilities
- `capability-name`: Description

### Modified Capabilities
- `existing-capability`: What changed

## Impact
- [Technical impact]
- [Scope]
- [Dependencies]
```

### spec.md
```markdown
## <Capability Name>

### Description
[What this capability does]

### Scenarios
#### Scenario: <name>
- **WHEN** [condition]
- **THEN** [expected outcome]
- **AND** [additional outcome]
```

### design.md
```markdown
## Architecture
[High-level design]

## Tech Stack
- [Technologies used]

## Data Model
[Data structures]

## APIs/Interfaces
[How components interact]

## Implementation Details
[Step-by-step approach]
```

### tasks.md
```markdown
## Phase <N>: <Phase Name>

- [ ] Task description
  **File**: `path/to/file`
  **Priority**: P0/P1/P2
  **Dependencies**: Task numbers
  **Verification**: How to verify
```

## Best Practices

### 1. One Change Per Feature
Keep changes focused and atomic. Each change should implement one feature or improvement.

### 2. Detailed Descriptions
When creating changes, be specific about requirements. The better the spec, the better the implementation.

```bash
# Good - specific
/opsx:new add-dark-mode -m "Add dark mode with system preference detection, manual toggle, and localStorage persistence. Use CSS custom properties."

# Avoid - vague
/opsx:new add-dark-mode -m "Add dark mode"
```

### 3. Review Before Apply
Before running `/opsx:apply`:
1. Review proposal.md for completeness
2. Review specs for requirements
3. Review design for feasibility
4. Review tasks for ordering

### 4. Context Management
OpenSpec benefits from clean context:
- Use tmux for separate project sessions
- Clear context before starting implementation
- Avoid mixing concerns in one change
- Archive completed changes promptly
- Monitor Claude Code context length

### 5. Server Deployment
- Always deploy to `223.109.141.179:8080`
- Use `python3 -m http.server 8080` for static sites
- Kill and restart server after changes
- Verify with `curl http://localhost:8080`

### 6. Verify Implementation
After `/opsx:apply`, use `/opsx:verify` to ensure implementation matches specs.

## Lessons Learned (X-Diary Project)

### Process Flow
1. `cd <project-directory>`
2. `tmux new -s <session-name>`
3. `openspec init --tools claude`
4. `claude`
5. `/opsx:new <name> -m "<desc>"`
6. `/opsx:ff`
7. `/opsx:apply`
8. Deploy to server
9. `/opsx:archive`

### Common Pitfalls

| Issue | Solution |
|-------|----------|
| OpenSpec in wrong directory | Always `cd` to project first |
| Confusing OpenSpec vs Spec Kit | Use OpenSpec only (`/opsx:`) |
| Multiple tmux sessions | Name sessions clearly: `tmux new -s x-diary` |
| File permission errors | `chmod 644 <file>` |
| Tasks not updating | Manually check `tasks.md` |
| Context overflow | Archive changes, use `--continue` |
| Server offline | Restart: `python3 -m http.server 8080 &` |
| SVG vs PNG icons | SVG preferred for PWA (lossless, scalable) |

### Tmux Commands
```bash
tmux new -s <name>        # Create session
tmux ls                   # List sessions
tmux attach -t <name>     # Attach to session
Ctrl+B, D                 # Detach from session
tmux kill-session -t <name>  # Delete session
```

## Example: Complete Workflow

```bash
# Terminal 1: Start project
cd /root/.openclaw/workspace/x-diary
tmux new -s xdiary
openspec init --tools claude
claude

# In Claude Code:
/opsx:new user-auth -m "Implement user authentication with email/password and JWT tokens"

# OpenSpec creates proposal
# Review proposal, then confirm

/opsx:ff
# OpenSpec generates: proposal, specs, design, tasks

# Review all artifacts
# Make any necessary edits

/opsx:apply
# Claude Code implements all tasks
# Updates tasks.md as completed

# Deploy to server
/opsx:deploy

# Archive
/opsx:archive

# Start next feature
/opsx:new add-profile-page -m "Create user profile page with avatar upload"
```

## Server Deployment

### Quick Deploy
```bash
# Kill existing server
pkill -f "http.server 8080"

# Start new server
cd /root/.openclaw/workspace/your-project
python3 -m http.server 8080 &

# Verify
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/
# Should output: 200
```

### Using PM2 (Production)
```bash
# Install pm2
npm install -g pm2

# Start service
pm2 start "python3 -m http.server 8080" --name "your-project"

# Restart after changes
pm2 restart your-project
```

### Access
- **URL**: http://223.109.141.179:8080
- **Server**: SSH access for management

## Comparison: OpenSpec vs Spec Kit

| Feature | OpenSpec | Spec Kit |
|---------|----------|----------|
| Installation | npm (one command) | Python + pip |
| Interactive prompts | Minimal | Many confirmations |
| Artifacts | proposal, specs, design, tasks | spec, plan, tasks |
| CLI | `openspec` | `specify` |
| AI support | 20+ tools | Primarily Claude |
| Workflow speed | Fast (one command) | Slower (step-by-step) |
| Deployment | Server-focused | Generic |

## See Also

- [OpenSpec GitHub](https://github.com/Fission-AI/OpenSpec)
- [OpenSpec Docs](https://github.com/Fission-AI/OpenSpec/tree/main/docs)
- Claude Code documentation

## Key Reminders

1. **Server IP**: `223.109.141.179`
2. **Port**: `8080`
3. **Project Directory**: `/root/.openclaw/workspace/`
4. **Session Management**: Use tmux
5. **Always deploy** before archiving
