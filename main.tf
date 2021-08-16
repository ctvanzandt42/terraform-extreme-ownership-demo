terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.65"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~> 1.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "launchdarkly" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus"

  tags = {
    Environment = "Terraform Extreme Ownership"
    Team        = "TF-EO"
  }
}

resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1

  hash_key         = "myAttribute"
  name             = "myTable"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "myAttribute"
    type = "S"
  }
}

data "launchdarkly_environment" "ld_env" {
  key         = "test"
  project_key = "default"
}
