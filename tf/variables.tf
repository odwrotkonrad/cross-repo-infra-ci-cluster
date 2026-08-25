variable "cluster_name" {
  type    = string
  default = "workloads"
}

variable "gitlab_group_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "ci_node_pools" {
  type = map(object({
    arch         = string
    machine_type = string
    disk_type    = string
    fallback     = optional(bool, false)
  }))
  default = {
    linux-amd64          = { arch = "amd64", machine_type = "c3d-standard-4", disk_type = "pd-balanced" }
    linux-arm64          = { arch = "arm64", machine_type = "c4a-standard-4", disk_type = "hyperdisk-balanced" }
    linux-amd64-fallback = { arch = "amd64", machine_type = "n2-standard-4", disk_type = "pd-balanced", fallback = true }
    linux-arm64-fallback = { arch = "arm64", machine_type = "t2a-standard-4", disk_type = "pd-balanced", fallback = true }
  }
}

variable "ci_max_nodes_per_pool" {
  type    = number
  default = 6
}

variable "ci_max_nodes_per_pool_fallback" {
  type    = number
  default = 2
}

variable "ci_disk_size_gb" {
  type    = number
  default = 50
}

variable "manager_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "manager_spot" {
  type    = bool
  default = false
}

variable "runner_namespace" {
  type    = string
  default = "ci-gitlab-runners"
}

variable "runner_service_account" {
  type    = string
  default = "gitlab-runner"
}

variable "job_service_account" {
  type    = string
  default = "ci-job"
}

variable "registry_cache_retention_days" {
  type    = number
  default = 14
}

variable "gitlab_url" {
  type    = string
  default = "https://gitlab.com/"
}

variable "runner_chart_version" {
  type    = string
  default = "0.91.2"
}

variable "runner_helper_version" {
  type    = string
  default = "19.2.2"
}

variable "ci_images_ref" {
  type    = string
  default = "latest"
}

variable "runner_concurrent" {
  type    = number
  default = 124
}

variable "runner_log_level" {
  type    = string
  default = "warn"

  validation {
    condition     = contains(["panic", "fatal", "error", "warning", "warn", "info", "debug"], var.runner_log_level)
    error_message = "runner_log_level must be one of panic, fatal, error, warning, warn, info, debug"
  }
}

variable "runner_poll_timeout" {
  type    = number
  default = 600
}

variable "job_sizes" {
  type = map(object({
    cpu_request    = string
    memory_request = string
    memory_limit   = string
    limit          = number
  }))
  default = {
    small  = { cpu_request = "150m", memory_request = "384Mi", memory_limit = "1Gi", limit = 48 }
    medium = { cpu_request = "750m", memory_request = "2Gi", memory_limit = "6Gi", limit = 12 }
    big    = { cpu_request = "2500m", memory_request = "4Gi", memory_limit = "10Gi", limit = 2 }
  }
}

variable "job_default_size" {
  type    = string
  default = "medium"
}

variable "ci_cpu_quota" {
  type    = number
  default = 72
}

variable "quota_contact_email" {
  type = string
}

variable "runner_cache_retention_days" {
  type    = number
  default = 1
}

#[why] the ci project, created and owned by cross-repo/infra/base along with its enabled services
#   and every artifact registry in it. This root builds the cluster inside that project without
#   owning the project itself, so it takes the id as a value rather than reading base's state
variable "ci_project_id" {
  type = string
}

#[why] the credential the gitlab provider authenticates with, passed explicitly rather than left to
#   GITLAB_TOKEN in the environment: the same bare provider block failed to configure in
#   cross-repo/infra/base for exactly that reason
variable "gitlab_token" {
  type      = string
  sensitive = true
}

#[why] the identity terraform impersonates, created by cross-repo/infra/base and holding the
#   baseCiClusterApplier custom role. Named as a value: base owns it, this root only becomes it
variable "applier_service_account" {
  type    = string
  default = "tf-ci-cluster@main-493613.iam.gserviceaccount.com"
}
##[<] 🤖🤖
