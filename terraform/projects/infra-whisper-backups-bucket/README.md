## Project: whisper-backups-bucket

This creates an s3 bucket for storing whisper backups from Graphite.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 0.11.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 2.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 2.46.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.account_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.content_data_api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.elasticsearch_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.email-alert-api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.graphite_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.integration_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.mongo_api_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.mongo_router_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.mongodb_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_content_data_api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.production_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.publishing-api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.staging_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.transition_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.whisper_backups_access](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.whisper_backups](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.database_backups_cross_account_access](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.account_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.content_data_api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.database_backups_cross_account_access](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticsearch_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.email-alert-api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.graphite_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.integration_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mongo_api_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mongo_router_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mongodb_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_content_data_api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.production_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.publishing-api_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_account_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_elasticsearch_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_email-alert-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_graphite_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_mongo_api_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_mongo_router_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_mongodb_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_publishing-api_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.staging_transition_dbadmin_database_backups_reader](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.transition_dbadmin_database_backups_writer](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.whisper_backups_access](https://registry.terraform.io/providers/hashicorp/aws/2.46.0/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.infra_monitoring](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_environment"></a> [aws\_environment](#input\_aws\_environment) | AWS Environment | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_expiration_time"></a> [expiration\_time](#input\_expiration\_time) | Expiration time in days of S3 Objects | `string` | `"7"` | no |
| <a name="input_remote_state_bucket"></a> [remote\_state\_bucket](#input\_remote\_state\_bucket) | S3 bucket we store our terraform state in | `string` | n/a | yes |
| <a name="input_remote_state_infra_monitoring_key_stack"></a> [remote\_state\_infra\_monitoring\_key\_stack](#input\_remote\_state\_infra\_monitoring\_key\_stack) | Override stackname path to infra\_monitoring remote state | `string` | `""` | no |
| <a name="input_stackname"></a> [stackname](#input\_stackname) | Stackname | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_whisper_backups_bucket_policy_arn"></a> [access\_whisper\_backups\_bucket\_policy\_arn](#output\_access\_whisper\_backups\_bucket\_policy\_arn) | ARN of the access whisper-backups-bucket policy |
| <a name="output_account_dbadmin_write_database_backups_bucket_policy_arn"></a> [account\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_account\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the AccountDBAdmin write database\_backups-bucket policy |
| <a name="output_content_data_api_dbadmin_write_database_backups_bucket_policy_arn"></a> [content\_data\_api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_content\_data\_api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the Content Data API DBAdmin database\_backups bucket writer policy |
| <a name="output_dbadmin_write_database_backups_bucket_policy_arn"></a> [dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the DBAdmin write database\_backups-bucket policy |
| <a name="output_elasticsearch_write_database_backups_bucket_policy_arn"></a> [elasticsearch\_write\_database\_backups\_bucket\_policy\_arn](#output\_elasticsearch\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the elasticsearch write database\_backups-bucket policy |
| <a name="output_email-alert-api_dbadmin_write_database_backups_bucket_policy_arn"></a> [email-alert-api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_email-alert-api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the EmailAlertAPIDBAdmin write database\_backups-bucket policy |
| <a name="output_graphite_write_database_backups_bucket_policy_arn"></a> [graphite\_write\_database\_backups\_bucket\_policy\_arn](#output\_graphite\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the Graphite write database\_backups-bucket policy |
| <a name="output_integration_account_dbadmin_read_database_backups_bucket_policy_arn"></a> [integration\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read AccountDBAdmin database\_backups-bucket policy |
| <a name="output_integration_dbadmin_read_database_backups_bucket_policy_arn"></a> [integration\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read DBAdmin database\_backups-bucket policy |
| <a name="output_integration_elasticsearch_read_database_backups_bucket_policy_arn"></a> [integration\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read elasticsearch database\_backups-bucket policy |
| <a name="output_integration_email-alert-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [integration\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read EmailAlertAPUDBAdmin database\_backups-bucket policy |
| <a name="output_integration_graphite_read_database_backups_bucket_policy_arn"></a> [integration\_graphite\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_graphite\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read Graphite database\_backups-bucket policy |
| <a name="output_integration_mongo_api_read_database_backups_bucket_policy_arn"></a> [integration\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read mongo-api database\_backups-bucket policy |
| <a name="output_integration_mongo_router_read_database_backups_bucket_policy_arn"></a> [integration\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read router\_backend database\_backups-bucket policy |
| <a name="output_integration_mongodb_read_database_backups_bucket_policy_arn"></a> [integration\_mongodb\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_mongodb\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read mongodb database\_backups-bucket policy |
| <a name="output_integration_publishing-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [integration\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read publishing-apiDBAdmin database\_backups-bucket policy |
| <a name="output_integration_transition_dbadmin_read_database_backups_bucket_policy_arn"></a> [integration\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_integration\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the integration read TransitionDBAdmin database\_backups-bucket policy |
| <a name="output_mongo_api_write_database_backups_bucket_policy_arn"></a> [mongo\_api\_write\_database\_backups\_bucket\_policy\_arn](#output\_mongo\_api\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the mongo-api write database\_backups-bucket policy |
| <a name="output_mongo_router_write_database_backups_bucket_policy_arn"></a> [mongo\_router\_write\_database\_backups\_bucket\_policy\_arn](#output\_mongo\_router\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the router\_backend write database\_backups-bucket policy |
| <a name="output_mongodb_write_database_backups_bucket_policy_arn"></a> [mongodb\_write\_database\_backups\_bucket\_policy\_arn](#output\_mongodb\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the mongodb write database\_backups-bucket policy |
| <a name="output_production_account_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read AccountDBAdmin database\_backups-bucket policy |
| <a name="output_production_content_data_api_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_content\_data\_api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_content\_data\_api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production database\_backups bucket reader policy for the Content Data API |
| <a name="output_production_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read DBAdmin database\_backups-bucket policy |
| <a name="output_production_elasticsearch_read_database_backups_bucket_policy_arn"></a> [production\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read elasticsearch database\_backups-bucket policy |
| <a name="output_production_email-alert-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read EmailAlertAPUDBAdmin database\_backups-bucket policy |
| <a name="output_production_graphite_read_database_backups_bucket_policy_arn"></a> [production\_graphite\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_graphite\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read Graphite database\_backups-bucket policy |
| <a name="output_production_mongo_api_read_database_backups_bucket_policy_arn"></a> [production\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read mongo-api database\_backups-bucket policy |
| <a name="output_production_mongo_router_read_database_backups_bucket_policy_arn"></a> [production\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read router\_backend database\_backups-bucket policy |
| <a name="output_production_mongodb_read_database_backups_bucket_policy_arn"></a> [production\_mongodb\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_mongodb\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read mongodb database\_backups-bucket policy |
| <a name="output_production_publishing-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read publishing-apiDBAdmin database\_backups-bucket policy |
| <a name="output_production_transition_dbadmin_read_database_backups_bucket_policy_arn"></a> [production\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_production\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the production read TransitionDBAdmin database\_backups-bucket policy |
| <a name="output_publishing-api_dbadmin_write_database_backups_bucket_policy_arn"></a> [publishing-api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_publishing-api\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the publishing-apiDBAdmin write database\_backups-bucket policy |
| <a name="output_s3_whisper_backups_bucket_name"></a> [s3\_whisper\_backups\_bucket\_name](#output\_s3\_whisper\_backups\_bucket\_name) | The name of the whisper backups bucket |
| <a name="output_staging_account_dbadmin_read_database_backups_bucket_policy_arn"></a> [staging\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_account\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read AccountDBAdmin database\_backups-bucket policy |
| <a name="output_staging_dbadmin_read_database_backups_bucket_policy_arn"></a> [staging\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read DBAdmin database\_backups-bucket policy |
| <a name="output_staging_elasticsearch_read_database_backups_bucket_policy_arn"></a> [staging\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_elasticsearch\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read elasticsearch database\_backups-bucket policy |
| <a name="output_staging_email-alert-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [staging\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_email-alert-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read EmailAlertAPUDBAdmin database\_backups-bucket policy |
| <a name="output_staging_graphite_read_database_backups_bucket_policy_arn"></a> [staging\_graphite\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_graphite\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read Graphite database\_backups-bucket policy |
| <a name="output_staging_mongo_api_read_database_backups_bucket_policy_arn"></a> [staging\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_mongo\_api\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read mongo-api database\_backups-bucket policy |
| <a name="output_staging_mongo_router_read_database_backups_bucket_policy_arn"></a> [staging\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_mongo\_router\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read router\_backend database\_backups-bucket policy |
| <a name="output_staging_mongodb_read_database_backups_bucket_policy_arn"></a> [staging\_mongodb\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_mongodb\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read mongodb database\_backups-bucket policy |
| <a name="output_staging_publishing-api_dbadmin_read_database_backups_bucket_policy_arn"></a> [staging\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_publishing-api\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read publishing-apiDBAdmin database\_backups-bucket policy |
| <a name="output_staging_transition_dbadmin_read_database_backups_bucket_policy_arn"></a> [staging\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn](#output\_staging\_transition\_dbadmin\_read\_database\_backups\_bucket\_policy\_arn) | ARN of the staging read TransitionDBAdmin database\_backups-bucket policy |
| <a name="output_transition_dbadmin_write_database_backups_bucket_policy_arn"></a> [transition\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn](#output\_transition\_dbadmin\_write\_database\_backups\_bucket\_policy\_arn) | ARN of the TransitionDBAdmin write database\_backups-bucket policy |
