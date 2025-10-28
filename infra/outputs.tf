output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_reader_endpoint" {
  value = module.rds.rds_reader_endpoint
}

output "rds_db_name" {
  description = "The name of the RDS database"
  value       = module.rds.db_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cache_address" {
  value = module.cache.elasticache_endpoint
}

output "broker_endpoint" {
  value = module.message_broker.msk_bootstrap_brokers_tls
}