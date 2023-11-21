provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "order_service" {
  name                 = "order_service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "customer_service" {
  name                 = "customer_service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}