terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.7.0"
    }
  }
}

provider "aws" {
  profile = "tbaba"
  region  = var.region
}

resource "aws_instance" "example" {
  ami                    = "ami-0f2dd5fc989207c82"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0f9554fe0b9d093bf"]
  subnet_id              = "subnet-0ebf397e3bc67a9e3"
  tags = {
    "Name" = "otameshi"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
