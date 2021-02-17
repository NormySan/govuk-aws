## Module: aws/cloudwatch\_log\_exporter

This module exports a CloudWatch log group to S3 via Lambda  
function and Kinesis Firehose.

The lambda function filename needs to be provided and the  
module will create a permission to listen to Log events and  
a subscription to the specified log group. This function  
should:
  - decompress the Cloudwatch log
  - format the data, if needed, so the log entry can later be  
parsed by a Logstash filter
  - send the log event to a Kinesis Firehose stream, that will  
be configured to store the events in a S3 bucket

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
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) |
| [aws_cloudwatch_log_subscription_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) |
| [aws_kinesis_firehose_delivery_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) |
| [aws_lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| firehose\_bucket\_arn | The ARN of the Kinesis Firehose stream S3 bucket | `string` | n/a | yes |
| firehose\_bucket\_prefix | The extra prefix to be added in front of the default time format prefix to the Kinesis Firehose stream S3 bucket | `string` | n/a | yes |
| firehose\_role\_arn | The ARN of the Kinesis Firehose stream AWS credentials | `string` | n/a | yes |
| lambda\_filename | The path to the Lambda function's deployment package within the local filesystem | `string` | n/a | yes |
| lambda\_log\_retention\_in\_days | Specifies the number of days you want to retain log events in the Lambda function log group | `string` | `"1"` | no |
| lambda\_role\_arn | The ARN of the IAM role attached to the Lambda Function | `string` | n/a | yes |
| log\_group\_name | The name of the Cloudwatch log group to process | `string` | n/a | yes |

## Outputs

No output.
