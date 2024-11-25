tf-clean:
	rm -rf .terraform
	rm .terraform.lock.hcl
	rm terraform.tfstate
	rm terraform.tfstate.backup

tf-init:
	terraform init
	
tf-apply:
	terraform apply -auto-approve

tf-destroy:
	terraform destroy -auto-approve
