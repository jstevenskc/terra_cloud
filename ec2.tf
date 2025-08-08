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
  region     = "us-west-1"
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
    dev   = "t2.micro"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = lookup(local.instance_types, var.env, "t2.nano")

  tags = {
    Name = "web-${var.env}"
  }
}
