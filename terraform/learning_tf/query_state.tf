data "terraform_remote_state" "query_dev_env" {
  backend = "s3"

  config {
    bucket = "easy-devsecops-terraform-state"
    key = "env:/dev/terraform.tfstate"
    region = "us-east-1"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${local.aws_region}"
  }
}
