
resource "aws_iam_user" "dnna_usr" {
    name = var.dns_iam_name

    tags = {
        creator = "me"
    }
}


resource "aws_iam_group" "dnna_grp" {
  name = var.dns_grp_name
}


resource "aws_iam_group_membership" "dnna_grp_members" {
    name = aws_iam_user.dnna_usr.name
    users =  [aws_iam_user.dnna_usr.name]
    group = aws_iam_group.dnna_grp.name    
}


data "aws_iam_policy_document" "dnna_verify_ens" {
    statement {
        actions = [ 
            # "route53:GetChange",
            # "route53:ListHostedZones",
            # "route53:ListHostedZonesByName",
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets"
        ]

        resources = [ 
            "arn:aws:route53:::hostedzone/${var.dns_hostid}"
        ]

    }
    statement {
        actions = [ 
            "route53:GetChange",
            "route53:ListHostedZones",
            "route53:ListHostedZonesByName",
            # "route53:ChangeResourceRecordSets",
            # "route53:ListResourceRecordSets"
        ]

        resources = [ 
            "*"
        ]

    }
}

resource "aws_iam_policy" "dnna_policy" {
  name = var.dnna_policy  
  policy = data.aws_iam_policy_document.dnna_verify_ens.json
}


resource "aws_iam_group_policy_attachment" "dns_verify_access" {
    policy_arn = aws_iam_policy.dnna_policy.arn
    group      = aws_iam_group.dnna_grp.name
}


#create access key ID and secret key 
resource "aws_iam_access_key" "dnna_access_key" {
  user = aws_iam_user.dnna_usr.name
}

output "access_key_id" {
  value = aws_iam_access_key.dnna_access_key.id
  sensitive = true
}

output "secret_access_key" {
  value = aws_iam_access_key.dnna_access_key.secret
  sensitive = true
}

locals {
  dnna_keys_csv = "access_key,secret_key\n${aws_iam_access_key.dnna_access_key.id},${aws_iam_access_key.dnna_access_key.secret}"
}

resource "local_file" "dnna_keys" {
  content  = local.dnna_keys_csv
  filename = "dnna-keys.csv"
}

