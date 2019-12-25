variable "aws_access_key" {
    default = "AKIA6IPAB7T34HY7OZWH"
}
variable "aws_secret_key" {
    default = "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"
}
variable "aws_key_path" {
    default = "/Users/s90762/DevOps/Lab/SCB-AWS_Sandbox/terraform-ansible-master/keys"
}
variable "aws_key_name" {
    default = "fix-key"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "ap-southeast-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        #sa-east-1 = "ami-0669a96e355eac82f"
        ap-southeast-1 = "ami-03bb7d49f98ba72f1"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}