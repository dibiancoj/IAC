###### Install The Lambda Tools
```dotnet tool install -g Amazon.Lambda.Tools```
```dotnet tool update -g Amazon.Lambda.Tools```

###### Build The Lamda
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithSqs\LambdaSrc\Code``` <-- cd into the project folder where the project is. 

Run
```dotnet lambda package --framework net6.0 --output ../../artifacts/myfunction.zip```

###### Run Terraform
```cd D:\Development\Terraform\TerraformGitHub\ModuleTester\LambdaWithEventBridge```

```terraform init```

```terraform plan```

```terraform apply```
