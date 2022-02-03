variable "cluster_name" {
  description = "Name of the cluster"
  type = string
  default = "ks-aws-dev"
}
variable "instance_type" {
  description = "EC2 vm instance type to be created"
  type        = string
  default     = "m5.2xlarge"
}

variable "zone" {
  description = "The availability zone for the cluster"
  type        = string
  default     = "us-east-1a"
}

variable "dns_zone" {
  description = "The DNS zone name"
  type = string
  default = "Z01092892MLURSVI2K4L4"
}

variable "disk_size" {
  description = "The default size for EBS volumes"
  type        = string
  default     = "250"
}

variable "key_name" {
  description = "The key pair to use to enable SSH into the instances"
  type        = string
  default     = "ks-galaxy-aws"
}

variable "subnet" {
  description = "The VPC subnet defined in the AWS console."
  type        = string
  default     = "subnet-082222bb425b6e856"
}