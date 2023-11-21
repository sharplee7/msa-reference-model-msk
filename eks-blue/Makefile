.PHONY: init
init:
	terraform init

.PHONY: plan
plan:
	terraform plan

.PHONY: apply
apply:
	terraform apply -auto-approve=true -var-file=terraform.tfvars

.PHONY: destroy
destroy:
	terraform destroy -auto-approve=true -var-file=terraform.tfvars