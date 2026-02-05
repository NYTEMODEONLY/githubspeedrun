#!/bin/bash
# Check GitHub achievement progress using the GitHub API
# Usage: ./scripts/check-achievements.sh <username>

USERNAME=${1:-$(gh api user --jq '.login')}

echo "=== GitHub Achievement Checker ==="
echo "User: $USERNAME"
echo ""

# Count merged PRs (Pull Shark progress)
PR_COUNT=$(gh api "search/issues?q=is:pr+is:merged+author:$USERNAME" --jq '.total_count' 2>/dev/null || echo "?")
echo "Merged PRs (Pull Shark): $PR_COUNT"
if [ "$PR_COUNT" != "?" ]; then
  if [ "$PR_COUNT" -ge 1024 ]; then echo "  -> Gold!"
  elif [ "$PR_COUNT" -ge 128 ]; then echo "  -> Silver"
  elif [ "$PR_COUNT" -ge 16 ]; then echo "  -> Bronze"
  elif [ "$PR_COUNT" -ge 2 ]; then echo "  -> Default"
  else echo "  -> Not yet earned (need 2)"
  fi
fi

# Count repos (general activity)
REPO_COUNT=$(gh api "users/$USERNAME" --jq '.public_repos' 2>/dev/null || echo "?")
echo "Public repos: $REPO_COUNT"

# Count followers
FOLLOWERS=$(gh api "users/$USERNAME" --jq '.followers' 2>/dev/null || echo "?")
echo "Followers: $FOLLOWERS"

echo ""
echo "Note: Some achievements (Quickdraw, YOLO, Galaxy Brain) cannot be"
echo "checked via the API and must be verified on your profile page."
