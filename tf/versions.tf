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
  #[why] impersonate_service_account, not a key and not the caller's own identity: the job pod
  #   authenticates as ci-job, which holds nothing on this bucket on purpose. base binds ci-job as
  #   workloadIdentityUser on the applier, so the pod may become it, and this is what asks for that.
  #   Without it terraform reaches the bucket as ci-job and is refused, which is the intended answer
  backend "gcs" {
    bucket                      = "konradodwrot-ci-cluster-tfstate"
    prefix                      = "ci-cluster"
    impersonate_service_account = "tf-ci-cluster@main-493613.iam.gserviceaccount.com"
  }
}
##[<] 🤖🤖
