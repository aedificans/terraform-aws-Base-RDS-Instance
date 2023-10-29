output "security_group_id" {
  description = "The ID of the Security Group created and assigned to the RDS DB instance"
  value       = aws_security_group.this.id
}

output "enhanced_monitoring_iam_role_name" {
  description = "The name of the monitoring role"
  value       = module.this.enhanced_monitoring_iam_role_name
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the monitoring role"
  value       = module.this.enhanced_monitoring_iam_role_arn
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.this.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.this.db_instance_arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.this.db_instance_availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.this.db_instance_endpoint
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = module.this.db_instance_hosted_zone_id
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.this.db_instance_resource_id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = module.this.db_instance_status
}

output "db_instance_name" {
  description = "The database name"
  value       = module.this.db_instance_name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.this.db_instance_username
  sensitive   = true
}

output "db_instance_credentials_secret_arn" {
  description = "The ARN of the secret created to store the RDS Admin credentials"
  value       = module.this.db_instance_master_user_secret_arn
}

output "db_instance_domain" {
  description = "The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = module.this.db_instance_domain
}

output "db_instance_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service. "
  value       = module.this.db_instance_domain_iam_role_name
}

output "db_instance_port" {
  description = "The database port"
  value       = module.this.db_instance_port
}

output "db_instance_ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  value       = module.this.db_instance_ca_cert_identifier
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.this.db_subnet_group_id
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.this.db_subnet_group_arn
}

output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.this.db_parameter_group_id
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.this.db_parameter_group_arn
}

#=======================#
# DATABASE OPTION GROUP #
#=======================#

output "db_option_group_id" {
  description = "The db option group id"
  value       = module.this.db_option_group_id
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = module.this.db_option_group_arn
}


#============#
# CLOUDWATCH #
#============#

# TODO: Uncomment after upgrade of module to version 4.0+
# output "db_instance_cloudwatch_log_groups" {
#   description = "Map of CloudWatch log groups created and their attributes"
#   value       = module.this.db_instance_cloudwatch_log_groups
# }
