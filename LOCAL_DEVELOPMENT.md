# OTRP local development repository

This repository is the working source tree for personal Simutrans OTRP fixes and features. The primary goal is a stable personal version; upstream pull requests are optional.

## Branch and remote policy

- `local-development`: personal mainline. Tested personal changes are merged here and builds intended for regular play are made from here.
- `work/<topic>`: normal short-lived branch for a personal fix or feature, created from `local-development`.
- `pr/<topic>`: optional focused branch created directly from the official branch only when a change may be proposed upstream.
- `origin`: personal GitHub fork (`https://github.com/tomnak-bird/simutrans.git`).
- `upstream`: official OTRP repository (`https://github.com/teamhimeh/simutrans.git`).
- `upstream/OTRP-KUTAv6`: official branch periodically merged into `local-development`.
- `production-exe-2026-10-12`: tag identifying the exact source commit used for the current interim production executable.

Do not commit directly to a detached `upstream/*` reference. Make local changes on `local-development` and commit each independent fix or feature separately.

The personal fork is available under `tomnak-bird` and configured as `origin`. The `Create_GitHub_Fork.url` file is retained only as a reference to the upstream fork page; it is no longer needed for setup.

## Normal personal-development workflow

1. Run `New_Local_Work_Branch.cmd <short-topic-name>` to create `work/<short-topic-name>` from the current personal mainline.
2. Implement and commit one fix or feature on that branch.
3. Build and test it.
4. Run `Merge_Local_Work_Branch.cmd` while still on the tested `work/*` branch.

The merge helper merges the tested branch into `local-development` with a merge commit and pushes the updated personal mainline to the fork. It does not delete the work branch, so it remains available for investigation or rollback.

## Occasionally updating from official OTRP

With a clean working tree, run `Update_From_OTRP_Upstream.cmd`. It performs:

1. `git fetch upstream --prune`
2. `git merge --no-edit upstream/OTRP-KUTAv6`
3. `git push origin local-development`

The script only runs on `local-development` and refuses to start when local files are uncommitted. If a merge conflict occurs, it stops without discarding either side; preserve the files and ask Codex to resolve and test the merge.

This update is intentionally separate from normal feature work. Run it only when official changes should be incorporated and allow time to rebuild and retest afterward.

Before deploying a newly built executable, record the tested commit with a Git tag and keep the executable filename tied to that commit.

## Optional upstream pull request

Upstream contribution is not the default workflow. When a particular change is broadly useful and worth proposing, run `New_PR_Branch.cmd <short-topic-name>`. This fetches upstream and creates `pr/<short-topic-name>` directly from `upstream/OTRP-KUTAv6`, keeping unrelated personal changes out of the pull request.

Commit and test one logical change on that branch, then run `Push_PR_Branch.cmd`. It pushes the branch to the personal fork. A pull request can then target `teamhimeh/simutrans:OTRP-KUTAv6` from `tomnak-bird/simutrans:pr/<short-topic-name>`.

Do not mix multiple fixes or private/local-only behavior into one PR branch. If a PR candidate is also needed in local production before upstream accepts it, merge that `pr/*` branch into `local-development` after testing.

## Initial state

- Interim production executable source: local commit `6b24ab343`, an application of official fix #756 on tag `v62_0_3`.
- Official #756 commit: `5a763f099`.
- This development branch was created from `upstream/OTRP-KUTAv6` at OTRP `v62_2` (`e2bdac807`), then this policy and updater were committed.
