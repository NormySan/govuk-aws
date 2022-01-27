/**
* ## Project: whisper-backups-bucket
*
* This creates an s3 bucket for storing whisper backups from Graphite.
*/

variable "aws_region" {
  type        = "string"
  description = "AWS region"
  default     = "eu-west-1"
}

variable "aws_environment" {
  type        = "string"
  description = "AWS Environment"
}

variable "stackname" {
  type        = "string"
  description = "Stackname"
}

variable "remote_state_bucket" {
  type        = "string"
  description = "S3 bucket we store our terraform state in"
}

variable "remote_state_infra_monitoring_key_stack" {
  type        = "string"
  description = "Override stackname path to infra_monitoring remote state "
  default     = ""
}

variable "expiration_time" {
  type        = "string"
  description = "Expiration time in days of S3 Objects"
  default     = "7"
}

terraform {
  backend          "s3"             {}
  required_version = "= 0.11.14"
}

provider "aws" {
  region  = "${var.aws_region}"
  version = "2.46.0"
}

data "terraform_remote_state" "infra_monitoring" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket}"
    key    = "${coalesce(var.remote_state_infra_monitoring_key_stack, var.stackname)}/infra-monitoring.tfstate"
    region = "${var.aws_region}"
  }
}

resource "aws_s3_bucket" "whisper_backups" {
  bucket = "govuk-${var.aws_environment}-whisper-backups"
  region = "${var.aws_region}"

  tags {
    Name            = "govuk-${var.aws_environment}-whisper-backups"
    aws_environment = "${var.aws_environment}"
  }

  logging {
    target_bucket = "${data.terraform_remote_state.infra_monitoring.aws_logging_bucket_id}"
    target_prefix = "s3/govuk-${var.aws_environment}-whisper-backups/"
  }

  lifecycle_rule {
    id = "whole_bucket_lifecycle_rule_integration"

    expiration {
      days = "${var.expiration_time}"
    }
  }
}

resource "aws_iam_policy" "whisper_backups_access" {
  name        = "govuk-${var.aws_environment}-whisper-backups-access-policy"
  policy      = "${data.aws_iam_policy_document.whisper_backups_access.json}"
  description = "Allows read/write access to the whisper_backups bucket"
}

data "aws_iam_policy_document" "whisper_backups_access" {
  statement {
    sid = "ReadListOfBuckets"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
  }

  statement {
    sid = "ReadBucketLists"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.whisper_backups.id}",
    ]
  }

  statement {
    sid = "AccessObjects"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.database_backups.id}",
    ]
  }
}

# Outputs
#--------------------------------------------------------------

output "s3_whisper_backups_bucket_name" {
  value       = "${aws_s3_bucket.whisper_backups.id}"
  description = "The name of the whisper backups bucket"
}

output "access_whisper_backups_bucket_policy_arn" {
  value       = "${aws_iam_policy.whisper_backups_access.arn}"
  description = "ARN of the access whisper-backups-bucket policy"
}
