resource "aws_security_group" "sg_infra" {
  name   = "sg_data"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "infra_ingress_5000_allow_cidr" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.sg_infra.id
}

resource "aws_security_group_rule" "infra_egress_allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_infra.id
}

resource "aws_security_group" "sg_alb" {
  name   = "sg_alb"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "alb_ingress_5000_allow_cidr" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "alb_egress_allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_alb.id
}