# ALB variables
variable "alb_name" {
  description = "The name of the ALB"
  default = "teirhub-demo"
  type        = string
}


variable "public_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "private_subnets_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}


# Suggestion: If your app only works on paths like /admin or /dashboard, use "/admin" instead of / here.

variable "health_check_path" {
  description = "Health check path for the ALB target group"
  type        = string
  default     = "/"
}
 
variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of successful health checks before considering an instance healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of failed health checks before considering an instance unhealthy"
  type        = number
  default     = 3
}


variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired capacity of instances in ASG"
  type        = number
  default     = 2
}

variable "health_check_grace_period" {
  description = "Grace period for ASG health checks (seconds)"
  type        = number
  default     = 300
}

# Auto Scaling scaling policies
variable "scale_up_adjustment" {
  description = "Scaling adjustment for scaling up"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Scaling adjustment for scaling down"
  type        = number
  default     = -1
}

variable "scale_cooldown" {
  description = "Cooldown period between scaling actions (seconds)"
  type        = number
  default     = 300
}

variable "alb_security_group_id" {
  description = "Security Group ID for Load Balancer"
  type        = list
}

variable "frontend_target_group_arn" {
  description = "List of target group ARNs"
  type        = string
}


