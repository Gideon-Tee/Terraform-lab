# EC2 Deployment

This directory contains Terraform configurations for deploying an EC2 instance hosting a docker container served by an nginx proxy.

## Components

### VPC Module
- Creates a VPC with public subnets
- Sets up Internet Gateway and route tables
- Configures CIDR blocks and availability zones

### Security Groups Module
- Defines security rules for SSH and HTTP access
- Allows inbound SSH (port 22) from allowed IPs
- Allows inbound HTTP (port 80) from the internet

### IAM Module
- Creates an IAM role for EC2 instance
- Attaches optional policies (e.g., for S3, CloudWatch)
- Associates the role with the instance profile

### EC2 Module
- Deploys EC2 instance in a public subnet
- Installs Docker and Nginx using user data
- Pulls and runs a containerized app
- Uses Nginx to serve the application on port 80

## Configuration

### Required Variables
```hcl
region              = "eu-west-1"                      # AWS region
environment         = "ec2-app"                        # Environment name
vpc_cidr            = "10.1.0.0/16"                    # VPC CIDR block
availability_zones  = ["eu-west-1a"]                   # Availability zones
instance_type       = "t2.micro"                       # EC2 instance type
docker_image        = "your-image:latest"              # Application image
allowed_ssh_cidr    = "0.0.0.0/0"                      # CIDR allowed to SSH
key_name            = "your-ec2-keypair"               # Name of existing EC2 key pair
```