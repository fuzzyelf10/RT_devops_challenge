resource "aws_autoscaling_group" "asg" {
  name                 = format("%s-%s", "RT-infra", "asg")
  launch_configuration = aws_launch_configuration.lc.name
  min_size             = 3
  max_size             = 5
  desired_capacity     = 3
  vpc_zone_identifier  = module.vpc.private_subnets
  target_group_arns    = [aws_lb_target_group.node_application.arn]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_ecr_repository.python_app
  ]
}

resource "aws_launch_configuration" "lc" {
  name_prefix                 = format("%s-%s", "RT-infra", "lc")
  image_id                    = data.aws_ami.ubuntu-linux-2004.id
  instance_type               = "t3.medium"
  security_groups             = [aws_security_group.sg_infra.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.infra_iam_profile.id
  user_data                   = local.data_userdata

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "lc_hook" {
  name                   = format("%s-%s", "RT-infra", "lc-hook")
  autoscaling_group_name = aws_autoscaling_group.asg.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = 2000
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}