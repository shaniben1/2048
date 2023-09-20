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






data "aws_s3_bucket_object" "s3project" {
  bucket = "project-daria-shani"
  key    = "2048/Dockerfile"
}


output "s3_object_content" "s3output"{
  value = data.aws_s3_bucket_object.s3project.body
}






# Create elastic beanstalk application

resource "aws_elastic_beanstalk_application" "2048app" {
  name        = "2048app-shani-daria"
  description = "2048app-shani-daria"

}

resource "aws_elastic_beanstalk_environment" "2048appenv" {
  name                = "env2048app-shani-daria"
  application         = aws_elastic_beanstalk_application.2048app.name
  solution_stack_name = ""64bit Amazon Linux 2 v5.5.2 running Node.js 16""
  version_label = 1.0
  bucket      = "aws_s3_bucket_object.s3project.bucket"
  key         = "s3_object_content.s3output.value"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = vpc-0d37ae25adc984356
  }

    setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-0eb0c47b5d27e872e"
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }


  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  depends_on = [aws_s3_bucket_object.s3project]
  depends_on = [s3_object_content.s3output]

}


