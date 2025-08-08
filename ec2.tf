terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = "us-west-2"
}


variable "env" {
  type    = string
  default = "dev"
}

locals {
  instance_types = {
    main  = "t3.large"
    minor = "t3.micro"
    prod  = "t3.large"
    dev   = "t3.nano"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-04e08e36e17a21b56"
  instance_type = lookup(local.instance_types, var.env, "t2.nano")

  tags = {
    Name = "web-${var.env}"
  }
}
