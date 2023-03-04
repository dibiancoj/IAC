#### Adjustments Needed From Normal Lambda Setup
1. Use the custom runtime template - ![Custom runtime template](https://github.com/dibiancoj/IAC/blob/main/DocumentationResources/LambdaCustomRunTime.png)
2. In aws-lambda-tools-defaults.json. Add ```"msbuild-parameters": "--self-contained true"```
3. In aws-lambda-tools-defaults.json. Add ```"function-handler": "bootstrap"```
4. In aws-lambda-tools-defaults.json. Add ```"function-runtime": "provided.al2",```
5. Terraform lambda_that_gets_triggered_one - ```runtime = provided.al2```

###### Install The Lambda Tools
```dotnet tool install -g Amazon.Lambda.Tools```
```dotnet tool update -g Amazon.Lambda.Tools```

###### Build The Lamda
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithAlb_InNet7_Bring_OwnFramework\LambdaSrc\Code``` <-- cd into the project folder where the project is. 

Run
```dotnet lambda package --framework net7.0 --output ../../artifacts/myfunction.zip```

###### Run Terraform
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithAlb_InNet7_Bring_OwnFramework```

```terraform init```

```terraform plan```

```terraform apply```