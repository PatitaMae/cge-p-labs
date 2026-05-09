# Lab 3.3: Policy as Code (GCP)

## What this lab does

Terraform builds infrastructure. But how do you prove it follows compliance
rules before it deploys? This lab uses OPA and Rego to evaluate Terraform
plans against NIST 800-53 controls — catching violations before anything
touches real infrastructure.

## The big idea

Terraform plan → plan.json → OPA evaluates → violations reported instantly.
No deployment needed. No screenshots. No manual review.

## Three controls enforced

| Policy | Control | What it catches |
|---|---|---|
| sc28_encryption.rego | SC-28 | Buckets missing CMEK encryption |
| ac3_no_public.rego | AC-3 | Public buckets and open firewall ports |
| cm6_required_tags.rego | CM-6 | Resources missing required labels |

## Why this beats screenshots

| Screenshot | Policy as Code |
|---|---|
| "I once saw this" | Proves what was deployed |
| Manual, error-prone | Automated, runs every time |
| No remediation guidance | Tells developer exactly how to fix it |

## Results

- 8/8 tests passing
- SC-28: bad_no_cmek correctly flagged
- AC-3: bad_public and open_ssh correctly flagged
- CM-6: bad_no_labels correctly flagged
- good bucket silent across all three policies

## See also

- policies/README.md — detailed policy documentation
- evidence/lab-3-3/opa-test-results.json — full test output