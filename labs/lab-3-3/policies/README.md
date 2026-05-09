# Compliance Policies — Lab 3.3

Three OPA/Rego policies mapping to NIST 800-53 controls.
Evaluated against `terraform plan -json` output before any infrastructure is applied.

## Policies

### SC-28 — Encryption at Rest
- **File:** `sc28_encryption.rego`
- **Control:** NIST 800-53 SC-28
- **Severity:** High
- **What it checks:** Every `google_storage_bucket` has a CMEK encryption block
- **Remediation:** Add `encryption { default_kms_key_name = ... }` referencing a `google_kms_crypto_key`

### AC-3 — Access Enforcement
- **File:** `ac3_no_public.rego`
- **Control:** NIST 800-53 AC-3
- **Severity:** Critical
- **What it checks:** Buckets have `uniform_bucket_level_access=true` and `public_access_prevention="enforced"`. Firewalls don't expose ports 22 or 3389 to `0.0.0.0/0`
- **Remediation:** Set access controls explicitly on buckets. Narrow firewall source ranges.

### CM-6 — Configuration Settings
- **File:** `cm6_required_tags.rego`
- **Control:** NIST 800-53 CM-6
- **Severity:** Medium
- **What it checks:** Every taggable resource carries four required labels: `project`, `environment`, `managed_by`, `compliance_scope`
- **Remediation:** Add all four required labels to every resource

## Running the policies

```bash
# Run all tests
opa test -v policies/

# Evaluate against a real plan
opa eval -d policies -i terraform/plan.json data.compliance.sc28.deny --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.ac3.deny --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.cm6.deny --format=pretty
```

## Test results

8/8 tests passing. See `evidence/lab-3-3/opa-test-results.json` for full output.