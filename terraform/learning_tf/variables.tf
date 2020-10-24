#----variables.tf

variable "access_key" {}
variable "secret_key" {}

locals {
  aws_region = "us-east-1"

  env = "${terraform.workspace}"

  zones = ["app", "data"]

  instance_types = ["c5.xlarge", "m5.xlarge"]

  avail_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  ami_owner = "420567215"

  ami_filter = "EAST-RH 7*"

  latest_ami_id = "${data.aws_ami.easy_ami.id}"

  ami_id_dev_env = "${data.terraform_remote_state.query_dev_env.ami}"

  env_vpc_map = {
    dev   = "dev"
    impl  = "impl"
    devp  = "devp"
    implp = "impl"
  }

  cpm_backup = {
    dev    = "Daily Weekly"
    impl   = "Daily Weekly"
    devp   = "Daily Weekly"
    implp  = "Daily Weekly"
  }

  subnet_name_prefix = {
    dev   = "ISRAEL"
    impl  = "ISRAEL"
    devp  = "ISRAEL"
    implp = "ISRAEL"
  }
}

variable "private_ip" {
  type = "map"
}
