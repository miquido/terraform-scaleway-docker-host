data "aws_route53_zone" "domain" {
  zone_id = var.route53_zone_id
}

resource "aws_iam_user" "acme" {
  name = "${var.project}-${var.environment}-acme"
}

resource "aws_iam_user_policy" "acme" {
  name = "${var.project}-${var.environment}-acme"
  user = aws_iam_user.acme.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:GetChange",
          "route53:ChangeResourceRecordSets",
        ]
        Resource = [
          data.aws_route53_zone.domain.arn,
          "arn:aws:route53:::change/*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListHostedZonesByName",
          "route53:ListResourceRecordSets",
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_access_key" "acme" {
  user = aws_iam_user.acme.name
}

resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [scaleway_instance_ip.public.address]
}

resource "aws_route53_record" "wildcard" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "*.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [scaleway_instance_ip.public.address]
}

resource "aws_route53_record" "oidc" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "oidc.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [module.oidc.oidc_endpoint]
}
