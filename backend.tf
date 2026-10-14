terraform {
  backend "s3" {
    bucket = "gitopsbucket-123"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
