# Frequently Asked Questions

## Do achievements count on private repos?
Yes, achievements like Pull Shark and YOLO work on private repositories too.

## Can I hide achievements on my profile?
Yes. Go to your profile, click the pencil icon on the Achievements section,
and toggle which achievements are visible.

## Do achievements on my own repos count?
Yes. Merging your own PRs counts for Pull Shark, YOLO, etc.

## Can I earn Quickdraw multiple times?
No. Quickdraw is a one-time achievement with no tiers.

## Can I earn Galaxy Brain by answering my own questions?
**No.** This is a major gotcha. Self-answered Q&A discussions do NOT count
toward Galaxy Brain. Someone else must create the discussion question, then
you answer it and have it marked as accepted.

## How long do achievement tiers take to update?
Achievement tiers can take anywhere from minutes to days to update on your
profile. GitHub processes these asynchronously. If you've hit the threshold
but don't see the tier change yet, wait 24-48 hours.

## Does Pair Extraordinaire work with any co-author email?
No. The email in the `Co-authored-by:` trailer must map to a real GitHub
account. Use the format `username@users.noreply.github.com` or the email
associated with their GitHub profile for reliability.

## What happened to Arctic Code Vault?
It was a limited-time badge for contributing to repos included in the
2020 GitHub Archive Program (stored in Arctic vault in Svalbard, Norway).
It can no longer be earned.

## What about Heart On Your Sleeve and Open Sourcerer?
These are unreleased achievements that GitHub has been testing. They are
not yet available to earn. Heart On Your Sleeve likely involves reacting
with a heart emoji, and Open Sourcerer likely requires PRs merged across
multiple public repos.

## Do GitHub Actions automated PRs count?
Generally no. The PR needs to be opened by a user account for most
achievements to trigger.

## Is there a way to check my achievement progress?
You can see earned achievements on your profile page. There's no
official progress indicator for partially completed tiered achievements.
Use `scripts/check-achievements.sh` to check your merged PR count.

## Can I earn the Developer Program Member badge for free?
Yes! Register at github.com/developer — it's completely free and gives
you the badge on your profile immediately.

## Do stars need to be on one repo for Starstruck?
Yes. Stars for Starstruck must all be on a single repository. They do not
aggregate across your repos.
