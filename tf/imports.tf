##[>] 🤖🤖
#[why] every block here adopts a live resource: the cluster and everything around it was built by
#   cross-repo/infra/iac, which is being emptied. A block turns the first plan's create into an
#   import, and iac forgets the resource afterwards with a removed block
#[why] nothing here may be created. This is the cluster every pipeline in the group runs on, so the
#   only acceptable first plan is import-only: no add, no change, no destroy
#[why] the project, its enabled services and every artifact registry are absent on purpose: those
#   belong to cross-repo/infra/base, which already owns them. So are the nine ci_applier bindings,
#   replaced by the baseCiClusterApplier custom role
#[why] delete a block once its apply has run: an adopted resource is in state, so the block is dead
#   config that only slows the next plan

import {
  to = gitlab_user_runner.ci["linux-amd64-big"]
  id = "55207865"
}

import {
  to = gitlab_user_runner.ci["linux-amd64-medium"]
  id = "55207870"
}

import {
  to = gitlab_user_runner.ci["linux-amd64-small"]
  id = "55207866"
}

import {
  to = gitlab_user_runner.ci["linux-arm64-big"]
  id = "55207869"
}

import {
  to = gitlab_user_runner.ci["linux-arm64-medium"]
  id = "55207868"
}

import {
  to = gitlab_user_runner.ci["linux-arm64-small"]
  id = "55207867"
}

import {
  to = google_cloud_quotas_quota_preference.cpus_all_regions
  id = "projects/staging-499418/locations/global/quotaPreferences/compute-cpus-all-regions"
}

import {
  to = google_compute_network.ci
  id = "projects/staging-499418/global/networks/workloads"
}

import {
  to = google_compute_router.ci
  id = "projects/staging-499418/regions/us-central1/routers/workloads"
}

import {
  to = google_compute_router_nat.ci
  id = "staging-499418/us-central1/workloads/workloads"
}

import {
  to = google_compute_subnetwork.ci
  id = "projects/staging-499418/regions/us-central1/subnetworks/workloads"
}

import {
  to = google_container_cluster.ci
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads"
}

import {
  to = google_container_node_pool.ci["linux-amd64"]
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads/nodePools/linux-amd64"
}

import {
  to = google_container_node_pool.ci["linux-amd64-fallback"]
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads/nodePools/linux-amd64-fallback"
}

import {
  to = google_container_node_pool.ci["linux-arm64"]
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads/nodePools/linux-arm64"
}

import {
  to = google_container_node_pool.ci["linux-arm64-fallback"]
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads/nodePools/linux-arm64-fallback"
}

import {
  to = google_container_node_pool.manager
  id = "projects/staging-499418/locations/us-central1-a/clusters/workloads/nodePools/manager"
}

import {
  to = google_project_iam_member.node["roles/logging.logWriter"]
  id = "staging-499418/roles/logging.logWriter/serviceAccount:gke-node@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.node["roles/monitoring.metricWriter"]
  id = "staging-499418/roles/monitoring.metricWriter/serviceAccount:gke-node@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.node["roles/monitoring.viewer"]
  id = "staging-499418/roles/monitoring.viewer/serviceAccount:gke-node@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.node["roles/stackdriver.resourceMetadata.writer"]
  id = "staging-499418/roles/stackdriver.resourceMetadata.writer/serviceAccount:gke-node@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_project_service.cloudquotas
  id = "staging-499418/cloudquotas.googleapis.com"
}

import {
  to = google_service_account.ci_job
  id = "projects/staging-499418/serviceAccounts/ci-job@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_service_account.node
  id = "projects/staging-499418/serviceAccounts/gke-node@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_service_account.runner
  id = "projects/staging-499418/serviceAccounts/gitlab-runner@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_service_account_iam_member.ci_job_workload_identity
  id = "projects/staging-499418/serviceAccounts/ci-job@staging-499418.iam.gserviceaccount.com/roles/iam.workloadIdentityUser/serviceAccount:staging-499418.svc.id.goog[ci-gitlab-runners/ci-job]"
}

import {
  to = google_service_account_iam_member.runner_sign
  id = "projects/staging-499418/serviceAccounts/gitlab-runner@staging-499418.iam.gserviceaccount.com/roles/iam.serviceAccountTokenCreator/serviceAccount:gitlab-runner@staging-499418.iam.gserviceaccount.com"
}

import {
  to = google_service_account_iam_member.runner_workload_identity
  id = "projects/staging-499418/serviceAccounts/gitlab-runner@staging-499418.iam.gserviceaccount.com/roles/iam.workloadIdentityUser/serviceAccount:staging-499418.svc.id.goog[ci-gitlab-runners/gitlab-runner]"
}

import {
  to = google_storage_bucket.runner_cache
  id = "staging-499418-runner-cache"
}

import {
  to = google_storage_bucket_iam_member.runner_cache
  id = "b/staging-499418-runner-cache/roles/storage.objectAdmin/serviceAccount:gitlab-runner@staging-499418.iam.gserviceaccount.com"
}

import {
  to = helm_release.runner
  id = "gitlab-runner"
}

import {
  to = kubernetes_namespace_v1.runner
  id = "ci-gitlab-runners"
}

import {
  to = kubernetes_service_account_v1.ci_job
  id = "ci-gitlab-runners/ci-job"
}
##[<] 🤖🤖
