# Terraform Kubernetes Operator

This repo is a companion repo to the
[Deploy Infrastructure with the Terraform Cloud Operator for Kubernetes]
(https://learn.hashicorp.com/tutorials/terraform/kubernetes-operator?utm_source=WEBSITE&utm_medium=GITHUB)
learn guide.

# Or setup manually
brew install kubernetes-cli
brew install kind
kind create cluster --name terraform-learn
kind get clusters
kubectl cluster-info --context kind-terraform-learn

# Create infrastructure
terraform init
terraform plan
terraform apply
