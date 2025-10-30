## Stears DevOps 


## Instruction
Design a secure scalable microservice infrastructure using AWS

## Technologies Used
- Terraform (Iac) to provision the infrastructure
- Core resources: RDS for PostgreSQL, ElasticeCache for Redis, and Kafka for message broker, VPC, ECS Fargate

## Quick Note
- cd into infra folder then run `chmod +x generate_tfvars.sh`, then run the script to create terraform.tfvars file

## Requirements
-   Inside infra, create a variable file terraform.tfvars with below sample data
```
secret_key            = "<AWS_SECRET_ACCESS_KEY>"
access_key            = "<AWS_ACCESS_KEY>"
region                = "<AWS_REGION>"
vpc_name              = "my-demo"
master_username       = "mydemo"
master_password       = "mydemo123!"
database_name         = "mydemo123"
mq_username           = "mydemo123mydemo123"
mq_password           = "myvpc123"
proxy_name            = "my-demo"
cluster_identifier    = "my-demo"
cluster_id            = "my-demo"
rds_proxy_secret_name = "my-demo"
host_instance_type    = "kafka.m5.large"
engine_version        = "3.6.0"
broker_name           = "my-demo-broker"
environment           = "dev"
broker_nodes          = 2
```
## Terraform command
- To Provision the instance using terraform command afer changing directory to each folder infra
```
terraform init
terraform plan -out=strears.tfplan # To dry-run before apply the changes
terraform apply "strears.tfplan" # An instruction will be given to enter y for yes
terraform apply "strears.tfplan" -auto-approve # This command is use to provision without typing the yes/y key word
```
## Troubleshooting
- Common fixes:
  - Re-run `terraform init -upgrade`
  - Refresh state: `terraform refresh`
  - Validate syntax: `terraform validate`
  - Format files: `terraform fmt -recursive`

## Contact info
- You can reach me via email for more clarification <adekayor@gmail.com>