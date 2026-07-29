# ansible-inventory-example

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

| Platform / Product |                  Status | Validation    |
| ------------------ | ----------------------: | ------------- |
| ubuntu-latest      |               Supported | Repository CI |
| ansible-inventory  | Tested where applicable | Repository CI |

<!-- END LIT_SHARED_RELEASE_MODEL -->

<!-- BEGIN LIT_QUALITY_BADGES -->

[![CI](https://github.com/lightning-it/ansible-inventory-example/actions/workflows/repository-quality.yml/badge.svg?branch=develop)](https://github.com/lightning-it/ansible-inventory-example/actions/workflows/repository-quality.yml)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/lightning-it/ansible-inventory-example/badge)](https://scorecard.dev/viewer/?uri=github.com/lightning-it/ansible-inventory-example)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

<!-- END LIT_QUALITY_BADGES -->

Sanitized reference inventories and variable examples for ModuLix automation.

## Purpose

This repository provides public, sanitized inventory examples for
`modulix-automation`.

It is intentionally not a real environment inventory. Use documentation
domains, documentation IP ranges, and example secrets only.

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
cd "${SOURCES_DIR}/modulix-automation/ansible" || exit

./scripts/ansible-nav run \
  runbooks/50-applications/wunderbox/10-deploy.yml \
  -i "${SOURCES_DIR}/ansible-inventory-example/inventories/corp/inventory.yml" \
  --limit wunderbox01.prd.dmz.example.invalid
```

The example inventory is for structure and variable-contract reference only.
It is not a copy-paste rollout procedure and is not expected to deploy a real
environment.

## Security

See [SECURITY.md](./SECURITY.md) for supported versions and vulnerability reporting.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution and review expectations.

## License

See [LICENSE](./LICENSE).

<!-- BEGIN LIT_RELEASE_QUALITY_MODEL -->

## Release and Quality Model

This repository follows the Lightning IT shared release and quality model.
The README shows the current supported and tested matrix.
Exact per-version validation proof is stored with each GitHub Release as `release-evidence.md` and `release-evidence.json`.
Releases are created from the protected `main` branch after a reviewed `develop -> main` release promotion.
Runbook releases validate linting, syntax, sanitized examples, and integration scenarios where configured.

See:

- [RELEASE.md](./RELEASE.md)
- [TESTING.md](./TESTING.md)
- [GitHub Releases](../../releases)

Repository classification: **Playbook/Runbook Repository**.
Required test profiles: `pre-commit, yaml-structure, inventory-template-validation`.
Publishing targets: `none`.

<!-- END LIT_RELEASE_QUALITY_MODEL -->

<!-- BEGIN LIT_COMPATIBILITY_MATRIX -->

## Compatibility Matrix

| Platform / Product | Status | Validation |
|---|---:|---|
| ubuntu-latest | Supported | Repository CI |
| ansible-inventory | Tested where applicable | Repository CI |

Validation proof for each released version is stored in the corresponding GitHub Release evidence.

<!-- END LIT_COMPATIBILITY_MATRIX -->

## Release Evidence

This repository does not publish release artifacts by default; release evidence is recorded when artifact releases are enabled.
The evidence records:

- tested matrix combinations
- GitHub Actions run links
- artifact references
- publish status
- security scan status

See [GitHub Releases](../../releases), [RELEASE.md](./RELEASE.md), and [TESTING.md](./TESTING.md) for the release process and validation model.
