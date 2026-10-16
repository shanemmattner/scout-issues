#!/usr/bin/env bash
# Proves the issues repo triage setup. Sources: gh api labels, GitHub issue-forms syntax docs.
set -u
cd "$(dirname "$0")/.."
REPO=shanemmattner/scout-issues
bc(){ echo "BC:$1 ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)"; }
fail(){ echo "RESULT: ISSUES_REPO labels=${n:-0} templates=${t:-0} FAIL reason=$1"; exit 1; }
n=0; t=0
[ -f labels.json ] || fail "labels.json missing"
gh api "repos/$REPO/labels" --paginate --jq '.[].name' > "${TMPDIR:-/tmp}/scout-issues-labels.txt" || fail "gh api failed"
n=$(wc -l < "${TMPDIR:-/tmp}/scout-issues-labels.txt" | tr -d ' ')
bc "check_labels_on_github count=$n"
while IFS= read -r name; do
  grep -qxF "$name" "${TMPDIR:-/tmp}/scout-issues-labels.txt" || fail "label '$name' missing on GitHub"
done < <(python3 -I -c 'import json;[print(l["name"]) for l in json.load(open("labels.json"))]')
for f in .github/ISSUE_TEMPLATE/*.yml; do
  [ "$(basename "$f")" = config.yml ] && continue
  t=$((t+1))
  grep -E '^labels:.*"triage"' "$f" >/dev/null || fail "$f lacks labels: with triage"
  bc "check_form file=$f"
done
[ "$t" -eq 2 ] || fail "expected 2 issue forms, found $t"
[ -f TRIAGE.md ] || fail "TRIAGE.md missing"
grep -q 'TRIAGE.md' README.md || fail "README.md does not link TRIAGE.md"
echo "RESULT: ISSUES_REPO labels=$n templates=$t PASS"
