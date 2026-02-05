# Quick Start Guide

Earn 3 GitHub achievements in under 60 seconds.

## Prerequisites

```bash
# Install GitHub CLI
brew install gh  # macOS
# or: sudo apt install gh  # Linux

# Authenticate
gh auth login
```

## Option 1: Automated (Recommended)

```bash
git clone https://github.com/NYTEMODEONLY/githubspeedrun.git
cd githubspeedrun
./scripts/speedrun.sh my-achievement-repo
```

This automatically earns:
- **Quickdraw** (closes issue in <5 min)
- **YOLO** (merges PR without review)
- **Pull Shark** (merges 3+ PRs)

## Option 2: Manual (Step by Step)

### 1. Create a repo

```bash
mkdir my-repo && cd my-repo && git init && git branch -M main
echo "# My Repo" > README.md
git add README.md && git commit -m "init"
gh repo create my-repo --public --source=. --push
```

### 2. Quickdraw

```bash
gh issue create --title "Setup" --body "Init project"
gh issue close 1 --comment "Done"
```

### 3. YOLO

```bash
git checkout -b add-license
echo "MIT License" > LICENSE
git add LICENSE && git commit -m "Add license"
git push -u origin add-license
gh pr create --title "Add license" --body "MIT" --base main
gh pr merge 2 --merge
git checkout main && git pull
```

### 4. Pull Shark (repeat for 2+ PRs)

```bash
git checkout -b add-gitignore
echo "node_modules/" > .gitignore
git add .gitignore && git commit -m "Add gitignore"
git push -u origin add-gitignore
gh pr create --title "Add gitignore" --body "Ignore files" --base main
gh pr merge 3 --merge
git checkout main && git pull
```

## What You Can't Automate

| Achievement | What You Need |
|---|---|
| Galaxy Brain | Someone else asks a Q&A discussion question you answer |
| Starstruck | 16 people star your repo |
| Public Sponsor | Pay $1+/month to sponsor someone |
| Pair Extraordinaire | Co-author with a real GitHub user |

## Bonus: Free Badge

Register for the [GitHub Developer Program](https://github.com/developer) to get the **Developer Program Member** badge for free.
