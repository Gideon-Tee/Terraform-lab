variable "state_bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state files"
  type        = string
  default     = "lab-terraform-state-eks"
}

variable "locks_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "lab-terraform-lock-eks"
}
