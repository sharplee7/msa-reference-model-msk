variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment_name" {
  description = "msk name"
  type        = string
  default     = "blueprint-msk"
}

variable "subnets" {
  description = "Security Group Name"
  type        = list(string)
}

variable "kafka_version" {
  description = "Kafka Version"
  type        = string
}

variable "broker_type" {
  description = "Kafka broker type"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

