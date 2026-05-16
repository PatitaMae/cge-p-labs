output "cloudtrail_bucket" {
  value = aws_s3_bucket.trail.id
}

output "security_hub_arn" {
  value = aws_securityhub_account.this.id
}