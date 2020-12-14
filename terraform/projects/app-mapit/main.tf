/**
* ## Project: app-mapit
*
* Mapit node
*/
variable "aws_environment" {
  type        = "string"
  description = "AWS environment"
}

variable "aws_region" {
  type        = "string"
  description = "AWS region"
  default     = "eu-west-1"
}

variable "stackname" {
  type        = "string"
  description = "Stackname"
}

variable "ebs_encrypted" {
  type        = "string"
  description = "Whether or not the EBS volume is encrypted"
}

variable "instance_ami_filter_name" {
  type        = "string"
  description = "Name to use to find AMI images"
  default     = ""
}

variable "mapit_1_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 1 and EBS volume"
}

variable "mapit_2_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 2 and EBS volume"
}

variable "mapit_3_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 3 and EBS volume"
}

variable "mapit_4_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 4 and EBS volume"
}

variable "mapit_5_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 5 and EBS volume"
}

variable "mapit_6_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 6 and EBS volume"
}

variable "mapit_7_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 7 and EBS volume"
}

variable "mapit_8_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 8 and EBS volume"
}

variable "mapit_9_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 9 and EBS volume"
}

variable "mapit_10_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 10 and EBS volume"
}

variable "mapit_11_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 11 and EBS volume"
}

variable "mapit_12_subnet" {
  type        = "string"
  description = "Name of the subnet to place the mapit instance 12 and EBS volume"
}

variable "elb_internal_certname" {
  type        = "string"
  description = "The ACM cert domain name to find the ARN of"
}

variable "instance_type" {
  type        = "string"
  description = "Instance type used for EC2 resources"
  default     = "t2.medium"
}

variable "internal_zone_name" {
  type        = "string"
  description = "The name of the Route53 zone that contains internal records"
}

variable "internal_domain_name" {
  type        = "string"
  description = "The domain name of the internal DNS records, it could be different from the zone name"
}

variable "lc_create_ebs_volume" {
  type        = "string"
  description = "Creates a launch configuration which will add an additional ebs volume to the instance if this value is set to 1"
}

variable "ebs_device_volume_size" {
  type        = "string"
  description = "Size of additional ebs volume in GB"
  default     = "20"
}

variable "ebs_device_name" {
  type        = "string"
  description = "Name of the block device to mount on the instance, e.g. xvdf"
}

# Resources
# --------------------------------------------------------------
terraform {
  backend          "s3"             {}
  required_version = "= 0.11.14"
}

data "aws_route53_zone" "internal" {
  name         = "${var.internal_zone_name}"
  private_zone = true
}

provider "aws" {
  region  = "${var.aws_region}"
  version = "2.46.0"
}

data "aws_acm_certificate" "elb_internal_cert" {
  domain   = "${var.elb_internal_certname}"
  statuses = ["ISSUED"]
}

resource "aws_elb" "mapit_elb" {
  name            = "${var.stackname}-mapit-internal"
  subnets         = ["${data.terraform_remote_state.infra_networking.private_subnet_ids}"]
  security_groups = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_elb_id}"]
  internal        = "true"

  access_logs {
    bucket        = "${data.terraform_remote_state.infra_monitoring.aws_logging_bucket_id}"
    bucket_prefix = "elb/${var.stackname}-mapit-internal-elb"
    interval      = 60
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"

    ssl_certificate_id = "${data.aws_acm_certificate.elb_internal_cert.arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3

    target   = "HTTP:80/postcode/W54XA"
    interval = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = "${map("Name", "${var.stackname}-mapit-internal", "Project", var.stackname, "aws_migration", "mapit", "aws_environment", var.aws_environment)}"
}

resource "aws_route53_record" "mapit_service_record" {
  zone_id = "${data.aws_route53_zone.internal.zone_id}"
  name    = "mapit.${var.internal_domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.mapit_elb.dns_name}"
    zone_id                = "${aws_elb.mapit_elb.zone_id}"
    evaluate_target_health = true
  }
}

module "mapit-1" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-1"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-1")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_1_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-1" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_1_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-1"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-2" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-2"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-2")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_2_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-2" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_2_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-2"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-3" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-3"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-3")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_3_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-3" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_3_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-3"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-4" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-4"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-4")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_4_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-4" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_4_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-4"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-5" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-5"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-5")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_5_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-5" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_5_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-5"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-6" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-6"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-6")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_6_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-6" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_6_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-6"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-7" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-7"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-7")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_7_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-7" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_7_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-7"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-8" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-8"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-8")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_8_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-8" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_8_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-8"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-9" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-9"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-9")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_9_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-9" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_9_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-9"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-10" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-10"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-10")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_10_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-10" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_10_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-10"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-11" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-11"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-11")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_11_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-11" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_11_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-11"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

