# GCP Security Services Baseline

Deploys Workload Identity Federation and Data Access 
audit logs via Terraform for project cgep-lab.

## Services deployed

| Service | Controls | What it does |
|---|---|---|
| Workload Identity Federation | AC-2 | Replaces long-lived SA keys with short-lived OIDC tokens |
| Data Access Audit Logs | AU-2, AU-12 | Records reads/writes to Storage, KMS, IAM |

## Org Policy — not available (standalone project)

This project has no parent Organization so 
google_org_policy_policy resources are not applicable.

The equivalent preventative controls are:
→ WIF replacing service account keys
→ OPA/Rego policy gates in CI/CD pipeline (Lab 3.4)

## Data Access logs enabled

All three services logging DATA_READ, DATA_WRITE, 
and ADMIN_READ — the #1 GCP audit finding when missing!!

## Evidence captured

evidence/lab-5-4/iam-policy.json
→ IAM policy showing auditConfigs per service