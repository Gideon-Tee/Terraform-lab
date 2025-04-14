
module "vpc" {
  source = "./modules/vpc"
  vpc_name = "Terra-Lab"
  vpc_cidr          = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  public_subnet_name = "Public"
}

module "security_groups" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2-instance"
  security_groups = [module.security_groups.security_group_id]
  ami_id         = "ami-0df368112825f8d8f"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnet_id
}

resource "aws_dynamodb_table" "terraform_lock" {
  name = "lab-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-lab-gmt0211"
  provider = aws.Ireland
}

output "DynamoDB-ID" {
  value = aws_dynamodb_table.terraform_lock.id
}

output "Instance-IP" {
  value = module.ec2.instance_ip
}