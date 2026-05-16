output "wif_pool_name" {
  value = google_iam_workload_identity_pool.github.name
}

output "service_account_email" {
  value = google_service_account.gha.email
}