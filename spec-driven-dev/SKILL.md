---
name: spec-driven-dev
description: "Spec-Driven Development using GitHub Spec Kit with Claude Code. Use when: (1) Setting up structured development projects, (2) Creating feature specifications with constitutions, plans, and tasks, (3) Following systematic SDD workflow: /speckit.constitution → /speckit.specify → /speckit.plan → /speckit.tasks → /speckit.implement, (4) Managing AI-assisted development with quality gates, (5) Creating reproducible development processes."
metadata:
  openclaw:
    emoji: 📋
    requires:
      bins: ["git", "claude"]
      python: ["specify-cli"]
    install:
      - id: spec-kit
        kind: pip
        package: "git+https://github.com/github/spec-kit.git"
        label: "Install Spec Kit (specify-cli)"
      - id: claude-code
        kind: brew
        formula: claude-code
        bins: ["claude"]
        label: "Install Claude Code (brew)"
---

# Spec-Driven Development Skill

Use GitHub Spec Kit to enable structured, AI-assisted development with quality gates and systematic workflows.

## Quick Start

```bash
# Create new spec-driven project
spec-init my-project --ai claude

# Or initialize in current directory
spec-init . --ai claude

# Then in Claude Code, use slash commands:
/speckit.constitution      # Create project principles
/speckit.specify           # Define what to build
/speckit.plan              # Technical implementation plan
/speckit.tasks             # Generate actionable tasks
/speckit.implement         # Execute implementation
```

## Prerequisites

### Required Tools

