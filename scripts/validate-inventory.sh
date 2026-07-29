#!/usr/bin/env bash
set -euo pipefail

for required_command in ansible-inventory python3 jq mktemp; do
  if ! command -v "$required_command" >/dev/null 2>&1; then
    echo "ERROR: required validation command is unavailable: $required_command" >&2
    exit 2
  fi
done

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

private_address_pattern='(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3})'
if command -v rg >/dev/null 2>&1; then
  private_address_matches="$(
    rg -n --hidden "$private_address_pattern" inventories || true
  )"
else
  private_address_matches="$(
    grep -REn "$private_address_pattern" inventories || true
  )"
fi
if [[ -n "$private_address_matches" ]]; then
  printf '%s\n' "$private_address_matches"
  echo "ERROR: private-address material is forbidden in the public example inventory." >&2
  exit 1
fi
