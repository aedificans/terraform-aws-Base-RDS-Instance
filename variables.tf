#==================#
# Naming & Tagging #
#==================#

variable "environment" {
  description = "A naming object for the environment to provide both the environment's name and abbrevation for tagging and reporting purposes"
  type = object({
    name         = string
    abbreviation = string
  })

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.environment.name))
    error_message = "The environment name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.environment.abbreviation))
    error_message = "The environment abbreviation must be kebab case"
  }
}
variable "naming" {
  description = "A naming object to provide the display name of the service from the service catalog, and optionally also a resource name"
  type = object({
    display  = string
    resource = optional(string, null)
  })

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.naming.display))
    error_message = "The service display name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.naming.resource)) || var.naming.resource == null
    error_message = "If provided, the service resource name must be kebab case"
  }
}
variable "tagging" {
  description = "A collection of tags as key-value pairs to be applied to all applicable provisioned resources"
  type = object({
    additional_tags = optional(map(any), {})
    network         = string
    organization    = string
    owner           = string
    service_pattern = string
    tag_key_prefix  = string
  })
}

#=========================#
# Resource Configurations #
#=========================#

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "backups" {
  description = "An object for passing in all backup configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    backup_retention_period          = optional(number, 15)
    backup_window                    = optional(string, "03:00-06:00")
    copy_tags_to_snapshot            = optional(bool, true)
    delete_automated_backups         = optional(bool, true)
    final_snapshot_identifier_prefix = optional(string, "final")
    replicate_source_db              = optional(string, null)
    restore_to_point_in_time         = optional(map(string), null)
    s3_import                        = optional(map(string), null)
    skip_final_snapshot              = optional(bool, false)
    snapshot_identifier              = optional(string, null)
  })
}

variable "cloudwatch" {
  description = "An object for passing in all CloudWatch options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    create_log_group            = optional(bool, false)
    enabled_logs_exports        = optional(list(string), [])
    log_group_kms_key_id        = optional(string, null)
    log_group_retention_in_days = optional(number, 7)
  })
  default = {}
}

variable "credentials" {
  description = "An object for passing in all access and credentials options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    create_random_password              = optional(bool, true)
    secret_recovery_window_in_days      = optional(number, 14)
    domain                              = optional(string, null)
    domain_iam_role_name                = optional(string, null)
    iam_database_authentication_enabled = optional(bool, false)
    password                            = optional(string, null)
    random_password_length              = optional(number, 24)
    username                            = optional(string, null)
  })
  default = {}
}

variable "instances" {
  description = "An object for passing in all instance configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    allow_major_version_upgrade = optional(bool, false)
    auto_minor_version_upgrade  = optional(bool, true)
    ca_cert_identifier          = optional(string, null)
    character_set_name          = optional(string, null)
    create_instance             = optional(bool, true)
    db_name                     = optional(string, null)
    deletion_protection         = optional(bool, true)
    engine                      = optional(string, "sqlserver-web")
    engine_version              = optional(string, "14.00.3356.20.v1")
    identifier                  = string
    instance_class              = optional(string, "db.r5.large")
    instance_tags               = optional(map(string), {})
    license_model               = optional(string, "license-included")
    maintenance_window          = optional(string, "Mon:00:00-Mon:03:00")
    major_engine_version        = optional(string, "14.00")
    replica_mode                = optional(string, null)
    timeouts                    = optional(map(string), {})
    timezone                    = optional(string, null)
  })
}

variable "monitoring" {
  description = "An object for passing in all monitoring configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    create_role                           = optional(bool, false)
    interval                              = optional(number, 60)
    performance_insights_enabled          = optional(bool, true)
    performance_insights_kms_key_id       = optional(string, null)
    performance_insights_retention_period = optional(number, 7)
    role_arn                              = optional(string, null)
    role_name                             = optional(string, "rds-monitoring-role")
    role_description                      = optional(string, null)
  })
}

variable "networking" {
  description = "An object for passing in all networking configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    availability_zone               = optional(string, null)
    create_db_subnet_group          = optional(bool, true)
    db_subnet_group_description     = optional(string, null)
    db_subnet_group_name            = optional(string, null)
    db_subnet_group_tags            = optional(map(string), {})
    db_subnet_group_use_name_prefix = optional(bool, false)
    egress_cidr_blocks = optional(map(object({
      description = optional(string, "Managed by Terraform")
      port        = optional(number, null)
      protocol    = optional(string, "tcp")
      cidr_blocks = list(string)
    })), {})
    egress_security_group_ids = optional(map(object({
      description       = optional(string, "Managed by Terraform")
      port              = optional(number, null)
      protocol          = optional(string, "tcp")
      security_group_id = string
    })), {})
    ingress_cidr_blocks = optional(map(object({
      description = optional(string, "Managed by Terraform")
      port        = optional(number, null)
      protocol    = optional(string, "tcp")
      cidr_blocks = list(string)
    })), {})
    ingress_security_group_ids = optional(map(object({
      description       = optional(string, "Managed by Terraform")
      port              = optional(number, null)
      protocol          = optional(string, "tcp")
      security_group_id = string
    })), {})
    multi_az               = optional(bool, false)
    port                   = optional(number, 1433)
    publicly_accessible    = optional(bool, false)
    subnet_ids             = list(string)
    vpc_id                 = string
    vpc_security_group_ids = optional(list(string), [])
  })
}

variable "options" {
  description = "An object for passing in all DB Option group configurations.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    create_group          = optional(bool, false)
    group_description     = optional(string, null)
    group_name            = optional(string, null)
    group_tags            = optional(map(string), {})
    group_timeouts        = optional(map(string), {})
    group_use_name_prefix = optional(bool, true)
    options               = optional(any, [])
  })
}

variable "parameters" {
  description = "An object for passing in all DB Parameter group configurations.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    create_group          = optional(bool, false)
    family                = optional(string, "sqlserver-web-14.0")
    group_description     = optional(string, null)
    group_name            = optional(string, null)
    group_tags            = optional(map(string), {})
    group_timeouts        = optional(map(string), {})
    group_use_name_prefix = optional(bool, true)
    parameters            = optional(list(map(string)), [])
  })
}

variable "storage" {
  description = "An object for passing in all storage configuration options.  For further detail on each, please see the [Terraform documentation](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)"
  type = object({
    allocated_storage     = optional(number, 50)
    storage_type          = optional(string, "gp2")
    storage_encrypted     = optional(bool, true)
    kms_key_id            = optional(string, null)
    max_allocated_storage = optional(number, 2000)
    iops                  = optional(number, 0)
  })
}
