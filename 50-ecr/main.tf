resource "aws_ecr_repository" "ecrs" {
  count=2
  name                 = count.index == 0 ? "expense/backend":"expense/frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}