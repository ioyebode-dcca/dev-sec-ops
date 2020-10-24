#----output latest AMI
output "ami" {
  value = "${data.aws_ami.easy_ami.id}"
}

#---output IP Address

output "ip_fuse_az" {
  value = "${aws_instance.fuse_az_instance.*.private_ip}"
}

output "ip_amq_dz" {
  value = "${aws_instance.amq_dz_instance.*.private_ip}"
}

output "ip_fuse_dz" {
  value = "${aws_instance.fuse_dz_instance.*.private_ip}"
}

output "ip_rhpam_dz" {
  value = "${aws_instance.rhpam_dz_instance.*.private_ip}"
}

output "ip_nifi_dz" {
  value = "${aws_instance.nifi_dz_instance.*.private_ip}"
}
