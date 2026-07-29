#!/usr/bin/env bash
set -euo pipefail

output="$(mktemp)"
trap 'rm -f "$output"' EXIT

ansible-inventory -i inventories/corp/inventory.yml --list >"$output"
python3 -m json.tool "$output" >/dev/null

if jq -e '
  .. | objects | to_entries[]?
  | select(.key | test("(^|_)(password|passwd|token|secret|private_key|api_key)($|_)"; "i"))
  | select(
      (.value | type) != "string"
      or
      (.value | test(
        "^\\{\\{ lookup\\('\''ansible\\.builtin\\.env'\'', '\''[A-Z][A-Z0-9_]*'\''\\) \\}\\}$"
      ) | not)
    )
' "$output" >/dev/null; then
  echo "ERROR: secret-like variables must use an exact environment lookup; literal values are forbidden." >&2
  exit 1
fi

if rg -n --hidden \
  '(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3})' \
  inventories; then
  echo "ERROR: private-address material is forbidden in the public example inventory." >&2
  exit 1
fi
