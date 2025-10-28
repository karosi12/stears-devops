#!/bin/bash

cat <<EOF > terraform.tfvars
cluster_identifier = "$CLUSTER_IDENTIFIER"
master_username = "$MASTER_USERNAME"
master_password = "$MASTER_PASSWORD"
database_name = "$DATABASE_NAME"
proxy_name = "$PROXY_NAME"
cluster_id = "$CLUSTER_ID"
vpc_name = "$VPC_NAME"
rds_proxy_secret_name = "$RDS_PROXY_SECRET_NAME"
access_key = "$AWS_ACCESS_KEY_ID"
secret_key = "$AWS_SECRET_ACCESS_KEY"
region = "$REGION"
mq_username = "$MQ_USERNAME"
mq_password = "$MQ_PASSWORD"
host_instance_type = "$HOST_INSTANCE_TYPE"
engine_version = "$ENGINE_VERSION"
broker_name = "$BROKER_NAME"
environment = "$ENVIRONMENT"
broker_nodes = $BROKER_NODES
EOF
