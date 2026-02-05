#!/bin/bash
# Quickly create and merge a PR from a branch
# Usage: ./scripts/create-pr.sh <branch-name> <title> <body>

BRANCH=$1
TITLE=$2
BODY=${3:-"Auto-created PR"}

if [ -z "$BRANCH" ] || [ -z "$TITLE" ]; then
  echo "Usage: $0 <branch-name> <title> [body]"
  exit 1
fi

echo "Creating PR from branch: $BRANCH"
gh pr create --title "$TITLE" --body "$BODY" --base main --head "$BRANCH"
echo "Done!"
