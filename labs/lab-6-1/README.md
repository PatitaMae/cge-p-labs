# Lab 6.1: OSCAL Component Definition

## What this is

A machine-readable description of the compliant-s3 Terraform module (Lab 2.3) using NIST's OSCAL format.
An assessor can traverse from control catalog to evidence without ever talking to me.

## Files

| File | What it is |
|---|---|
| component-definitions/compliant-s3-v1/component-definition.json | Describes how the module implements SC-28, AC-3, AU-3, CM-6 |
| profiles/cge-p-minimum/profile.json | Selects the 4 controls from NIST 800-53 catalog |
| evidence/lab-6-1/trestle-validate.txt | Trestle validation output |

## The chain

~~~
OSCAL component-definition.json
  → control-id: sc-28
  → links[rel=evidence]
  → s3://vault/runs/25950881769/evidence-...tar.gz
        ↓
verify-evidence.sh
        ↓
CHAIN INTACT
~~~

## Validation

Both models validated with trestle v4.0.2 (OSCAL 1.2.1):
→ component-definition.json → VALID
→ profile.json → VALID

## Evidence vault

Vault: cgep-lab-grc-evidence-vault-03b801b5
Run ID: 25950881769