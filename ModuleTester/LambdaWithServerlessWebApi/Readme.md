###### Install The Lambda Tools
```dotnet tool install -g Amazon.Lambda.Tools```
```dotnet tool update -g Amazon.Lambda.Tools```

###### Build The Lamda
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithServerlessWebApi\LambdaSrc\Code``` <-- cd into the project folder where the project is. 

Run
```dotnet lambda package --framework net6.0 --output ../../artifacts/myfunction.zip```

###### Run Terraform
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithServerlessWebApi```

```terraform init```

```terraform plan```

```terraform apply```

###### Run Api
Call HttpGet {{loadBalancerUrl}}/Calculator with Header = "my-header" / "my-header-value-1"
Call HttpPost {{loadBalancerUrl}}/Calculator with Header = "my-header" / "my-header-value-1"

###### Serverless Api Project Template Type:

![Serverless Project Type Selection](https://github.com/dibiancoj/IAC/blob/main/DocumentationResources/ServerlessTemplateTypeVS.png)

###### Notes
1. You don't need to add header request value. ie: alb_lambda_function_one alb_request_routing_by_request_header_name. To use it raw you would just need that module
"ambda_alb_function_instance" and for the alb listener just don't put the condition tag
