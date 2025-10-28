# variable "broker_name" {
#   description = "The name of the RabbitMQ broker"
#   type        = string
# }

# variable "engine_version" {
#   description = "The version of the RabbitMQ engine"
#   type        = string
# }

# variable "host_instance_type" {
#   description = "The instance type for the RabbitMQ host"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs"
#   type        = list(string)
# }

# variable "username" {
#   description = "The username for the RabbitMQ broker"
#   type        = string
# }

# variable "password" {
#   description = "The password for the RabbitMQ broker"
#   type        = string
# }

# variable "vpc_cidr" {
#   type = string
# }

# variable "vpc_id" {
#   type = string
# }

variable "broker_name" {
  description = "Name of the MSK Kafka cluster"
  type        = string
}

variable "engine_version" {
  description = "Kafka version (e.g., 3.7.0)"
  type        = string
  default     = "3.7.0"
}

variable "host_instance_type" {
  description = "MSK broker instance type"
  type        = string
  default     = "kafka.m5.large"
}

variable "broker_nodes" {
  description = "Number of MSK broker nodes"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "List of subnet IDs for MSK brokers"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the MSK cluster will be deployed"
  type        = string
}

variable "ecs_tasks_sg_id" {
  description = "Security group ID of ECS Fargate tasks allowed to access MSK"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}
