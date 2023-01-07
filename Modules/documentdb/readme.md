Version 1.0
 - Initial Release
 
***

Please see [here](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/DocumentDb) for a working example.

#### Basic Example

 ```
module "my_doc_db_root_password" {
  source = "../../Modules/secrets_auto_generated"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/secrets_auto_generated"
  application_name               = "my_docdb_auth_code"
  secret_name                    = "my_docbd_auth_code"
  secret_length                  = 16
  special_characters             = false
  secret_recovery_window_in_days = 0
}

module "my_doc_db" {
  source = "../../Modules/documentdb"
  //source = "git::https://github.com/dibiancoj/IAC.git//Modules/documentdb"
  vpc_id                  = "vpc-5dd17e36"
  application_name        = "my-doc-db-app"
  cluster_name            = "my-doc-db-cluster"
  db_instance_name        = "my-db-instance-name"
  db_encryption_at_rest   = true
  db_instance_count       = 2
  db_admin_user_name      = "root"
  db_admin_user_pw_arn    = module.my_doc_db_root_password.secret_arn
  db_instance_type        = "db.t3.medium"
  backup_retention_period = 1
  deletion_protection     = false
  jumpbox_ssh_key_name    = "bla2"
  jumpbox_image_id        = "ami-090fa75af13c156b4"
}

output "docdb_cluster_endpoint" {
  value = module.my_doc_db.document_db_endpoint
}

output "docdb_reader_endpoint" {
  value = module.my_doc_db.document_db_reader_endpoint
}

output "docdb_jump_box_private_ip" {
  value = module.my_doc_db.document_db_jump_box_ip_address
}

output "docdb_root_pw_secret_arn" {
  value = module.my_doc_db_root_password.secret_arn
}

 ```

 #### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
