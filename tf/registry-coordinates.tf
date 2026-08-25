##[>] 🤖🤖
#[what] every image the cluster pulls, served from the ci project over private google access
#[why] job pods failed `prepare environment` pulling the runner helper: containerd answers the
#   registry's 401 by fetching a token from gitlab.com/jwt/auth, and that connect timed out
#   against public cloudflare space. the token fetch is anonymous, so no credential fixes it.
#   pulling from here removes the public hop entirely
#[why] the repositories themselves live in cross-repo/infra/base, which owns every artifact
#   registry in the group. Only their addresses are needed here, and an address is derived from
#   region, project and repository id: computing it costs nothing and avoids reading base's state,
#   which would couple the two roots the split exists to separate
#[why] the repository ids are literals rather than variables: they are the names base gives its
#   repositories, they change only if base renames one, and a rename would break the pull whatever
#   this root did. Naming them here keeps the derivation readable
locals {
  registry_host    = "${var.region}-docker.pkg.dev"
  go_registry_host = "${var.region}-go.pkg.dev"

  ci_registry              = "${local.registry_host}/${var.ci_project_id}/ci"
  gitlab_registry_proxy    = "${local.registry_host}/${var.ci_project_id}/remote-gitlab"
  dockerhub_registry_proxy = "${local.registry_host}/${var.ci_project_id}/remote-dockerhub"
  go_proxy                 = "${local.go_registry_host}/${var.ci_project_id}/remote-go"
}
##[<] 🤖🤖
