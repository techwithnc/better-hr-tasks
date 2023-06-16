resource "aws_route53_record" "app01" {
  zone_id = "${var.hosted_zone_id}"
  name    = "chat"
  type    = "A"
  alias {
    name = "${var.lb_dns_name}"
    zone_id = "${var.lb_zone_id}"
    evaluate_target_health = true
  }
}
resource "aws_acm_certificate" "cert01" {
  domain_name       = "chat.techwithnc.net"
  validation_method = "DNS"

  tags = {
    Name = "For Certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "cert01" {
  allow_overwrite = true
  name =  tolist(aws_acm_certificate.cert01.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.cert01.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.cert01.domain_validation_options)[0].resource_record_type
  zone_id = "${var.hosted_zone_id}"
  ttl = 60
}
resource "aws_acm_certificate_validation" "cert01_validate" {
  certificate_arn = aws_acm_certificate.cert01.arn
  validation_record_fqdns = [aws_route53_record.cert01.fqdn]
}