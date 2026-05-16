# CGE-P Labs — GRC Engineering Portfolio

This repository documents my journey through the **Certified GRC Engineer Practitioner (CGE-P)** certification labs by AJ Yawn (Executive Chairman & Founder) & Abdie Mohamed (President) of the GRC Engineering Club — building a production-grade, automated compliance program from scratch.

## What this repo demonstrates

Most GRC work is manual, reactive, and screenshot-dependent. This portfolio proves a different approach: compliance controls built as code, evidence captured automatically, and audit trails that an assessor can verify without ever talking to me.

## The stack

| Layer | Tools |
|---|---|
| Infrastructure as Code | Terraform (AWS + GCP) |
| Policy as Code | OPA/Rego, Conftest, tfsec |
| CI/CD Pipeline | GitHub Actions |
| Evidence Vault | AWS S3 Object Lock, Cosign |
| Compliance Standard | NIST 800-53 Rev. 5 |
| Evidence Format | OSCAL |

## Lab structure

~~~
labs/
├── lab-2-3/   # Compliant S3 bucket (AWS)
├── lab-2-4/   # Terraform modules (GCP)
├── lab-2-5/   # Immutable evidence vault (AWS S3 Object Lock)
├── lab-3-3/   # Policy as Code — OPA/Rego (GCP)
├── lab-3-4/   # Conftest policy gate (AWS)
├── lab-4-3/   # GitHub Actions evidence pipeline
├── lab-4-4/   # Cosign signing + chain of custody
├── lab-5-2/   # AWS security services baseline
├── lab-5-4/   # GCP security services baseline
└── lab-6-1/   # OSCAL component definition
~~~

## The evidence chain

Every pull request on this repo triggers an automated pipeline that:

1. Runs terraform plan against the infrastructure
2. Evaluates NIST 800-53 controls via Conftest policy gate
3. Scans for security issues via tfsec
4. Bundles all evidence into a signed tamper-proof artifact
5. Uploads to an immutable S3 vault with Object Lock

An auditor can verify any run with a single command:

~~~bash
EVIDENCE_VAULT="cgep-lab-grc-evidence-vault-03b801b5" \
bash scripts/verify-evidence.sh <run_id>
# Output: CHAIN INTACT for run <run_id>
~~~

## NIST 800-53 controls implemented

| Control | Description | Lab |
|---|---|---|
| AU-2, AU-9, AU-10, AU-12 | Audit logging + evidence protection | 2.5, 4.3, 4.4 |
| SC-28 | Encryption at rest | 2.3, 3.3, 3.4 |
| AC-3 | Access enforcement | 2.3, 3.3, 3.4 |
| CM-3, CM-6 | Configuration management | 3.3, 3.4, 4.3 |
| CA-2, CA-7 | Continuous monitoring | 4.3 |
| RA-5 | Vulnerability scanning | 4.3 |

## OSCAL

The OSCAL component definition in labs/lab-6-1 describes how the compliant-s3 module implements SC-28, AC-3, AU-3, and CM-6. Evidence URIs point at signed objects in the vault — verified with verify-evidence.sh returning CHAIN INTACT.

## Resources

- [CGE-P Lab Guides](https://github.com/GRCEngClub/cgep-labs) — 
  official lab content by AJ Yawn / GRC Engineering Club
- [GRC Engineering Club](https://grcengineering.com) — 
  CGE-P certification program

## Credits

Lab content created by:
- [AJ Yawn](https://github.com/aynole) — Executive Chairman & Founder, GRC Engineering Club 
- [Abdie Mohamed](https://github.com/abdie-grcengineer) — President, GRC Engeeniring Club