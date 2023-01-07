module "my_secret_one" {
  source = "../../Modules/secrets_pre_generated"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/secrets_pre_generated"
  application_name               = "my-application-one"
  secret_name                    = "my-secret-name"
  secret_default_value           = "my value"
  secret_recovery_window_in_days = 0
}

module "my_secret_two" {
  source = "../../Modules/secrets_pre_generated"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/secrets_pre_generated"
  application_name               = "my-application-two"
  secret_name                    = "my-secret-name"
  secret_default_value           = jsonencode({ "UserName" : "MyUser", "Password" : "MyPassword" })
  secret_recovery_window_in_days = 0
}

output "secret_one_arn" {
  value = module.my_secret_one.secret_arn
}

output "secret_two_arn" {
  value = module.my_secret_two.secret_arn
}
