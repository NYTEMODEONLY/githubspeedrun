#!/bin/bash
# Speedrun timer - track how long it takes to earn each achievement
# Usage: ./scripts/speedrun-timer.sh

START_TIME=$(date +%s)

echo "=== GitHub Achievement Speedrun Timer ==="
echo "Started at: $(date)"
echo ""
echo "Achievements to earn:"
echo "  [ ] Quickdraw"
echo "  [ ] YOLO"
echo "  [ ] Pull Shark"
echo "  [ ] Galaxy Brain"
echo "  [ ] Pair Extraordinaire"
echo ""

read -p "Press Enter when all achievements are earned..."

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
MINUTES=$((ELAPSED / 60))
SECONDS=$((ELAPSED % 60))

echo ""
echo "=== SPEEDRUN COMPLETE ==="
echo "Total time: ${MINUTES}m ${SECONDS}s"
