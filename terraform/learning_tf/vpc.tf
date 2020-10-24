data "aws_vpcs" "easy_vpcs" {
  tags {
    Name = "ISRAEL-${local.env_vpc_map["${local.env}"]}-vpc"
  }
}