module "mapit-12" {
  lc_create_ebs_volume          = "${var.lc_create_ebs_volume}"
  source                        = "../../modules/aws/node_group"
  name                          = "${var.stackname}-mapit-12"
  default_tags                  = "${map("Project", var.stackname, "aws_stackname", var.stackname, "aws_environment", var.aws_environment, "aws_migration", "mapit", "aws_hostname", "mapit-12")}"
  instance_subnet_ids           = "${matchkeys(values(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), keys(data.terraform_remote_state.infra_networking.private_subnet_names_ids_map), list(var.mapit_12_subnet))}"
  instance_security_group_ids   = ["${data.terraform_remote_state.infra_security_groups.sg_mapit_id}", "${data.terraform_remote_state.infra_security_groups.sg_management_id}"]
  instance_type                 = "${var.instance_type}"
  instance_additional_user_data = "${join("\n", null_resource.user_data.*.triggers.snippet)}"
  instance_elb_ids_length       = "1"
  instance_elb_ids              = ["${aws_elb.mapit_elb.id}"]
  instance_ami_filter_name      = "${var.instance_ami_filter_name}"
  asg_notification_topic_arn    = "${data.terraform_remote_state.infra_monitoring.sns_topic_autoscaling_group_events_arn}"
  root_block_device_volume_size = "20"
  ebs_device_volume_size        = "${var.ebs_device_volume_size}"
  ebs_encrypted                 = "${var.ebs_encrypted}"
  ebs_device_name               = "${var.ebs_device_name}"
}

resource "aws_ebs_volume" "mapit-12" {
  availability_zone = "${lookup(data.terraform_remote_state.infra_networking.private_subnet_names_azs_map, var.mapit_12_subnet)}"
  encrypted         = "${var.ebs_encrypted}"
  size              = 20
  type              = "gp2"

  tags {
    Name            = "${var.stackname}-mapit"
    Project         = "${var.stackname}"
    Device          = "xvdf"
    aws_hostname    = "mapit-12"
    aws_migration   = "mapit"
    aws_stackname   = "${var.stackname}"
    aws_environment = "${var.aws_environment}"
  }
}

resource "aws_iam_policy" "mapit_iam_policy" {
  name   = "${var.stackname}-mapit-additional"
  path   = "/"
  policy = "${file("${path.module}/additional_policy.json")}"
}

resource "aws_iam_role_policy_attachment" "mapit_1_iam_role_policy_attachment" {
  role       = "${module.mapit-1.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_2_iam_role_policy_attachment" {
  role       = "${module.mapit-2.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_3_iam_role_policy_attachment" {
  role       = "${module.mapit-3.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_4_iam_role_policy_attachment" {
  role       = "${module.mapit-4.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_5_iam_role_policy_attachment" {
  role       = "${module.mapit-5.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_6_iam_role_policy_attachment" {
  role       = "${module.mapit-6.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_7_iam_role_policy_attachment" {
  role       = "${module.mapit-7.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_8_iam_role_policy_attachment" {
  role       = "${module.mapit-8.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_9_iam_role_policy_attachment" {
  role       = "${module.mapit-9.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_10_iam_role_policy_attachment" {
  role       = "${module.mapit-10.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_11_iam_role_policy_attachment" {
  role       = "${module.mapit-11.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "mapit_12_iam_role_policy_attachment" {
  role       = "${module.mapit-12.instance_iam_role_name}"
  policy_arn = "${aws_iam_policy.mapit_iam_policy.arn}"
}

module "alarms-elb-mapit-internal" {
  source                         = "../../modules/aws/alarms/elb"
  name_prefix                    = "${var.stackname}-mapit-internal"
  alarm_actions                  = ["${data.terraform_remote_state.infra_monitoring.sns_topic_cloudwatch_alarms_arn}"]
  elb_name                       = "${aws_elb.mapit_elb.name}"
  httpcode_backend_4xx_threshold = "0"
  httpcode_backend_5xx_threshold = "100"
  httpcode_elb_4xx_threshold     = "0"
  httpcode_elb_5xx_threshold     = "100"
  surgequeuelength_threshold     = "0"
  healthyhostcount_threshold     = "0"
}

# Outputs
# --------------------------------------------------------------

output "mapit_service_dns_name" {
  value       = "${aws_route53_record.mapit_service_record.fqdn}"
  description = "DNS name to access the mapit internal service"
}
