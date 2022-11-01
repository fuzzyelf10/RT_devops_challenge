output "alb_url" {
    value = aws_lb.application.dns_name
}