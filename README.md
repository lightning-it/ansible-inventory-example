# ansible-inventory-example

<!-- BEGIN LIT_QUALITY_BADGES -->

[![CI](https://github.com/lightning-it/ansible-inventory-example/actions/workflows/repository-quality.yml/badge.svg?branch=develop)](https://github.com/lightning-it/ansible-inventory-example/actions/workflows/repository-quality.yml)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/lightning-it/ansible-inventory-example/badge)](https://scorecard.dev/viewer/?uri=github.com/lightning-it/ansible-inventory-example)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

<!-- END LIT_QUALITY_BADGES -->

<!-- BEGIN LIT_SHARED_RELEASE_MODEL -->

## Release and Quality Model

This repository follows the Lightning IT shared release and quality model.

See [RELEASE.md](./RELEASE.md) for:

- branch and release flow
- required quality checks
- test matrix
- release evidence
- artifact publishing
- supported repository-specific release behavior

Repository classification: **Playbook/Runbook Repository**.
Required test profiles: `pre-commit, yaml-structure, inventory-template-validation`.
Publishing targets: `none`.

## Supported and Tested Platforms

| Platform / Product | Status | Validation |
|---|---:|---|
| ubuntu-latest | Supported | Repository CI |
| ansible-inventory | Tested where applicable | Repository CI |

<!-- END LIT_SHARED_RELEASE_MODEL -->

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
export SOURCES_DIR="${SOURCES_DIR:-${HOME}/sources}"
cd "${SOURCES_DIR}/modulix-automation/ansible"

./scripts/ansible-nav run \
  runbooks/50-applications/wunderbox/10-deploy.yml \
  -i "${SOURCES_DIR}/ansible-inventory-example/inventories/corp/inventory.yml" \
  --limit wunderbox01.prd.dmz.example.invalid
```

The example inventory is for structure and variable-contract reference only.
It is not a copy-paste rollout procedure and is not expected to deploy a real
environment.
