module "dnna" {
  source = "./dnna"
  dns_hostid = var.dns_hostid
  dns_iam_name  = var.dns_iam_name
  dns_grp_name = var.dns_grp_name
  profile_name = var.profile_name
  dnna_policy = var.policy_name
}

output "message" {
  value = "add aws creds to dns-conf/route53.ini docker:lscr.io/linuxserver/swag"
}

# resource "aws_iam_user" "foouser" {
#   # (resource arguments)
#   name = "denny"
# }
