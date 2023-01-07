module "my_secret_auto_generated" {
  source = "../../Modules/secrets_auto_generated"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/secrets_auto_generated"
  application_name               = "my-application-one-auto"
  secret_name                    = "my-secret-name-auto-generated"
  secret_length                  = 16
  special_characters             = false
  secret_recovery_window_in_days = 0
}

output "my_secret_auto_generated_arn" {
  value = module.my_secret_auto_generated.secret_arn
}
