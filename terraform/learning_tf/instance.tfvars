#----instance.tf

resource "aws_instance" "fuse_az_instance" {
  count                  = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  ami                    = "${local.env == "dev" ? local.latest_ami_id : local.ami_id_dev_env }"
  instance_type          = "${local.instance_types[0]}"
  availability_zone      = "${local.avail_zones[0]}"
  tenancy                = "dedicated"
  key_name               = "${local.env}-az-ec2"
  monitoring             = "true"
  vpc_security_group_ids = ["${aws_security_group.default_group.id}", "${aws_security_group.jboss_az_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.easy_subnet_ids.*.ids[0],0)}"
  private_ip             = "${var.private_ip["${local.env}-jboss-az"]}"
  ebs_optimized          = "true"
  iam_instance_profile   = "SSMInstanceProfile"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  volume_tags {
    Name = "fuse-${local.env}-${local.zones[0]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "fuse"
    maintainer = "israel@gmail.com"
    zone = "az"
  }

  tags = {
    Name = "fuse-${local.env}-${local.zones[0]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    maintainer = "israel@gmail.com"
    gold_disk_name = "${data.aws_ami.easy_ami.id}"
    os_license = "Red Hat Enterprise Linux"
    zone = "az"
    purpose = "fuse"
    "schedule" = "moved-${local.env}-office-hours"
  }
}

resource "aws_instance" "amq_dz_instance" {
  count                  = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  ami                    = "${local.env == "dev" ? local.latest_ami_id : local.ami_id_dev_env }"
  instance_type          = "${local.instance_types[1]}"
  availability_zone      = "${local.avail_zones[0]}"
  tenancy                = "dedicated"
  key_name               = "${local.env}-dz-ec2"
  monitoring             = "true"
  vpc_security_group_ids = ["${aws_security_group.default_group.id}", "${aws_security_group.amq_dz_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.easy_subnet_ids.*.ids[1],0)}"
  private_ip             = "${var.private_ip["${local.env}-amq-dz"]}"
  ebs_optimized          = "true"
  iam_instance_profile   = "SSMInstanceProfile"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  volume_tags {
    Name = "amq-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "activemq"
    maintainer = "israel@gmail.com"
    zone = "az"
  }

  tags = {
    Name = "amq-${local.env}-${local.zones[1]}"
    application = "ISRAEl"
    business = "personal"
    maintainer = "israel@gmail.com"
    gold_disk_name = "${data.aws_ami.easy_ami.id}"
    os_license = "Red Hat Enterprise Linux"
    zone = "dz"
    purpose = "activemq"
    "cpm backup" = "${local.cpm_backup["${local.env}"]}"
    "schedule" = "moved-${local.env}-office-hours"
  }
}

resource "aws_instance" "fuse_dz_instance" {
  count                  = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  ami                    = "${local.env == "dev" ? local.latest_ami_id : local.ami_id_dev_env }"
  instance_type          = "${local.instance_types[0]}"
  availability_zone      = "${local.avail_zones[0]}"
  tenancy                = "dedicated"
  key_name               = "${local.env}-dz-ec2"
  monitoring             = "true"
  vpc_security_group_ids = ["${aws_security_group.default_group.id}", "${aws_security_group.jboss_dz_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.easy_subnet_ids.*.ids[1],0)}"
  private_ip             = "${var.private_ip["${local.env}-jboss-dz"]}"
  ebs_optimized          = "true"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  volume_tags {
    Name = "fuse-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "fuse"
    maintainer = "israel@gmail.com"
    zone = "dz"
  }

  tags = {
    Name = "fuse-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    maintainer = "israel@gmail.com"
    gold_disk_name = "${data.aws_ami.easy_ami.id}"
    os_license = "Red Hat Enterprise Linux"
    zone = "dz"
    purpose = "fuse"
    "cpm backup" = "${local.cpm_backup["${local.env}"]}"
    "schedule" = "moved-${local.env}-office-hours"
  }
}

resource "aws_instance" "rhpam_dz_instance" {
  count                  = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  ami                    = "${local.env == "dev" ? local.latest_ami_id : local.ami_id_dev_env }"
  instance_type          = "${local.instance_types[0]}"
  availability_zone      = "${local.avail_zones[0]}"
  tenancy                = "dedicated"
  key_name               = "${local.env}-dz-ec2"
  monitoring             = "true"
  vpc_security_group_ids = ["${aws_security_group.default_group.id}", "${aws_security_group.rhpam_dz_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.easy_subnet_ids.*.ids[1],0)}"
  private_ip             = "${var.private_ip["${local.env}-rhpam-dz"]}"
  ebs_optimized          = "true"
  iam_instance_profile   = "SSMInstanceProfile"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  volume_tags {
    Name = "rhpam-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "rhpam"
    maintainer = "israel@gmail.com"
    zone = "dz"
  }

  tags = {
    Name = "rhpam-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    maintainer = "israel@gmail.com"
    gold_disk_name = "${data.aws_ami.easy_ami.id}"
    purchase_type = "On-Demand"
    os_license = "Red Hat Enterprise Linux"
    zone = "dz"
    purpose = "rhpam"
    "schedule" = "moved-${local.env}-office-hours"
  }
}

resource "aws_instance" "nifi_dz_instance" {
  count                  = "${terraform.workspace == "dev"||terraform.workspace == "impl"||terraform.workspace == "devp"||terraform.workspace == "implp" ? 1 : 0}"
  ami                    = "${local.env == "dev" ? local.latest_ami_id : local.ami_id_dev_env }"
  instance_type          = "${local.instance_types[0]}"
  availability_zone      = "${local.avail_zones[0]}"
  tenancy                = "dedicated"
  key_name               = "${local.env}-dz-ec2"
  monitoring             = "true"
  vpc_security_group_ids = ["${aws_security_group.default_group.id}", "${aws_security_group.nifi_dz_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.easy_subnet_ids.*.ids[1],0)}"
  private_ip             = "${var.private_ip["${local.env}-nifi-dz"]}"
  ebs_optimized          = "true"
  iam_instance_profile   = "israel-nifi-${local.env}-data-role"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = "true"
  }

  volume_tags {
    Name = "nifi-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    purpose = "nfi"
    maintainer = "israel@gmail.com"
    zone = "dz"
  }

  tags = {
    Name = "nifi-${local.env}-${local.zones[1]}"
    application = "ISRAEL"
    business = "personal"
    stack = "${local.env}"
    maintainer = "israel@gmail.com"
    gold_disk_name = "${data.aws_ami.easy_ami.id}"
    purchase_type = "On-Demand"
    os_license = "Red Hat Enterprise Linux"
    zone = "dz"
    purpose = "nifi"
    "cpm backup" = "${local.cpm_backup["${local.env}"]}"
    "schedule" = "moved-${local.env}-office-hours"
  }
