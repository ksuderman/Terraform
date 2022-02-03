terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# resource "aws_ebs_volume" "disk1" {
#   availability_zone = var.zone
#   size              = var.disk_size

#   tags = {
#     Name = "disk1"
#   }
# }

# resource "aws_volume_attachment" "ebs_vm1" {
#   device_name = "/dev/sdh"
#   volume_id = aws_ebs_volume.disk1.id
#   instance_id = aws_instance.vm1.id
# }

# resource "aws_subnet" "subnet" {
#   vpc_id            = "vpc-01bf81cac9d4a5f70"
#   cidr_block        = "10.0.0.0/24"
#   availability_zone = var.zone

#   tags = {
#     Name = "ks-benchmark-subnet"
#   }
# }

resource "aws_eip" "frontend" {
  instance = aws_instance.vm1.id
  vpc      = true
}

resource "aws_route53_record" "bench3" {
  zone_id = var.dns_zone
  name    = "bench3.usegvl.org"
  type    = "A"
  ttl     = "3600"
  records = [aws_eip.frontend.public_ip]
}

resource "aws_network_interface" "gateway" {
  subnet_id       = var.subnet
  security_groups = ["sg-01d3bb3198fb64c62"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "vm1" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 250
  }

  network_interface {
    network_interface_id = aws_network_interface.gateway.id
    device_index         = 0
  }

  tags = {
    Name  = "BenchmarkDev"
    Owner = "ks"
  }
}

