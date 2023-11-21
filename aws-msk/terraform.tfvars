aws_region          = "ap-northeast-2"
environment_name     = "eks-blueprint-msk"

vpc_id              = "vpc-045d668c5c2fde5ea"
subnets             = ["subnet-02f6f30a676c6717d", "subnet-0a823f78518c405fa", "subnet-0e2e70be15ce1251b"]

kafka_version       = "2.6.2"
broker_type         = "kafka.t3.small"