# Lab 4.4: Evidence Chain of Custody

## Chain of Custody Properties

### 1. Authenticity
**What it means:** Proves the evidence was created by a specific, 
verified identity — not just anyone with AWS access.

**How we prove it:** Cosign keyless signing via GitHub OIDC.
When the pipeline runs, GitHub mints an OIDC token identifying 
the exact repository and workflow. Sigstore Fulcio issues a 
short-lived certificate tied to that identity. The certificate 
is embedded in the `.sig.bundle` file alongside the signature.

**Artifact:** `evidence-<run_id>-<sha>.tar.gz.sig.bundle`

---

### 2. Integrity
**What it means:** Proves the evidence has not been modified 
since it was created.

**How we prove it:** SHA-256 hash computed at signing time and 
stored as a sidecar `.sha256` file. Any modification — even a 
single byte — produces a completely different hash. The tamper 
test proved this: adding "junk" to the bundle changed the hash 
from `6619042d...` to `b624d784...` immediately.

**Artifact:** `evidence-<run_id>-<sha>.tar.gz.sha256`

---

### 3. Timeliness
**What it means:** Proves WHEN the evidence was created — 
not just that it exists.

**How we prove it:** Sigstore Rekor transparency log records 
the signature with a cryptographic timestamp at signing time. 
This timestamp is independent of AWS and cannot be backdated 
by anyone with admin access to the AWS account.

**Artifact:** Rekor entry embedded in `.sig.bundle` 
(verified via `cosign verify-blob`)

---

### 4. Preservation
**What it means:** Proves the evidence cannot be deleted 
or overwritten before retention expires.

**How we prove it:** AWS S3 Object Lock in GOVERNANCE mode 
with 1-day default retention. Every uploaded object receives 
a `RetainUntilDate` automatically. Even account administrators 
cannot delete objects before that date without explicitly 
bypassing GOVERNANCE mode.

**Artifact:** S3 Object Lock retention confirmed via 
`aws s3api get-object-retention`

---

## Verification

Run against any pipeline run ID:

```bash
EVIDENCE_VAULT="cgep-lab-grc-evidence-vault-03b801b5" \
bash scripts/verify-evidence.sh <run_id>
```

Expected output:

```
=== 1. Integrity (SHA-256) ===
OK (fe6169bc...)
=== 2. Authenticity + timestamp (Cosign + Sigstore Rekor) ===
Verified OK
OK (Cosign verified, Rekor entry exists)
=== 3. Preservation (Object Lock retention) ===
OK (retain until ...)
CHAIN INTACT for run <run_id>
```

## Tamper Test Result

Modifying the bundle after signing produces a different SHA-256:

```
Original:  6619042dd734...
Tampered:  b624d784fba2...
Expected:  fe6169bc951e...
```

verify-evidence.sh exits with `FAIL: SHA mismatch` — 
the chain is broken and the auditor knows immediately.

## What breaks the chain

| Threat | Protection |
|---|---|
| Evidence deleted | S3 Object Lock — deletion blocked |
| Evidence modified | SHA-256 hash — mismatch detected |
| Evidence backdated | Rekor timestamp — cannot be faked |
| Wrong identity | Cosign cert — tied to specific repo/workflow |
| All four | CHAIN INTACT confirms all pass |