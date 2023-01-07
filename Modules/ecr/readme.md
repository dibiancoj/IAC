Version 1.0
 - Initial Release
 
***

Please see [here](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/Ecr) for a working example.

#### Basic Example

 ```
module "my_ecr" {
  source = "../../Modules/ecr"
  //source = "git::https://github.com/dibiancoj/IAC.git//Modules/ecr"
  container_repo_name = "my-repo"
}

output "my_ecr_url" {
  value = module.my_ecr.container_repo
}

 ```

 #### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
