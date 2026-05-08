This module enforces the following NIST 800-53 controls on a GCS bucket:

- SC-12: Cryptographic key establishment (KMS keyring with customer-managed key)
- SC-13: Cryptographic protection (CMEK AES-256 encryption)
- SC-28: Protection of information at rest (bucket encryption)
- AU-11: Retention of audit records (configurable retention policy)
- CM-6: Configuration settings (required compliance labels)