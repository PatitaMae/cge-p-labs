# NOTE: Org Policy requires Organization-level GCP setup
# This standalone project (cgep-lab) has no parent organization
# Org Policy enforcement is therefore not available at project scope
# The equivalent preventative controls are implemented via:
# → WIF replacing service account keys (wif.tf)
# → Data Access audit logs (audit_logs.tf)
# → OPA/Rego policy gates in the CI/CD pipeline (Lab 3.4)

# CM-6, AC-2, AC-3: Org Policy enforcement at API level

# resource "google_org_policy_policy" "uniform_bucket_access" {
#  name   = "projects/${var.gcp_project}/policies/storage.uniformBucketLevelAccess"
#  parent = "projects/${var.gcp_project}"

#  spec {
#    rules { enforce = "TRUE" }
#  }
#}

#resource "google_org_policy_policy" "disable_sa_keys" {
#  name   = "projects/${var.gcp_project}/policies/iam.disableServiceAccountKeyCreation"
#  parent = "projects/${var.gcp_project}"
#
#  spec {
#    rules { enforce = "TRUE" }
#  }
#}

#resource "google_org_policy_policy" "require_oslogin" {
#  name   = "projects/${var.gcp_project}/policies/compute.requireOsLogin"
#  parent = "projects/${var.gcp_project}"
#
#  spec {
#    rules { enforce = "TRUE" }
#  }
# }