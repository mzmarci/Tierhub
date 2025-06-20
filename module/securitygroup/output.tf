
output "alb_security_group_id" {
  value = aws_security_group.lb_security_group.id
}

output "web_security_group_id" {
  value = aws_security_group.frontend_sg.id
}


output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}
