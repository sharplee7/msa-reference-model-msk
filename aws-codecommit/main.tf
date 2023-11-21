provider "aws" {
  region = var.aws_region
}

resource "aws_codecommit_repository" "order-example" {
  repository_name = "order-example"
  description     = "order service codecommit"
}

resource "aws_codecommit_repository" "customer-example" {
  repository_name = "customer-example"
  description     = "customer service codecommit"
}
