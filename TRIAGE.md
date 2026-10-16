# Triage guide

Shape follows the VS Code issue triage flow
(https://github.com/microsoft/vscode/wiki/Issues-Triaging) and GitHub's default label set
(https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels).
Labels live in `labels.json`; apply them with `scripts/sync-labels.sh`.

## Who and when

- Ohmic Test Systems maintainers triage. Shane Mattner is the default owner.
- Target: first reply within 2 business days.

## Label flow

1. New issues arrive with `triage` plus `bug` or `enhancement` (set by the forms).
2. Add one `area:*` label and any `platform:*` label.
3. Missing detail: add `needs-info`, then ask for it (see below).
4. Reproduced or accepted: add `confirmed`, remove `triage` and `needs-info`.
5. Add `priority:high` (blocks flashing or debugging, loses data) or `priority:low`.
6. Close with one reason label: `duplicate` (link the original), `wontfix`, `invalid`,
   or `question` (answer it first).

## Stale rule

- `needs-info` with no reporter reply for 14 days: post a note and close the issue.
- A reply reopens it; swap `needs-info` for `triage`.

## Asking for the report zip

Say: "In VS Code run **Scout: Report Issue**. It builds a local zip with logs and
versions; nothing is sent. Open it, remove anything private, and attach it here."
If the user cannot attach it, ask for the version lines and the failing command output.

## Secrets

- Never ask a user for tokens, keys, passwords, Wi-Fi credentials or private firmware.
- If a user posts one, edit the comment out, tell them to rotate it, and note it in the issue.
