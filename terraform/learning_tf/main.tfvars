#----main.tf

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "easy-devsecops-terraform-state"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "us-east-1"
    key            = "terraform.tfstate"
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${local.aws_region}"
}
