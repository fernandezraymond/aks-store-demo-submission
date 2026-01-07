.PHONY: format validate plan apply destroy all plan-debug

format:
	terraform fmt -recursive -check

validate:
	terraform validate

plan:
	terraform plan -out=tfplan.binary
	terraform show -json tfplan.binary > tfplan.json

plan-debug:
	TF_LOG=DEBUG terraform plan -out=tfplan.binary

apply:
	terraform apply tfplan.binary

destroy:
	terraform apply -destroy -auto-approve

all: format validate plan apply
all-debug: format validate plan-debug