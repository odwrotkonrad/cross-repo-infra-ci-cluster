##[>] 🤖🤖
#[what] Project's Makefile
SHELL := zsh
.SHELLFLAGS := -c
TF ?= terraform

COMMANDS := init fmt validate lock plan apply

.PHONY: $(COMMANDS)

##[>] Terraform [genai-include]
#[why] this root IS applied by CI, unlike cross-repo/infra/base: it holds no identity anything else
#   depends on, so its pipeline runs as tf-ci-cluster and reaches its own state and nothing else.
#   The targets below are what that pipeline runs, and what a local run uses too
#[what] init the backend and providers
init:
	$(TF) -chdir=tf init -input=false

#[what] format all terraform files in place
fmt:
	$(TF) -chdir=tf fmt -recursive

#[why] no init here, though validate needs the providers installed: `init -backend=false`
#   discards the gcs configuration, so the next plan fails "Backend initialization required"
#[what] check formatting and validate the config
validate:
	$(TF) -chdir=tf fmt -check -recursive
	$(TF) -chdir=tf validate

#[what] regenerate the provider lock with hashes for all CI + dev platforms
lock:
	$(TF) -chdir=tf providers lock -platform=linux_amd64 -platform=linux_arm64 -platform=darwin_arm64 -platform=darwin_amd64

#[why] a saved plan file, applied unchanged: what is reviewed is what lands, and every plan is
#   checked for delete actions before it is applied. This root builds the cluster every pipeline in
#   the group runs on, so a surprise delete here stops all CI
#[what] show the plan (writes tf/plan.tfplan)
plan:
	$(TF) -chdir=tf plan -input=false -out=plan.tfplan

#[what] apply the saved plan (plan.tfplan)
apply:
	$(TF) -chdir=tf apply -input=false plan.tfplan
##[<] Terraform
##[<] 🤖🤖
