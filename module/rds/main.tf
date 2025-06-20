resource "aws_db_subnet_group" "tierhub_rds_subnet" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_id

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}


resource "aws_db_instance" "tierhub_rds" {
  identifier              = var.db_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  multi_az                = var.multi_az
  publicly_accessible     = false
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.tierhub_rds_subnet.name
  final_snapshot_identifier = "tierhub-db-name-final-001"

  # Production enhancements
  # storage_encrypted            = true
  # backup_retention_period      = 7
  # monitoring_interval          = 0
  # auto_minor_version_upgrade   = true
  # deletion_protection          = true
  # performance_insights_enabled = true


  skip_final_snapshot = false  # Important for backup safety

  tags = {
    Name = "Tierhub RDS"
  }
}
