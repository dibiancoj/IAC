resource "aws_ecr_repository" "container_repo" {
  name = var.container_repo_name
}
