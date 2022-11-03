.PHONY: generate-docs
generate-docs: terraform-format generate-network-docs generate-k8s-docs generate-k8s-addons-docs

.PHONY: generate-network-docs
generate-network-docs:
	terraform-docs markdown table --output-file README.md --output-mode inject ./terraform/modules/network

.PHONY: generate-k8s-docs
generate-k8s-docs:
	terraform-docs markdown table --output-file README.md --output-mode inject ./terraform/modules/k8s

.PHONY: generate-addons-docs
generate-k8s-addons-docs:
	terraform-docs markdown table --output-file README.md --output-mode inject ./terraform/modules/addons

.PHONY: terraform-format
terraform-format: terraform-format-modules terraform-format-examples terraform-format-deployments

.PHONY: terraform-format-modules
terraform-format-modules:
	terraform fmt ./terraform/modules/network
	terraform fmt ./terraform/modules/k8s
	terraform fmt ./terraform/modules/addons

.PHONY: terraform-format-examples
terraform-format-examples:
	terraform fmt ./terraform/examples/network
	terraform fmt ./terraform/examples/k8s
	terraform fmt ./terraform/examples/addons

.PHONY: terraform-format-deployments
terraform-format-deployments:
	terraform fmt ./terraform/deployments/gross/network
	terraform fmt ./terraform/deployments/gross/k8s
	terraform fmt ./terraform/deployments/gross/addons
