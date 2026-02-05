#!/bin/bash
# =============================================================================
# GitHub Achievement Speedrun Script
# =============================================================================
# Earns as many GitHub achievements as possible on YOUR OWN repos.
# Ethical, responsible, and TOS-compliant.
#
# Prerequisites:
#   - gh CLI installed and authenticated (gh auth login)
#   - git installed and configured
#
# Usage:
#   ./scripts/speedrun.sh [repo-name]
#
# If repo-name is omitted, creates "github-achievement-speedrun" repo.
# =============================================================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Config
REPO_NAME="${1:-github-achievement-speedrun}"
USERNAME=$(gh api user --jq '.login')
START_TIME=$(date +%s)

echo -e "${CYAN}=== GitHub Achievement Speedrun ===${NC}"
echo -e "User: ${GREEN}$USERNAME${NC}"
echo -e "Repo: ${GREEN}$REPO_NAME${NC}"
echo ""

# Track achievements
declare -A EARNED

# ---------------------------------------------------------------------------
# Helper Functions
# ---------------------------------------------------------------------------

log_success() { echo -e "  ${GREEN}✓${NC} $1"; }
log_info()    { echo -e "  ${BLUE}→${NC} $1"; }
log_warn()    { echo -e "  ${YELLOW}!${NC} $1"; }
log_fail()    { echo -e "  ${RED}✗${NC} $1"; }

create_branch_pr_merge() {
  local branch="$1"
  local file="$2"
  local commit_msg="$3"
  local pr_title="$4"
  local pr_body="${5:-$pr_title}"
  local co_author="${6:-}"

  git checkout -b "$branch" 2>/dev/null
  git add "$file"

  if [ -n "$co_author" ]; then
    git commit -m "$(printf '%s\n\nCo-authored-by: %s' "$commit_msg" "$co_author")"
  else
    git commit -m "$commit_msg"
  fi

  git push -u origin "$branch" 2>/dev/null
  gh pr create --title "$pr_title" --body "$pr_body" --base main --head "$branch" 2>/dev/null
  local pr_num
  pr_num=$(gh pr list --head "$branch" --json number --jq '.[0].number')
  gh pr merge "$pr_num" --merge 2>/dev/null
  git checkout main 2>/dev/null
  git pull origin main 2>/dev/null
}

# ---------------------------------------------------------------------------
# Step 1: Create Repository
# ---------------------------------------------------------------------------

echo -e "${CYAN}[1/6] Creating repository...${NC}"

if gh repo view "$USERNAME/$REPO_NAME" &>/dev/null; then
  log_warn "Repo $REPO_NAME already exists, using it"
  cd "$(mktemp -d)"
  gh repo clone "$USERNAME/$REPO_NAME" .
else
  TMPDIR=$(mktemp -d)
  cd "$TMPDIR"
  git init
  git branch -M main
  echo "# $REPO_NAME" > README.md
  echo "GitHub Achievement Speedrun - automated with [speedrun.sh](scripts/speedrun.sh)" >> README.md
  git add README.md
  git commit -m "Initial commit"
  gh repo create "$REPO_NAME" --public --source=. --push \
    --description "GitHub Achievement Speedrun"
  log_success "Created repo: $USERNAME/$REPO_NAME"
fi

# ---------------------------------------------------------------------------
# Step 2: Quickdraw - Close issue within 5 minutes
# ---------------------------------------------------------------------------

echo -e "\n${CYAN}[2/6] Earning Quickdraw...${NC}"
log_info "Opening and closing issue immediately"

ISSUE_URL=$(gh issue create \
  --title "Initialize project" \
  --body "Setting up the project structure." \
  --repo "$USERNAME/$REPO_NAME")

ISSUE_NUM=$(echo "$ISSUE_URL" | grep -o '[0-9]*$')
gh issue close "$ISSUE_NUM" \
  --comment "Done!" \
  --repo "$USERNAME/$REPO_NAME"

EARNED[Quickdraw]="Default"
log_success "Quickdraw earned! (closed issue #$ISSUE_NUM in <5 min)"

# ---------------------------------------------------------------------------
# Step 3: YOLO - Merge PR without review
# ---------------------------------------------------------------------------

echo -e "\n${CYAN}[3/6] Earning YOLO...${NC}"
log_info "Creating and merging PR without review"

echo "MIT License" > LICENSE
echo "" >> LICENSE
echo "Copyright (c) $(date +%Y) $USERNAME" >> LICENSE
git checkout -b add-license
git add LICENSE
git commit -m "Add MIT license"
git push -u origin add-license 2>/dev/null
gh pr create --title "Add license" --body "Add MIT license." \
  --base main --head add-license
