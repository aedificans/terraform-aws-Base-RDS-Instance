module "this" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"
  # Naming
  db_name    = var.instances.db_name
  identifier = local.naming.resource
  # Instance
  allow_major_version_upgrade = var.instances.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.instances.auto_minor_version_upgrade
  ca_cert_identifier          = var.instances.ca_cert_identifier
  character_set_name          = var.instances.character_set_name
  create_db_instance          = var.instances.create_instance
  db_instance_tags            = var.instances.instance_tags
  deletion_protection         = var.instances.deletion_protection
  engine                      = var.instances.engine
  engine_version              = var.instances.engine_version
  instance_class              = var.instances.instance_class
  license_model               = var.instances.license_model
  maintenance_window          = var.instances.maintenance_window
  major_engine_version        = var.instances.major_engine_version
  replica_mode                = var.instances.replica_mode
  timeouts                    = var.instances.timeouts
  timezone                    = var.instances.timezone
  # Storage
  allocated_storage     = var.storage.allocated_storage
  max_allocated_storage = var.storage.max_allocated_storage
  iops                  = var.storage.iops
  kms_key_id            = var.storage.kms_key_id
  storage_encrypted     = var.storage.storage_encrypted
  storage_type          = var.storage.storage_type
  # Security & Authentication
  domain                              = var.credentials.domain
  domain_iam_role_name                = var.credentials.domain_iam_role_name
  iam_database_authentication_enabled = var.credentials.iam_database_authentication_enabled
  manage_master_user_password         = var.credentials.password == null
  username                            = coalesce(var.credentials.username, replace("${local.naming.resource}_admin", "-", "_"))
  password                            = var.credentials.password
  # Networking
  availability_zone               = var.networking.availability_zone
  multi_az                        = var.networking.multi_az
  port                            = var.networking.port
  publicly_accessible             = var.networking.publicly_accessible
  subnet_ids                      = var.networking.subnet_ids
  create_db_subnet_group          = var.networking.create_db_subnet_group
  db_subnet_group_description     = var.networking.db_subnet_group_description
  db_subnet_group_name            = var.networking.db_subnet_group_name
  db_subnet_group_use_name_prefix = var.networking.db_subnet_group_use_name_prefix
  vpc_security_group_ids          = [aws_security_group.this.id]
  db_subnet_group_tags            = var.networking.db_subnet_group_tags
  # Monitoring
  create_monitoring_role = var.monitoring.create_role
  monitoring_interval    = var.monitoring.interval
  # monitoring_role_arn                   = coalesce(var.monitoring_role_arn, data.aws_iam_role.this.arn)
  monitoring_role_description = var.monitoring.role_description
  # monitoring_role_name                  = coalesce(var.monitoring.role_name, data.aws_iam_role.monitoring_role.name)
  monitoring_role_name                  = var.monitoring.role_name
  performance_insights_enabled          = var.monitoring.performance_insights_enabled
  performance_insights_kms_key_id       = var.monitoring.performance_insights_kms_key_id
  performance_insights_retention_period = var.monitoring.performance_insights_retention_period
  # Backups & Maintenance
  backup_retention_period          = var.backups.backup_retention_period
  backup_window                    = var.backups.backup_window
  copy_tags_to_snapshot            = var.backups.copy_tags_to_snapshot
  delete_automated_backups         = var.backups.delete_automated_backups
  final_snapshot_identifier_prefix = var.backups.final_snapshot_identifier_prefix
  replicate_source_db              = var.backups.replicate_source_db
  restore_to_point_in_time         = var.backups.restore_to_point_in_time
  s3_import                        = var.backups.s3_import
  skip_final_snapshot              = var.backups.skip_final_snapshot
  snapshot_identifier              = var.backups.snapshot_identifier
  # CloudWatch
  cloudwatch_log_group_kms_key_id        = var.cloudwatch.log_group_kms_key_id
  cloudwatch_log_group_retention_in_days = var.cloudwatch.log_group_retention_in_days
  create_cloudwatch_log_group            = var.cloudwatch.create_log_group
  enabled_cloudwatch_logs_exports        = var.cloudwatch.enabled_logs_exports
  # DB Option Group
  create_db_option_group       = var.options.create_group
  db_option_group_tags         = var.options.group_tags
  option_group_description     = var.options.group_description
  option_group_name            = var.options.group_name
  option_group_timeouts        = var.options.group_timeouts
  option_group_use_name_prefix = var.options.group_use_name_prefix
  options                      = var.options
  # DB Parameter Group
  create_db_parameter_group       = var.parameters.create_group
  db_parameter_group_tags         = var.parameters.group_tags
  family                          = var.parameters.family
  parameter_group_description     = var.parameters.group_description
  parameter_group_name            = var.parameters.group_name
  parameter_group_use_name_prefix = var.parameters.group_use_name_prefix
  parameters                      = var.parameters.parameters
  # Tagging

  tags = merge(
    local.tags,
    tomap({ Name = "${local.naming.display} DB" })
  )
}
