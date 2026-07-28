#!/usr/bin/env bash
set -euo pipefail

output="$(mktemp)"
trap 'rm -f "$output"' EXIT

ansible-inventory -i inventories/corp/inventory.yml --list >"$output"
python3 -m json.tool "$output" >/dev/null

if rg -n --hidden \
  --glob '!scripts/validate-inventory.sh' \
  --glob '!AGENTS.md' \
  --glob '!README.md' \
  '(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3})' \
  inventories; then
  echo "ERROR: private-address material is forbidden in the public example inventory." >&2
  exit 1
fi
