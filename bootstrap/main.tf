# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"

  #backend "s3" {
  #  bucket         = "your_globally_unique_bucket_name"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-east-1"
  # version = "~> 2.36.0"
}


module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "ks-gh-aws-test-tfstate"
  dynamo_db_table_name        = "ks-gh-aws-test-locks"
  # iam_user_name               = "KeithsTerraformGitHubBot"
  # ado_iam_role_name           = "IamRole"
  # aws_iam_policy_permits_name = "IamPolicyPermits"
  # aws_iam_policy_assume_name  = "IamPolicyAssume"
}