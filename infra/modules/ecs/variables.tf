variable "project_name" {
  default = "stears-ecs-cluster"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "container_image" {
  default = "nginx:1.28.0"
}

variable "container_port" {
  default = 80
}

variable "min_capacity" {
  default = 1
}

variable "max_capacity" {
  default = 4
}
variable "desired_capacity" {
  default = 2
}

variable "vpc_id" {
  type = string
}

variable "private_subnet1" {
  type = string
}

variable "private_subnet2" {
  type = string
}

variable "public_subnet1" {
  type = string
}

variable "public_subnet2" {
  type = string
}
variable "environment" {
  type = string
}