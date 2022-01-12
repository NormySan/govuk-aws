/**
* ## Module: govuk-repo-mirror
*
* Configures a user and role to allow the govuk-repo-mirror Concourse pipeline
* to push to AWS CodeCommit (the user is used by the Jenkins
* Deploy_App job and the role is used by the Concourse mirroring job)
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

variable "aws_environment" {
  type        = "string"
  description = "AWS Environment"
}

terraform {
  backend          "s3"             {}
  required_version = "= 0.11.14"
}

provider "aws" {
  region  = "${var.aws_region}"
  version = "2.46.0"
}

resource "aws_iam_user" "govuk_codecommit_user" {
  name = "govuk-${var.aws_environment}-govuk-code-commit-user"
}

resource "aws_iam_user_policy_attachment" "govuk_codecommit_user_policy_attachment" {
  user       = "${aws_iam_user.govuk_codecommit_user.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
}
