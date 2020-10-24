#----ami.tf

data "aws_ami" "easy_ami" {
  most_recent = "true"
  owners      = ["${local.ami_owner}"]

  filter {
    name   = "name"
    values = ["${local.ami_filter}"]
  }
}
