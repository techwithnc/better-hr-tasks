output "lb_dns_name" {
  value = aws_lb.lb01.dns_name
}
output "lb_zone_id" {
  value = aws_lb.lb01.zone_id
}
output "lb_tg_arn" {
  value = aws_lb_target_group.tg01.arn
}