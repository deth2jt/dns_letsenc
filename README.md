
  199  terraform state list

  200  terraform state rm aws_iam_user.foouser


  201  terraform state list



  203  terraform show 

  204  terraform state rm aws_iam_user.foouser --dry--run


  205  terraform state rm aws_iam_user.foouser --dry-run

  206  terraform import aws_iam_user.foouser 

    174  terraform plan -var-file terraform.tfvars 

  175  terraform apply -var-file terraform.tfvars 




terraform.tfvars

  dns_iam_name  = ""

dns_grp_name = ""

dns_hostid = ""


profile_name = ""

this_region = ""

policy_name = ""