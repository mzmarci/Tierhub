resource "aws_security_group" "lb_security_group" {
  name        = "lb_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = var.vpc_id
 
  tags = {
    Name = "stock load balancer secuirty group"
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}


resource "aws_security_group" "frontend_sg" {   //frontend layer
  name        = "web_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Tierhub-web"
  }
}

resource "aws_security_group_rule" "web_ingress2" {
  security_group_id        = aws_security_group.frontend_sg.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]  # Open to internet
}

resource "aws_security_group_rule" "web_ingress" {
  security_group_id        = aws_security_group.frontend_sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id  # Allow traffic only from LB
}

resource "aws_security_group_rule" "web_ingress1" {
  security_group_id        = aws_security_group.frontend_sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id  # Allow traffic only from LB
}


resource "aws_security_group_rule" "web_ingress3" {
  security_group_id        = aws_security_group.frontend_sg.id
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id  # Allow traffic only from LB
}

resource "aws_security_group_rule" "web_ingress4" {
  security_group_id        = aws_security_group.frontend_sg.id
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 4000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id  # Allow traffic only from LB
}

resource "aws_security_group_rule" "web-egress-rule" {
  security_group_id = aws_security_group.frontend_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

}

