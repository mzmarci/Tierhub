output "lb_arn" {
  value = aws_lb.tierhub_alb.arn
}


output "lb_dns_name" {
  value = aws_lb.tierhub_alb.dns_name
}

output "frontend_target_group_arn" {
  value = aws_lb_target_group.frontend1_tg.arn
}


output "asg_name" {
  value = aws_autoscaling_group.tierhub_asg.name

}
