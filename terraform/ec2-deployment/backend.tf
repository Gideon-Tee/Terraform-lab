terraform {
  backend "s3" {
    bucket         = "terraform-lab-gmt0211"
    key            = "lab-project/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "lab-terraform-lock"
    encrypt        = true
  }
}