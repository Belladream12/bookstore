output "db_instance_endpoint" {
  description = "db instance endpoint"
  value       = module.db.db_instance_endpoint
}

output "database_name" {
  description = "database name"
  value       = module.db.db_instance_name
}


