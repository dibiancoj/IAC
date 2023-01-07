Version 1.0
 - Initial Release
 
***

Please see the following for more complex scenarios
- [1 alb for 1 application](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/EcsClusterWithEcsServiceAndAlb)
- [1 alb for 2 application using path urls](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/EcsClusterWith2EcsServiceAnd1Alb)

#### Basic Example

 ```
module "my_alb" {
  source = "../../Modules/alb"
  //source                    = "git::https://github.com/dibiancoj/IAC.git//Modules/alb"
  vpc_id                      = local.vpc_id
  alb_name                    = "my-alb"
  alb_is_internal_access_only = false
  app_port                    = local.port_for_listner
}

output "alb_url" {
  value = module.my_alb.alb_hostname
}

 ```

 #### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
