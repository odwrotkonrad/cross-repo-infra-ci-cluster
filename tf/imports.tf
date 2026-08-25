##[>] 🤖🤖
#[why] empty on purpose, and kept as a file so the reason survives. The 33 resources here were not
#   imported: they were moved from cross-repo/infra/iac's state directly, and the state carries what
#   an import cannot
#[why] gitlab_user_runner is why. The runners API returns `groups` and never `group_id`, so an
#   import reads it as unset and terraform plans to add it. group_id forces replacement, which on a
#   runner means destroying the six every pipeline in the group uses and registering new ones with
#   tokens the cluster does not hold. The delete guard caught exactly that
#[why] a state move sidesteps it: the moved state already holds group_id, so nothing is unknown and
#   nothing is replaced. It also avoids re-reading 33 resources through 33 provider imports
##[<] 🤖🤖
