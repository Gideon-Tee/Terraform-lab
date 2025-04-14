terraform {
  backend "s3" {
    bucket         = "lab-terraform-state-eks"
    key            = "eks-deployment/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "lab-terraform-lock-eks"
    encrypt        = true
  }
}

