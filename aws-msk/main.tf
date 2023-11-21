provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "msk-security-group" {
  name        = "msk-security-group"
  description = "msk security group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "zookeeper port"
    from_port        = 2181
    to_port          = 2181
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "kafka port"
    from_port        = 9092
    to_port          = 9092
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "msk-security-group"
  }
}

module "msk-kafka-cluster" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"

  name                   = var.environment_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = 3
  enhanced_monitoring    = "PER_TOPIC_PER_PARTITION"

  broker_node_client_subnets = var.subnets
  broker_node_storage_info = {
    ebs_storage_info = { volume_size = 100 }
  }
  broker_node_instance_type   = var.broker_type
  broker_node_security_groups = [aws_security_group.msk-security-group.id]

  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  encryption_in_transit_in_cluster = false
  configuration_name        = "example-configuration"
  configuration_description = "Example configuration"
  configuration_server_properties = {
    "auto.create.topics.enable" = true
    "delete.topic.enable"       = true
  }
  client_authentication = {
    sasl = {
      iam = "true"
      scram = "false"
    }
    unauthenticated = "true"
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}