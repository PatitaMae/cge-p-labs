terraform {
  required_version = ">= 1.6"
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
  }
}

provider "google" {
  project               = var.gcp_project
  region                = "us-central1"
  billing_project       = "cgep-lab"
  user_project_override = true
}

variable "gcp_project" {
  type    = string
  default = "cgep-lab"
}

variable "github_org" {
  type    = string
  default = "PatitaMae"
}

variable "github_repo" {
  type    = string
  default = "cge-p-labs"
}

data "google_project" "current" {}