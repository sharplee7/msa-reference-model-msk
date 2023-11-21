variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment_name" {
  description = "aurora name"
  type        = string
  default     = "blueprint-aurora"
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

