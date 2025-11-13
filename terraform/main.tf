terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # For now, use a local backend. You can later swap to S3 + DynamoDB if desired.
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}

# Core network and security primitives
module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

# Application workload (e.g., ECS service, task definition)
module "ecs_app" {
  source = "./ecs-app"
}

# Logging, metrics, and monitoring configuration
module "cloudwatch" {
  source = "./cloudwatch"
}
