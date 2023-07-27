terraform {
  required_version = ">= 1.5.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }

  cloud {
    organization = "jacobm"

    workspaces {
      name = "gcp"
    }
  }
}