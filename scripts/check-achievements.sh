#!/bin/bash
# =============================================================================
# GitHub Achievement Progress Checker
# =============================================================================
# Checks what you can verify via the GitHub API about your achievements.
# Usage: ./scripts/check-achievements.sh [username]
# =============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

USERNAME=${1:-$(gh api user --jq '.login' 2>/dev/null || echo "")}

if [ -z "$USERNAME" ]; then
  echo "Usage: $0 <username>"
  echo "Or authenticate with: gh auth login"
  exit 1
fi

echo -e "${CYAN}=== GitHub Achievement Progress Checker ===${NC}"
echo -e "User: ${GREEN}$USERNAME${NC}"
echo -e "Date: $(date '+%Y-%m-%d %H:%M')"
echo ""

tier_label() {
  local count=$1
  local t_default=$2
  local t_bronze=$3
  local t_silver=$4
  local t_gold=$5

  if [ "$count" -ge "$t_gold" ]; then echo -e "${YELLOW}Gold (x4)${NC}"
  elif [ "$count" -ge "$t_silver" ]; then echo -e "${CYAN}Silver (x3)${NC}"
  elif [ "$count" -ge "$t_bronze" ]; then echo -e "${GREEN}Bronze (x2)${NC}"
  elif [ "$count" -ge "$t_default" ]; then echo "Default (x1)"
  else echo -e "${RED}Not earned${NC}"
  fi
}

# ---------------------------------------------------------------------------
# Pull Shark
# ---------------------------------------------------------------------------
echo -e "${CYAN}--- Pull Shark ---${NC}"
PR_COUNT=$(gh api "search/issues?q=is:pr+is:merged+author:$USERNAME" --jq '.total_count' 2>/dev/null || echo "0")
echo -e "  Merged PRs: ${GREEN}$PR_COUNT${NC}"
echo -e "  Tier: $(tier_label "$PR_COUNT" 2 16 128 1024)"
echo -e "  Next: $(
  if [ "$PR_COUNT" -ge 1024 ]; then echo "Max tier reached!"
  elif [ "$PR_COUNT" -ge 128 ]; then echo "$((1024 - PR_COUNT)) more for Gold"
  elif [ "$PR_COUNT" -ge 16 ]; then echo "$((128 - PR_COUNT)) more for Silver"
  elif [ "$PR_COUNT" -ge 2 ]; then echo "$((16 - PR_COUNT)) more for Bronze"
  else echo "$((2 - PR_COUNT)) more for Default"
  fi
)"
echo ""

# ---------------------------------------------------------------------------
# Starstruck (check top-starred repo)
# ---------------------------------------------------------------------------
echo -e "${CYAN}--- Starstruck ---${NC}"
TOP_REPO=$(gh api "users/$USERNAME/repos?sort=stars&per_page=1" --jq '.[0] | "\(.name): \(.stargazers_count) stars"' 2>/dev/null || echo "unknown: 0 stars")
TOP_STARS=$(echo "$TOP_REPO" | grep -o '[0-9]*' | tail -1)
echo -e "  Top repo: ${GREEN}$TOP_REPO${NC}"
echo -e "  Tier: $(tier_label "${TOP_STARS:-0}" 16 128 512 4096)"
echo ""

# ---------------------------------------------------------------------------
# Account Info
# ---------------------------------------------------------------------------
echo -e "${CYAN}--- Account Info ---${NC}"
ACCOUNT_INFO=$(gh api "users/$USERNAME" --jq '{repos: .public_repos, followers: .followers, following: .following, created: .created_at}' 2>/dev/null)
echo -e "  Public repos: $(echo "$ACCOUNT_INFO" | grep -o '"repos":[0-9]*' | grep -o '[0-9]*')"
echo -e "  Followers: $(echo "$ACCOUNT_INFO" | grep -o '"followers":[0-9]*' | grep -o '[0-9]*')"
echo -e "  Account created: $(echo "$ACCOUNT_INFO" | grep -o '"created":"[^"]*"' | cut -d'"' -f4 | cut -d'T' -f1)"
echo ""

# ---------------------------------------------------------------------------
# Cannot Check via API
# ---------------------------------------------------------------------------
echo -e "${YELLOW}--- Cannot Check via API (verify on profile) ---${NC}"
echo "  Quickdraw - Close issue/PR within 5 min"
echo "  YOLO - Merge PR without review"
echo "  Galaxy Brain - Accepted discussion answers"
echo "  Pair Extraordinaire - Co-authored merged PRs"
echo "  Public Sponsor - Sponsoring someone"
echo ""
echo -e "View profile: ${CYAN}https://github.com/$USERNAME${NC}"
