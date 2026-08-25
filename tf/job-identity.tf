##[>] 🤖🤖
#[what] the identity job pods run as, so infra/oci-images can publish without a key
#[why] the runner manager's workload identity binding covers the manager pod only. job pods set
#   no service account, so they ran as the namespace `default`, bound to nothing. granting that
#   account would grant every workload that also defaults, hence a named one
resource "google_service_account" "ci_job" {
  project      = var.ci_project_id
  account_id   = "ci-job"
  display_name = "GitLab CI job pod"
}

resource "kubernetes_service_account_v1" "ci_job" {
  metadata {
    name      = var.job_service_account
    namespace = var.runner_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.ci_job.email
    }
  }

  depends_on = [kubernetes_namespace_v1.runner]
}

resource "google_service_account_iam_member" "ci_job_workload_identity" {
  service_account_id = google_service_account.ci_job.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${google_container_cluster.ci.workload_identity_config[0].workload_pool}[${var.runner_namespace}/${var.job_service_account}]"
}
##[<] 🤖🤖
