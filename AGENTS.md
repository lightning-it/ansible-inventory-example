# Agent Instructions

## Repository Purpose

This repository contains public, sanitized inventory examples for ModuLix
automation.

Use it for:

- reference inventory layouts
- sanitized `group_vars` and `host_vars`
- documentation examples for `modulix-automation`
- variable contract examples

Do not put real customer or Lightning IT environment values here.

## Sanitization Rules

1. Use documentation domains such as `example.invalid`.
2. Use documentation IP ranges only:
   - `192.0.2.0/24`
   - `198.51.100.0/24`
   - `203.0.113.0/24`
3. Never commit real passwords, tokens, keys, hostnames, datastore names, VLANs,
   vCenter endpoints, RHSM values, Vault paths, or customer names.
4. Keep examples small and focused on structure.
5. Prefer explicit placeholder values over hidden magic defaults.

## Boundary

- Public automation code lives in `modulix-automation`.
- Public sanitized inventory examples live here.
- Real environment inventory lives in private `ansible-inventory-*` repos.
- Private operation procedures live in private `modulix-operations-*` repos.

## Validation

For documentation-only changes:

```bash
git diff --check
```

For inventory changes:

```bash
ansible-inventory \
  -i inventories/corp/inventory.yml \
  --list >/tmp/ansible-inventory-example.json
```
