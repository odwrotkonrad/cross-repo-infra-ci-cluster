##[>] 🤖🤖
provider "google" {
  project = var.ci_project_id
  region  = var.region
}

provider "gitlab" {
  token = var.gitlab_token
}

#[why] the CA certificate is read off the cluster resource rather than through an output: it is the
#   one value here that would be a sensitive output, and this root publishes none. Reading it in
#   place keeps it inside the state that already holds it
#[why] the access token comes from the google provider's own credentials, so the kubernetes and helm
#   providers authenticate as whoever ran terraform: the applier in CI, the user locally. That is
#   also why GKE authorises namespace and service account writes through IAM rather than a kubeconfig
provider "kubernetes" {
  host                   = "https://${google_container_cluster.ci.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.ci.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.ci.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.ci.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

data "google_client_config" "default" {}
##[<] 🤖🤖
