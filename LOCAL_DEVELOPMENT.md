# OTRP local development repository

This repository is the working source tree for local Simutrans OTRP fixes and features.

## Branch and remote policy

- `local-development`: normal branch for local fixes and features.
- `upstream`: official OTRP repository (`https://github.com/teamhimeh/simutrans.git`).
- `upstream/OTRP-KUTAv6`: official branch periodically merged into `local-development`.
- `production-exe-2026-10-12`: tag identifying the exact source commit used for the current interim production executable.

Do not commit directly to a detached `upstream/*` reference. Make local changes on `local-development` and commit each independent fix or feature separately.

## Updating from official OTRP

With a clean working tree, run `Update_From_OTRP_Upstream.cmd`. It performs:

1. `git fetch upstream --prune`
2. `git merge --no-edit upstream/OTRP-KUTAv6`

The script refuses to start when local files are uncommitted. If a merge conflict occurs, it stops without discarding either side; preserve the files and ask Codex to resolve and test the merge.

Before deploying a newly built executable, record the tested commit with a Git tag and keep the executable filename tied to that commit.

## Initial state

- Interim production executable source: local commit `6b24ab343`, an application of official fix #756 on tag `v62_0_3`.
- Official #756 commit: `5a763f099`.
- This development branch was created from the latest fetched `upstream/OTRP-KUTAv6`, then this policy and updater were committed.
