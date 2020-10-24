#----subnets.tf

data "aws_subnet_ids" "easy_subnet_ids" {
  count  = "${length(local.zones)}"
  vpc_id = "${data.aws_vpcs.easy_vpcs.ids[0]}"

  tags {
    Name = "${local.subnet_name_prefix["${local.env}"]}-${local.env_vpc_map["${local.env}"]}-az1-${local.zones[count.index]}"
  }
}