| Tool | Install Command |
|------|-----------------|
| Git | `sudo apt install git` (Linux) / `brew install git` (macOS) |
| Claude Code | `brew install claude-code` (macOS) or download from [claude.com](https://claude.com) |
| Python 3.11+ | Pre-installed on most systems |
| uv (recommended) | `curl -Ls https://astral.sh/uv/install.sh \| sh` |

### Install Spec Kit

```bash
# Using uv (recommended)
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Or using pip with venv
python3 -m venv ~/.spec-venv
source ~/.spec-venv/bin/activate
pip install git+https://github.com/github/spec-kit.git

# Verify installation
specify --help
```

## Core Workflow

### Step 1: Initialize Project

```bash
# Create new project
specify init my-feature --ai claude

# Or for current directory
specify init . --ai claude

# Skip git initialization
specify init . --ai claude --no-git

# Force merge into existing directory
specify init . --force --ai claude
```

### Step 2: Establish Constitution (/speckit.constitution)

The constitution defines project principles and governance:

```
/speckit.constitution Create principles focused on:
- Code quality standards
- Testing requirements
- User experience consistency
- Performance requirements
```

**Constitution Template** (`.specify/memory/constitution.md`):

```markdown
# [PROJECT_NAME] Constitution

## Core Principles

### I. Quality Standards
All code MUST meet quality gates before merge...

### II. Testing Discipline
TDD mandatory: Tests → Approval → Fail → Implement...

### III. User Experience
Consistent design patterns across all features...

## Governance
- Amendments require documentation
- Version bumping according to semantic rules
```

### Step 3: Create Specification (/speckit.specify)

Define what to build (focus on WHAT and WHY, not HOW):

```
/speckit.specify Build a task management application with:
- Kanban boards with drag-and-drop
- User authentication
- Real-time collaboration
- Multiple workspaces per user
```

This creates `.specs/[feature-name]/spec.md` with user stories.

### Step 4: Clarify Requirements (/speckit.clarify)

Before planning, clarify ambiguous areas:

```
/speckit.clarify Ask about:
- Drag-and-drop implementation details
- Real-time sync mechanism
- User permission levels
```

### Step 5: Create Technical Plan (/speckit.plan)

Define the tech stack and architecture:

```
/speckit.plan Use:
- Frontend: React with TypeScript
- Backend: Go with Gin framework
- Database: PostgreSQL
- Real-time: WebSocket
- Auth: OAuth 2.0
```

This creates `.specs/[feature-name]/plan.md` with implementation details.

### Step 6: Generate Tasks (/speckit.tasks)

Break down the plan into actionable tasks:

```
/speckit.tasks
```

Creates `.specs/[feature-name]/tasks.md` with:
- Task breakdown by user story
- Dependency management
- Parallel execution markers
- File path specifications

### Step 7: Implement (/speckit.implement)

Execute the implementation:

```
/speckit.implement
```

Validates prerequisites and executes tasks in order.

## Available Slash Commands

### Core Commands

| Command | Purpose |
|---------|---------|
| `/speckit.constitution` | Create/update project principles |
| `/speckit.specify` | Define feature requirements |
| `/speckit.plan` | Create technical implementation plan |
| `/speckit.tasks` | Generate actionable task breakdown |
| `/speckit.implement` | Execute implementation |

### Optional Commands

| Command | Purpose |
|---------|---------|
| `/speckit.clarify` | Structured clarification before planning |
| `/speckit.analyze` | Cross-artifact consistency analysis |
| `/speckit.checklist` | Quality checklist generation |

## Project Structure

```
my-project/
├── .claude/
│   ├── CLAUDE.md              # Agent context
│   └── commands/              # Slash command definitions
│       └── speckit.*.md
├── .specify/
│   ├── memory/
│   │   └── constitution.md    # Project principles
│   ├── scripts/
│   │   └── bash/              # Utility scripts
│   ├── specs/
│   │   └── [feature-name]/
│   │       ├── spec.md        # Feature specification
│   │       ├── plan.md        # Implementation plan
│   │       ├── tasks.md       # Task breakdown
│   │       └── research.md    # Research notes
│   └── templates/
│       ├── spec-template.md
│       ├── plan-template.md
│       └── tasks-template.md
├── CLAUDE.md                  # Project README for agent
└── (your application code)
```

## Best Practices

### 1. Always Start with Constitution

```bash
# In Claude Code
/speckit.constitution Define principles for code quality, testing, and user experience
```

### 2. Be Explicit in Specifications

**Good**:
```
/speckit.specify Users can create Kanban boards with unlimited columns.
Each card shows title, description, assignee, and due date.
Drag cards between columns updates status in real-time.
```

**Avoid**:
```
/speckit.specify Make a task manager app
```

### 3. Use Clarification Before Planning

```
# First clarify
/speckit.clarify Should real-time sync use WebSocket or polling?
What's the maximum number of users per board?

# Then plan
/speckit.plan Use WebSocket for real-time updates...
```

### 4. Validate Plans Before Implementation

```
# Ask Claude Code to audit the plan
Review the implementation plan for missing steps or edge cases.
```

### 5. Follow Task Order

Tasks are ordered for a reason:
- Models before services
- Services before endpoints
- Tests before implementation (if TDD)

## Troubleshooting

### Slash Commands Not Available

```bash
# Ensure project was initialized with specify init
specify check  # Verify tools

# Restart Claude Code in project directory
cd my-project
claude
```

### Spec Kit Installation Issues

```bash
# Try uv tool install
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Or use virtual environment
python3 -m venv .spec-venv
source .spec-venv/bin/activate
pip install git+https://github.com/github/spec-kit.git
```

### Git Credential Issues

```bash
# Install Git Credential Manager (Linux)
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
sudo dpkg -i gcm-linux_amd64.2.6.1.deb
git config --global credential.helper manager
```

## Example: Complete Feature Development

```bash
# 1. Initialize project
specify init kanban-app --ai claude
cd kanban-app

# 2. In Claude Code:
/speckit.constitution Create principles focused on code quality, testing, and performance

/speckit.specify Build a Kanban board where users can:
- Create boards with custom columns
- Add cards with title, description, and tags
- Drag cards between columns
- Assign cards to team members

/speckit.clarify Should cards support attachments? What's the max cards per board?

/speckit.plan Use React frontend, Node.js/Express backend, PostgreSQL database

/speckit.tasks

/speckit.implement
```

## See Also

- [Spec Kit GitHub](https://github.com/github/spec-kit)
- [Spec-Driven Development Guide](https://github.com/github/spec-kit/blob/main/spec-driven.md)
- [Claude Code Documentation](https://docs.claude.com/)
