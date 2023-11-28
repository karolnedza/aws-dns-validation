
resource "aws_route53_record" "example" {
  for_each = {
    for dvo in var.aws_cert : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}


data "aws_route53_zone" "example" {
  name         = "avxlab.cc"
  private_zone = false
}


variable "aws_cert" {
}

