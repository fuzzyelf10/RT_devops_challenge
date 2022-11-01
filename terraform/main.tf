resource "aws_lb" "application" {
  name                             = format("%s-%s", "RT-infra", "application-lb")
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.sg_alb.id]
  subnets                          = module.vpc.public_subnets
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "node_application_listeners" {
  load_balancer_arn = aws_lb.application.arn
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node_application.arn
  }
}

resource "aws_lb_target_group" "node_application" {
  name     = format("%s-%s", "RT-infra", "tg")
  port     = "5000"
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = "5000"
    protocol = "HTTP"
    path     = "/status"
    interval = 10
  }
}

#resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#  autoscaling_group_name = aws_autoscaling_group.asg.id
#  lb_target_group_arn    = aws_lb_target_group.node_application.arn
#}