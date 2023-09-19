terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16"
    }
  }
  required_version = ">= 1.0.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}



resource "aws_elastic_beanstalk_application" "2048app" {
  name        = "2048app-shani-daria"
  description = "2048app-shani-daria"
}

resource "aws_elastic_beanstalk_environment" "2048appenv" {
  name                = "2048app-shani-daria"
  application         = aws_elastic_beanstalk_application.2048app.name
  solution_stack_name = "64bit Amazon Linux Docker running on 2023/4.0.1"


  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-0d37ae25adc984356"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-0eb0c47b5d27e872e"
  }
}