# OTRP local development repository

This repository is the working source tree for local Simutrans OTRP fixes and features.

## Branch and remote policy

- `local-development`: normal branch for local fixes and features.
- `pr/<topic>`: a focused branch created directly from the current official branch for a change intended for upstream review.
- `origin`: personal GitHub fork (`https://github.com/tomnak-bird/simutrans.git`).
- `upstream`: official OTRP repository (`https://github.com/teamhimeh/simutrans.git`).
- `upstream/OTRP-KUTAv6`: official branch periodically merged into `local-development`.
- `production-exe-2026-10-12`: tag identifying the exact source commit used for the current interim production executable.

Do not commit directly to a detached `upstream/*` reference. Make local changes on `local-development` and commit each independent fix or feature separately.

The personal fork did not yet exist when this repository was initialized. Open `Create_GitHub_Fork.url` once and create the fork under `tomnak-bird`. The local `origin` URL is already configured, so no Git reconfiguration is needed afterward.

## Updating from official OTRP

With a clean working tree, run `Update_From_OTRP_Upstream.cmd`. It performs:

1. `git fetch upstream --prune`
2. `git merge --no-edit upstream/OTRP-KUTAv6`

The script refuses to start when local files are uncommitted. If a merge conflict occurs, it stops without discarding either side; preserve the files and ask Codex to resolve and test the merge.

Before deploying a newly built executable, record the tested commit with a Git tag and keep the executable filename tied to that commit.

## Preparing an upstream pull request

Run `New_PR_Branch.cmd <short-topic-name>`. This fetches upstream and creates `pr/<short-topic-name>` directly from `upstream/OTRP-KUTAv6`, keeping unrelated local-only changes out of the pull request.

Commit and test one logical change on that branch, then run `Push_PR_Branch.cmd`. It pushes the branch to the personal fork. A pull request can then target `teamhimeh/simutrans:OTRP-KUTAv6` from `tomnak-bird/simutrans:pr/<short-topic-name>`.

Do not mix multiple fixes or private/local-only behavior into one PR branch. If a PR candidate is also needed in local production before upstream accepts it, merge that `pr/*` branch into `local-development` after testing.

## Initial state

- Interim production executable source: local commit `6b24ab343`, an application of official fix #756 on tag `v62_0_3`.
- Official #756 commit: `5a763f099`.
- This development branch was created from `upstream/OTRP-KUTAv6` at OTRP `v62_2` (`e2bdac807`), then this policy and updater were committed.
