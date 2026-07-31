# Agent Instructions

## Repository Purpose

This repository contains public, sanitized inventory examples for ModuLix
automation.

Use it for:

- reference inventory layouts
- sanitized `group_vars` and `host_vars`
- documentation examples for `modulix-automation`
- variable contract examples

Do not put real customer or internal environment values here.
Do not put copy-paste rollout procedures here. This repository is examples only.

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
- Public automation docs in `modulix-automation` are generic examples and
  contracts only, not real rollout procedures.
- Public sanitized inventory examples live here.
- Real environment inventory lives in private `ansible-inventory-*` repos.
- Private operation procedures and copy-paste runbooks live in private
  `modulix-operations-*` repos.

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

## Secret Storage Rule

- Never commit secret values, tokens, passwords, private keys, activation codes, or decrypted Vault output.
- When HC Vault is configured for a role or runbook, generated credentials must be read from HC Vault first, generated only when missing, written back to HC Vault, and then consumed by the application from the Vault-backed Ansible variables. Do not keep generated plaintext secret files on the managed host unless a role has an explicit break-glass option such as `*_allow_local_secret_files=true`.
- When HC Vault is not configured, required credentials must be supplied from Ansible Vault encrypted inventory variables. Do not add new plaintext generated-secret fallbacks.
- Tasks that read, generate, write, template, or compare secret material must use `no_log: true`.

<!-- LIT AI task governance: start -->

## AI model and token governance

Apply `LIT-GEN-GDR-GOV-30-Budget-Conscious-AI-Model-Selection` to every
substantive Codex or ChatGPT-assisted task. Before investigation, planning,
tool use, implementation, or delegation, record a compact task profile in the
task chat: work item, risk (`low`, `normal`, or `high`), smallest sufficient
model/reasoning choice, rationale, and a concrete escalation condition.

- Use the balanced, lowest reliable capability by default. Escalate to a
  premium/frontier model or higher reasoning only for a high-risk decision,
  complex architecture/debugging/dependencies, or a documented focused failure
  of the standard approach. Restrict that escalation to the difficult subtask.
- Never use Speed Mode. Do not replace verification with a more expensive model
  or sacrifice quality to reduce elapsed time.
- Retrieve only relevant issue, files, logs, and source records; avoid broad
  repository or chat-history loading, speculative analysis, and unbounded retry
  loops. Delegate only independent, bounded work that reduces total effort.
- For GitHub or Jira work, include the task profile in the issue/task record
  when AI assistance materially affects execution. Close with verification and
  remaining risks; preserve durable decisions in Confluence, Jira, or GitHub.

<!-- LIT AI task governance: end -->
