output "document_db_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "document_db_reader_endpoint" {
  value = aws_docdb_cluster.docdb.reader_endpoint
}

output "document_db_jump_box_ip_address" {
  value = aws_instance.docdb_jumpbox.private_ip
}
