module "my_ecr" {
  source = "../../Modules/ecr"
  //source = "git::https://github.com/dibiancoj/IAC.git//Modules/ecr"
  container_repo_name = "my-repo"
}

output "ecr_url" {
  value = module.my_ecr.container_repo
}
