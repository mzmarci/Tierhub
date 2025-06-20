output "db_endpoint" {
  value = aws_db_instance.tierhub_rds.endpoint
  description = "The endpoint of the RDS instance"
}