# AWS Security Services Baseline

Deploys CloudTrail, Security Hub, and AWS Config via Terraform.
Together these form the AWS-native compliance backbone —
continuously producing evidence after every infrastructure change.

## Services and NIST 800-53 controls

| Service | Controls | What it does |
|---|---|---|
| CloudTrail | AU-2, AU-12, AU-10 | Records all API activity with log file validation |
| Security Hub | RA-5, SI-4 | Aggregates findings from ~300 automated checks |
| AWS Config | CM-2, CM-6, CM-8 | Records resource configurations and detects drift |

## Evidence captured

evidence/lab-5-2/security-hub-findings.json
→ Security Hub findings in JSON format
→ uploaded to Lab 2.5 vault via capture-evidence.sh