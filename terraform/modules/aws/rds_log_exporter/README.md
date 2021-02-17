## Module: aws/rds\_log\_exporter

This module exports a RDS instance logs to S3 via Lambda function  
and scheduled event.

The Lambda function filename needs to be provided. The module creates  
a scheduled Cloudwatch event to trigger the Lambda function.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) |
| [aws_cloudwatch_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) |
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) |
| [aws_lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lambda\_event\_schedule\_expression | Cloudwatch event schedule expression that triggers the Lambda function | `string` | `"rate(5 minutes)"` | no |
| lambda\_filename | The path to the Lambda function's deployment package within the local filesystem | `string` | n/a | yes |
| lambda\_log\_retention\_in\_days | Specifies the number of days you want to retain log events in the Lambda function log group | `string` | `"1"` | no |
| lambda\_role\_arn | The ARN of the IAM role attached to the Lambda Function | `string` | n/a | yes |
| rds\_instance\_id | The RDS instance ID | `string` | n/a | yes |
| rds\_log\_name\_prefix | Download RDS logs that match this prefix | `string` | `"error/"` | no |
| s3\_logging\_bucket\_name | The name of the S3 bucket where we store the logs | `string` | n/a | yes |
| s3\_logging\_bucket\_prefix | The extra prefix to be added in front of the instance name in the S3 logging bucket. RDS logs will be store in s3\_bucket/prefix/instance\_name/log\_name | `string` | `"rds"` | no |

## Outputs

No output.
