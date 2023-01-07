Version 1.0
 - Initial Release
 
***

#### Basic Example (See  Please see [Ecs_Service](https://github.com/dibiancoj/IAC/tree/main/Modules/ecs_service) for a full example with a cluster)

 ```
module "my_ecs_cluster" {
  source = "../../Modules/ecs_cluster"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/ecs_cluster"
  cluster_name                 = "my_ecs_cluster"
  ecs_task_execution_role_name = "my_ecs_exec_role"
  permissions_boundary         = null
}
 ```

 #### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
