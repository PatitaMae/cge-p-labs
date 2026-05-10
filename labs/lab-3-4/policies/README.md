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

## AWS Variants

### SC-28 — Encryption at Rest (AWS)
- **File:** `sc28_encryption_aws.rego`
- **Control:** NIST 800-53 SC-28
- **Severity:** High
- **What it checks:** Every `aws_s3_bucket` has a matching `aws_s3_bucket_server_side_encryption_configuration`
- **Remediation:** Add `aws_s3_bucket_server_side_encryption_configuration` referencing the bucket

### AC-3 — Access Enforcement (AWS)
- **File:** `ac3_no_public_aws.rego`
- **Control:** NIST 800-53 AC-3
- **Severity:** Critical
- **What it checks:** Every `aws_s3_bucket` has a complete `aws_s3_bucket_public_access_block` with all four flags true
- **Remediation:** Add public access block with all four flags set to true

### CM-6 — Configuration Settings (AWS)
- **File:** `cm6_required_tags_aws.rego`
- **Control:** NIST 800-53 CM-6
- **Severity:** Medium
- **What it checks:** Every taggable AWS resource carries four required tags via `tags_all` or `tags`
- **Remediation:** Add missing tags or use provider `default_tags`

## Cloud Coverage Summary

| Policy | Control | GCP | AWS |
|---|---|---|---|
| sc28_encryption.rego / sc28_encryption_aws.rego | SC-28 | ✅ | ✅ |
| ac3_no_public.rego / ac3_no_public_aws.rego | AC-3 | ✅ | ✅ |
| cm6_required_tags.rego / cm6_required_tags_aws.rego | CM-6 | ✅ | ✅ |

## Running the policies

### OPA tests
```bash
# Run all tests
opa test -v policies/
```

### Evaluate against a real plan (OPA)
```bash
opa eval -d policies -i terraform/plan.json data.compliance.sc28.deny --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.ac3.deny --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.cm6.deny --format=pretty
```

### Run via Conftest (AWS)
```bash
conftest test --policy policies --namespace compliance.sc28_aws plan.json
conftest test --policy policies --namespace compliance.ac3_aws plan.json
conftest test --policy policies --namespace compliance.cm6_aws plan.json
```

### Run the full policy gate
```bash
bash scripts/policy-gate.sh --workspace <path-to-terraform-workspace>
```

## Test results

- 8/8 OPA tests passing
- Conftest gate: PASS on compliant plan, FAIL on broken plan
- See `evidence/lab-3-4/conftest-pass.json` and `evidence/lab-3-4/conftest-fail.json`