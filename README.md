# ansible-inventory-example

Sanitized reference inventories and variable examples for ModuLix automation.

## Purpose

This repository provides public, sanitized inventory examples for
`modulix-automation`.

It is intentionally not a real environment inventory. Use documentation
domains, documentation IP ranges, and placeholder secrets only.

Real customer inventories belong in private repositories such as:

```text
ansible-inventory-lit
ansible-inventory-<customer>
```

## Layout

```text
inventories/
  corp/
    inventory.yml
    group_vars/
    host_vars/
```

## Validate

```bash
ansible-inventory \
  -i inventories/corp/inventory.yml \
  --list >/tmp/ansible-inventory-example.json
```

## Example With modulix-automation

```bash
cd /home/rene/sources/modulix-automation/ansible

./scripts/ansible-nav run \
  runbooks/50-applications/wunderbox/10-deploy.yml \
  -i /home/rene/sources/ansible-inventory-example/inventories/corp/inventory.yml \
  --limit wunderbox01.prd.dmz.example.invalid
```

The example inventory is for structure and variable-contract reference only.
It is not a copy-paste rollout procedure and is not expected to deploy a real
environment.
