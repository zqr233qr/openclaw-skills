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

# 3. Start Claude Code
cd your-project
claude

# 4. In Claude Code, create a new change
/opsx:new feature-name -m "Description of what to build"

# 5. Generate all planning docs in one command
/opsx:ff

# 6. Implement
/opsx:apply

# 7. Archive when done
/opsx:archive
```

## Installation

### Prerequisites
- Node.js 20.19.0 or higher
- npm (comes with Node.js)
- Claude Code installed

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

### Phase 4: Archive
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

### 4. Context Hygiene
OpenSpec benefits from clean context:
- Clear context before starting implementation
- Avoid mixing concerns in one change
- Archive completed changes promptly

### 5. Verify Implementation
After `/opsx:apply`, use `/opsx:verify` to ensure implementation matches specs.

## Troubleshooting

### Command Not Found
Ensure OpenSpec is initialized:
```bash
openspec init --tools claude
```

### Slash Commands Not Working
Restart Claude Code after initialization:
```bash
# Exit Claude Code and restart
claude
```

### Permission Issues
OpenSpec may ask for file permissions. Select "Yes, and don't ask again" to avoid repeated prompts.

### Lost Progress
Use Claude Code's continue feature:
```bash
claude --continue
```

## Example: Complete Workflow

```bash
# Terminal 1: Start project
cd my-app
npm install -g @fission-ai/openspec
openspec init --tools claude
claude

# In Claude Code:
/opsx:new user-auth -m "Implement user authentication with email/password and JWT tokens. Include login, logout, and session management. Use bcrypt for password hashing."

# OpenSpec creates proposal and asks for confirmation
# Review proposal, then confirm

/opsx:ff
# OpenSpec generates: proposal, specs, design, tasks

# Review all artifacts
# Make any necessary edits

/opsx:apply
# Claude Code implements all tasks
# Updates tasks.md as completed

# When done
/opsx:archive

# Start next feature
/opsx:new add-profile-page -m "Create user profile page with avatar upload"
```

## Comparison: OpenSpec vs Spec Kit

| Feature | OpenSpec | Spec Kit |
|---------|----------|----------|
| Installation | npm (one command) | Python + pip |
| Interactive prompts | Minimal | Many confirmations |
| Artifacts | proposal, specs, design, tasks | spec, plan, tasks |
| CLI | `openspec` | `specify` |
| AI support | 20+ tools | Primarily Claude |
| Workflow speed | Fast (one command) | Slower (step-by-step) |

## See Also

- [OpenSpec GitHub](https://github.com/Fission-AI/OpenSpec)
- [OpenSpec Docs](https://github.com/Fission-AI/OpenSpec/tree/main/docs)
