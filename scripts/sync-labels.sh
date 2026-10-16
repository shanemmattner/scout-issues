#!/usr/bin/env bash
# Idempotent: applies labels.json with `gh label create --force`.
# Shape from https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels
set -eu
cd "$(dirname "$0")/.."
python3 -I -c 'import json;[print("\t".join([l["name"],l["color"],l["description"]])) for l in json.load(open("labels.json"))]' |
while IFS=$'\t' read -r name color desc; do
  gh label create "$name" --color "$color" --description "$desc" --force -R shanemmattner/scout-issues >/dev/null
  echo "BC:labels_sync name=$name,ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
done
