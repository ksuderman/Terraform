variable "instance_type" {
  description = "GCP vm instance type to be created"
  type        = string
  default     = "c2.standard.16"
}

variable "region" {
    description = "Region where the zones will reside"
    type = "string"
    default = "us-east1"
}
variable "zone" {
  description = "The availability zone for the cluster"
  type        = string
  default     = "us-east1-b"
}

variable "volume_size" {
  description = "The default size for persistent volumes"
  type        = string
  default     = "250"
}

variable "key_name" {
  description = "The key pair to use to enable SSH into the instances"
  type        = string
  default     = "ks-galaxy-aws"
}

