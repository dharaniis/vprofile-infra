# vProfile Infrastructure (Terraform)

This repository contains the Terraform configuration for provisioning the AWS infrastructure for the **vProfile** modern cloud-native delivery platform.

## Architecture Overview

- **AWS VPC**: CIDR `10.0.0.0/16` with public subnets across 2 Availability Zones (`us-east-1a`, `us-east-1b`)
- **Amazon EKS Cluster**: Kubernetes v1.30 (`vprofile-eks-cluster`)
- **Managed Node Group**: 1x `t3.large` worker node (min=1, max=2, desired=1) using Amazon Linux 2023 (`AL2023_x86_64_STANDARD`)
- **OIDC Provider**: IAM OpenID Connect Provider for IAM Roles for Service Accounts (IRSA)
- **EBS CSI Driver**: AWS EKS Addon with IRSA role (`AmazonEKS_EBS_CSI_DriverRole`) for dynamic EBS persistent volume provisioning
- **ALB Ingress Support**: Subnets tagged with `kubernetes.io/role/elb = 1` for AWS Load Balancer Controller integration
- **Remote State**: S3 backend (`gitopsbucket-123`)

## Files

- `main.tf`: VPC, subnets, route tables, IAM roles, EKS cluster, node group, OIDC provider, and EBS CSI addon
- `variables.tf`: Configurable parameters (region, VPC CIDR, node types, cluster name, etc.)
- `outputs.tf`: EKS cluster name, ARN, endpoint, and EBS CSI role ARN
- `backend.tf`: S3 remote state configuration
- `iam_policy.json`: IAM Policy document for AWS Load Balancer Controller
- `argocd-ingress.yaml`: Kubernetes Ingress manifest to expose the ArgoCD UI via AWS Application Load Balancer with SSL

## Deployment

```bash
terraform init
terraform plan
terraform apply
```

To update `kubeconfig` to connect to the cluster:

```bash
aws eks update-kubeconfig --name vprofile-eks-cluster --region us-east-1
```
