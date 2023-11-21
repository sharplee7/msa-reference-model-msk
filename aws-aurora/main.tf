provider "aws" {
  region = var.aws_region
}

module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = var.environment_name
  engine         = "aurora-mysql"
  engine_version = "5.7"
  instance_class = "db.t3.small"
  instances = {
    one = {}
    2 = {
      instance_class = "db.t3.small"
    }
  }

  vpc_id               = var.vpc_id
  db_subnet_group_name = "db-subnet-group"
  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10
  master_username = "admin"
  master_password = "TechGuruMSA1!"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}