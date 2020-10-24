#----security_groups.tf

resource "aws_security_group" "default_group" {
  count       = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  name        = "${local.env}-default-sg"
  description = "Default SG ${local.env} env"
  vpc_id      = "${data.aws_vpcs.easy_vpcs.ids[0]}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH-DEVOPS"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH-NESSUS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "default-${local.env}-sg"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "default"
    maintainer = "israel@gmail.com"
    zone = "all"
  }
}