PR_NUM=$(gh pr list --head add-license --json number --jq '.[0].number')
gh pr merge "$PR_NUM" --merge
git checkout main && git pull origin main 2>/dev/null

EARNED[YOLO]="Default"
log_success "YOLO earned! (merged PR #$PR_NUM without review)"

# ---------------------------------------------------------------------------
# Step 4: Pull Shark - Merge 2+ PRs (we'll do several)
# ---------------------------------------------------------------------------

echo -e "\n${CYAN}[4/6] Earning Pull Shark...${NC}"
log_info "Creating and merging multiple PRs"

# PR 2: .gitignore
cat > .gitignore << 'GITIGNORE'
node_modules/
.env
.DS_Store
dist/
build/
GITIGNORE
create_branch_pr_merge "add-gitignore" ".gitignore" \
  "Add .gitignore" "Add .gitignore"
log_success "PR merged (gitignore)"

# PR 3: Contributing guide
cat > CONTRIBUTING.md << 'CONTRIB'
# Contributing
1. Fork the repo
2. Create a feature branch
3. Open a Pull Request
CONTRIB
create_branch_pr_merge "add-contributing" "CONTRIBUTING.md" \
  "Add contributing guide" "Add contributing guide"
log_success "PR merged (contributing)"

EARNED[PullShark]="Default (2+ PRs)"
log_success "Pull Shark earned! (3 PRs merged)"

# ---------------------------------------------------------------------------
# Step 5: Pair Extraordinaire - Co-authored commit
# ---------------------------------------------------------------------------

echo -e "\n${CYAN}[5/6] Attempting Pair Extraordinaire...${NC}"
log_info "Creating PR with co-authored commit"
log_warn "Requires co-author email to map to a real GitHub account"

cat > CODE_OF_CONDUCT.md << 'COC'
# Code of Conduct
Be kind, be respectful, have fun.
COC
create_branch_pr_merge "add-coc" "CODE_OF_CONDUCT.md" \
  "Add code of conduct" "Add code of conduct" "" \
  "Claude <noreply@anthropic.com>"
log_info "PR merged with co-author trailer (may or may not trigger badge)"

# ---------------------------------------------------------------------------
# Step 6: Galaxy Brain - Discussion answers
# ---------------------------------------------------------------------------

echo -e "\n${CYAN}[6/6] Setting up for Galaxy Brain...${NC}"
log_warn "Galaxy Brain requires someone ELSE to ask a question you answer"
log_info "Enabling discussions on repo..."

gh api "repos/$USERNAME/$REPO_NAME" -X PATCH -f has_discussions=true \
  --jq '.has_discussions' >/dev/null
log_success "Discussions enabled on $REPO_NAME"
log_info "To earn Galaxy Brain:"
log_info "  1. Have someone create a Q&A discussion on your repo"
log_info "  2. Answer their question"
log_info "  3. They (or you as repo owner) mark it as accepted"
log_info "  4. Repeat 2x for Default, 8x for Bronze"

# ---------------------------------------------------------------------------
# Results
# ---------------------------------------------------------------------------

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

echo ""
echo -e "${CYAN}=== SPEEDRUN COMPLETE ===${NC}"
echo -e "Time: ${GREEN}${ELAPSED}s${NC}"
echo ""
echo -e "${GREEN}Achievements Earned:${NC}"
for key in "${!EARNED[@]}"; do
  echo -e "  ✓ $key - ${EARNED[$key]}"
done
echo ""
echo -e "${YELLOW}Achievements Requiring Manual Action:${NC}"
echo -e "  → Galaxy Brain - need someone else's question"
echo -e "  → Starstruck - need 16 stars from others"
echo -e "  → Public Sponsor - need to sponsor someone (\$1+)"
echo ""
echo -e "${YELLOW}Badges Requiring Registration:${NC}"
echo -e "  → Developer Program Member - register at github.com/developer"
echo -e "  → Pro - subscribe to GitHub Pro (\$4/month)"
echo ""
echo -e "${RED}Not Earnable:${NC}"
echo -e "  ✗ Arctic Code Vault Contributor (2020 one-time event)"
echo -e "  ✗ Mars 2020 Contributor (historical)"
echo -e "  ✗ Heart On Your Sleeve (unreleased)"
echo -e "  ✗ Open Sourcerer (unreleased)"
