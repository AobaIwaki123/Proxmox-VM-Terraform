tf-clean:
	rm -rf .terraform
	rm .terraform.lock.hcl
	rm terraform.tfstate
	rm terraform.tfstate.backup

tf-apply:
	terraform apply -var-file terraform.tfvars

tf-destroy:
	terraform destroy -var-file terraform.tfvars
