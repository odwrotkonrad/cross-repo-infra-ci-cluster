##[>] 🤖🤖
terraform {
  required_version = "~> 1.15"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }

  #[why] its own bucket, created by cross-repo/infra/base along with the applier pair bound to it:
  #   tf-ci-cluster writes, tf-ci-cluster-ro reads, and neither reaches another repo's state
  backend "gcs" {
    bucket = "konradodwrot-ci-cluster-tfstate"
    prefix = "ci-cluster"
  }
}
##[<] 🤖🤖
