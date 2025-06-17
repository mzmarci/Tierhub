variable "ec2_ami" {
  description = "this is a variable to manage ec2_ami type"
  type        = string
  default     = "ami-015b1e8e2a6899bdb"
}

variable "ec2_instance_type1" {
  description = "this is a variable to manage ec2_instance_type"
  type        = string
  default     = "prod"

}

variable "ec2_instance_type" {
  description = "this is a variable to manage ec2_instance_type"
  type        = string
  default     = "t2.small"

}

variable "ec2_key_name" {
  description = "this is a variable to manage ec2_key_name"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}
variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
  default     = "Reader"

}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS instance in GB"
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "Instance class for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "reader"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "ReaderRDS"
}

variable "engine" {
  description = "Username for the database"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Username for the database"
  type        = string
  default     = "17.2"
}

# variable " db-identifier" {
#   description = "Username for the database"
#   type        = string
#   default     = "reader_db"
# }

# variable "db_password" {
#   description = "Database password"
#   type        = string
#   sensitive   = true
# }