# RDS Instance

This module provisions a RDS Instance

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | terraform-aws-modules/rds/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_group_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| <a name="input_backups"></a> [backups](#input\_backups) | An object for passing in all backup configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    backup_retention_period          = optional(number, 15)<br>    backup_window                    = optional(string, "03:00-06:00")<br>    copy_tags_to_snapshot            = optional(bool, true)<br>    delete_automated_backups         = optional(bool, true)<br>    final_snapshot_identifier_prefix = optional(string, "final")<br>    replicate_source_db              = optional(string, null)<br>    restore_to_point_in_time         = optional(map(string), null)<br>    s3_import                        = optional(map(string), null)<br>    skip_final_snapshot              = optional(bool, false)<br>    snapshot_identifier              = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_cloudwatch"></a> [cloudwatch](#input\_cloudwatch) | An object for passing in all CloudWatch options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    create_log_group            = optional(bool, false)<br>    enabled_logs_exports        = optional(list(string), [])<br>    log_group_kms_key_id        = optional(string, null)<br>    log_group_retention_in_days = optional(number, 7)<br>  })</pre> | `{}` | no |
| <a name="input_credentials"></a> [credentials](#input\_credentials) | An object for passing in all access and credentials options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    create_random_password              = optional(bool, true)<br>    secret_recovery_window_in_days      = optional(number, 14)<br>    domain                              = optional(string, null)<br>    domain_iam_role_name                = optional(string, null)<br>    iam_database_authentication_enabled = optional(bool, false)<br>    password                            = optional(string, null)<br>    random_password_length              = optional(number, 24)<br>    username                            = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A naming object for the environment to provide both the environment's name and abbrevation for tagging and reporting purposes | <pre>object({<br>    name         = string<br>    abbreviation = string<br>  })</pre> | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | An object for passing in all instance configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    allow_major_version_upgrade = optional(bool, false)<br>    auto_minor_version_upgrade  = optional(bool, true)<br>    ca_cert_identifier          = optional(string, null)<br>    character_set_name          = optional(string, null)<br>    create_instance             = optional(bool, true)<br>    db_name                     = optional(string, null)<br>    deletion_protection         = optional(bool, true)<br>    engine                      = optional(string, "sqlserver-web")<br>    engine_version              = optional(string, "14.00.3356.20.v1")<br>    identifier                  = string<br>    instance_class              = optional(string, "db.r5.large")<br>    instance_tags               = optional(map(string), {})<br>    license_model               = optional(string, "license-included")<br>    maintenance_window          = optional(string, "Mon:00:00-Mon:03:00")<br>    major_engine_version        = optional(string, "14.00")<br>    replica_mode                = optional(string, null)<br>    timeouts                    = optional(map(string), {})<br>    timezone                    = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | An object for passing in all monitoring configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    create_role                           = optional(bool, false)<br>    interval                              = optional(number, 60)<br>    performance_insights_enabled          = optional(bool, true)<br>    performance_insights_kms_key_id       = optional(string, null)<br>    performance_insights_retention_period = optional(number, 7)<br>    role_arn                              = optional(string, null)<br>    role_name                             = optional(string, "rds-monitoring-role")<br>    role_description                      = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_naming"></a> [naming](#input\_naming) | A naming object to provide the display name of the service from the service catalog, and optionally also a resource name | <pre>object({<br>    display  = string<br>    resource = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_networking"></a> [networking](#input\_networking) | An object for passing in all networking configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    availability_zone               = optional(string, null)<br>    create_db_subnet_group          = optional(bool, true)<br>    db_subnet_group_description     = optional(string, null)<br>    db_subnet_group_name            = optional(string, null)<br>    db_subnet_group_tags            = optional(map(string), {})<br>    db_subnet_group_use_name_prefix = optional(bool, false)<br>    egress_cidr_blocks = optional(map(object({<br>      description = optional(string, "Managed by Terraform")<br>      port        = optional(number, null)<br>      protocol    = optional(string, "tcp")<br>      cidr_blocks = list(string)<br>    })), {})<br>    egress_security_group_ids = optional(map(object({<br>      description       = optional(string, "Managed by Terraform")<br>      port              = optional(number, null)<br>      protocol          = optional(string, "tcp")<br>      security_group_id = string<br>    })), {})<br>    ingress_cidr_blocks = optional(map(object({<br>      description = optional(string, "Managed by Terraform")<br>      port        = optional(number, null)<br>      protocol    = optional(string, "tcp")<br>      cidr_blocks = list(string)<br>    })), {})<br>    ingress_security_group_ids = optional(map(object({<br>      description       = optional(string, "Managed by Terraform")<br>      port              = optional(number, null)<br>      protocol          = optional(string, "tcp")<br>      security_group_id = string<br>    })), {})<br>    multi_az               = optional(bool, false)<br>    port                   = optional(number, 1433)<br>    publicly_accessible    = optional(bool, false)<br>    subnet_ids             = list(string)<br>    vpc_id                 = string<br>    vpc_security_group_ids = optional(list(string), [])<br>  })</pre> | n/a | yes |
| <a name="input_options"></a> [options](#input\_options) | An object for passing in all DB Option group configurations.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    create_group          = optional(bool, false)<br>    group_description     = optional(string, null)<br>    group_name            = optional(string, null)<br>    group_tags            = optional(map(string), {})<br>    group_timeouts        = optional(map(string), {})<br>    group_use_name_prefix = optional(bool, true)<br>    options               = optional(any, [])<br>  })</pre> | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | An object for passing in all DB Parameter group configurations.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    create_group          = optional(bool, false)<br>    family                = optional(string, "sqlserver-web-14.0")<br>    group_description     = optional(string, null)<br>    group_name            = optional(string, null)<br>    group_tags            = optional(map(string), {})<br>    group_timeouts        = optional(map(string), {})<br>    group_use_name_prefix = optional(bool, true)<br>    parameters            = optional(list(map(string)), [])<br>  })</pre> | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | An object for passing in all storage configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest) | <pre>object({<br>    allocated_storage     = optional(number, 50)<br>    storage_type          = optional(string, "gp2")<br>    storage_encrypted     = optional(bool, true)<br>    kms_key_id            = optional(string, null)<br>    max_allocated_storage = optional(number, 2000)<br>    iops                  = optional(number, 0)<br>  })</pre> | n/a | yes |
| <a name="input_tagging"></a> [tagging](#input\_tagging) | A collection of tags as key-value pairs to be applied to all applicable provisioned resources | <pre>object({<br>    additional_tags = optional(map(any), {})<br>    network         = string<br>    organization    = string<br>    owner           = string<br>    service_name    = optional(string, null)<br>    service_pattern = string<br>    tag_key_prefix  = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#output\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_db_instance_ca_cert_identifier"></a> [db\_instance\_ca\_cert\_identifier](#output\_db\_instance\_ca\_cert\_identifier) | Specifies the identifier of the CA certificate for the DB instance |
| <a name="output_db_instance_credentials_secret_arn"></a> [db\_instance\_credentials\_secret\_arn](#output\_db\_instance\_credentials\_secret\_arn) | The ARN of the secret created to store the RDS Admin credentials |
| <a name="output_db_instance_domain"></a> [db\_instance\_domain](#output\_db\_instance\_domain) | The ID of the Directory Service Active Directory domain the instance is joined to |
| <a name="output_db_instance_domain_iam_role_name"></a> [db\_instance\_domain\_iam\_role\_name](#output\_db\_instance\_domain\_iam\_role\_name) | The name of the IAM role to be used when making API calls to the Directory Service. |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_db_instance_hosted_zone_id"></a> [db\_instance\_hosted\_zone\_id](#output\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | The database name |
| <a name="output_db_instance_port"></a> [db\_instance\_port](#output\_db\_instance\_port) | The database port |
| <a name="output_db_instance_resource_id"></a> [db\_instance\_resource\_id](#output\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_db_instance_status"></a> [db\_instance\_status](#output\_db\_instance\_status) | The RDS instance status |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | The master username for the database |
| <a name="output_db_option_group_arn"></a> [db\_option\_group\_arn](#output\_db\_option\_group\_arn) | The ARN of the db option group |
| <a name="output_db_option_group_id"></a> [db\_option\_group\_id](#output\_db\_option\_group\_id) | The db option group id |
| <a name="output_db_parameter_group_arn"></a> [db\_parameter\_group\_arn](#output\_db\_parameter\_group\_arn) | The ARN of the db parameter group |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | The db parameter group id |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the monitoring role |
| <a name="output_enhanced_monitoring_iam_role_name"></a> [enhanced\_monitoring\_iam\_role\_name](#output\_enhanced\_monitoring\_iam\_role\_name) | The name of the monitoring role |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group created and assigned to the RDS DB instance |
<!-- END_TF_DOCS -->
