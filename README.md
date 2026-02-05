# GitHub Achievement Speedrun

Speedrunning GitHub profile achievements responsibly. Built with [Claude Code](https://claude.ai/claude-code).

> **Run it yourself:** `./scripts/speedrun.sh` — earns Quickdraw, YOLO, and Pull Shark in under 60 seconds.

## Speedrun Results (NYTEMODEONLY)

### Confirmed on Profile

| Achievement | Tier | Method |
|---|---|---|
| **Quickdraw** | Default | Opened and closed issue #1 in seconds |
| **YOLO** | Default | Merged PR #2 with zero code review |
| **Pull Shark** | Default* | 60+ merged PRs across all repos |
| **Pair Extraordinaire** | Default | Co-authored commit in merged PR |
| **Starstruck** | Default | Pre-existing from another repo |

> *Pull Shark tier upgrade to Bronze (x2) pending — GitHub tier updates can take hours/days.

### Not Earned (Requires External Action)

| Achievement | Why |
|---|---|
| **Galaxy Brain** | Self-answered discussions **don't count**. Someone else must ask the question. |
| **Public Sponsor** | Requires sponsoring a developer ($1+/month) |

### Not Earnable

| Badge | Reason |
|---|---|
| Arctic Code Vault Contributor | 2020 one-time historical archive event |
| Mars 2020 Contributor | Historical, linked to Mars Helicopter Mission repos |
| Heart On Your Sleeve | Unreleased (still in beta testing) |
| Open Sourcerer | Unreleased (still in beta testing) |

## Complete Achievement Reference

### Earnable Achievements (with Tiers)

| Achievement | How to Earn | Default | Bronze | Silver | Gold |
|---|---|---|---|---|---|
| Pull Shark | Get PRs merged | 2 | 16 | 128 | 1,024 |
| Galaxy Brain | Accepted discussion answers | 2 | 8 | 16 | 32 |
| Pair Extraordinaire | Co-authored merged PRs | 1 | 10 | 24 | 48 |
| Starstruck | Stars on one repo | 16 | 128 | 512 | 4,096 |

### Earnable Achievements (No Tiers)

| Achievement | How to Earn |
|---|---|
| Quickdraw | Close an issue or PR within 5 minutes of opening |
| YOLO | Merge a PR without any code review |
| Public Sponsor | Sponsor an open source developer via GitHub Sponsors |

### Profile Badges (Not Achievements)

| Badge | How to Get | Cost |
|---|---|---|
| Pro | Subscribe to GitHub Pro | $4/month |
| Developer Program Member | Register at [github.com/developer](https://github.com/developer) | Free |
| Security Bug Bounty Hunter | Participate in GitHub's bug bounty | Free |
| Campus Expert | GitHub Campus Expert program | Free (students) |
| Security Advisory Credit | Submit accepted advisory to GitHub Advisory DB | Free |

## Key Gotchas Discovered

1. **Galaxy Brain self-answers don't count** — You cannot ask AND answer your own question. Someone else must ask.
2. **Achievement tiers may delay** — GitHub can take hours or days to update tier levels.
3. **Pair Extraordinaire needs real GitHub emails** — The `Co-authored-by:` email must map to an actual GitHub account.
4. **Pull Shark counts self-merges** — Merging your own PRs on your own repos does count.
5. **Some achievements support skin tone customization** — Set in GitHub Appearance settings.

## Scripts

| Script | Description |
|---|---|
| [`scripts/speedrun.sh`](scripts/speedrun.sh) | Full automated speedrun — earns Quickdraw, YOLO, Pull Shark |
| [`scripts/check-achievements.sh`](scripts/check-achievements.sh) | Check your current achievement progress via API |
| [`scripts/speedrun-timer.sh`](scripts/speedrun-timer.sh) | Time your speedrun |
| [`scripts/create-pr.sh`](scripts/create-pr.sh) | Helper to quickly create PRs |

## Documentation

| File | Contents |
|---|---|
| [`achievements.json`](achievements.json) | Structured data for all achievements |
| [`tiers.md`](tiers.md) | Full tier thresholds and colors |
| [`badges.md`](badges.md) | Non-achievement profile badges |
| [`tips.md`](tips.md) | Strategies for each achievement |
| [`faq.md`](faq.md) | Common questions answered |
| [`skin-tones.md`](skin-tones.md) | Achievement appearance customization |

## How This Speedrun Works

1. **Create a repo** — Fresh public repo to work in
2. **Open + close an issue** — Triggers Quickdraw (under 5 min)
3. **Create a PR and merge without review** — Triggers YOLO
4. **Merge 2+ PRs** — Triggers Pull Shark (Default)
5. **Add co-authored commits** — Attempts Pair Extraordinaire
6. **Enable discussions** — Sets up for Galaxy Brain (needs external help)

The [`speedrun.sh`](scripts/speedrun.sh) script automates steps 1-6 for any GitHub account.

## License

[MIT](LICENSE)
