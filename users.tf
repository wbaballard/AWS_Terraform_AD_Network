resource "aws_iam_user" "Ben" {
  name          = "Ben"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "Ben" {
  user    = aws_iam_user.Ben.name
}

resource "aws_iam_user" "Jake" {
  name          = "Jake"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "Jake" {
  user    = aws_iam_user.Jake.name
}


# Notes
# _______________

# resource "aws_iam_user_policy_attachment" "ec2-user-full" {
#   count      = length(var.username)
#   user       = element(aws_iam_user.newusers.*.name, count.index)
#   #policy_arn = "${aws_iam_policy.ec2_readonly.arn}"
#   policy_arn = aws_iam_policy.ec2_full.arn
# }

# # basic example
# variable principal_name { default = "testuser" }
# variable samaccountname { default = "testuser" }
# variable container      { default = "CN=Users,DC=MITRE,DC=org" }

# resource "ad_user" "u" {
#   principal_name    = var.principal_name
#   sam_account_name  = var.samaccountname
#   display_name      = "Terraform Test User 1"
#   container                 = var.container
#   initial_password          = "Password1"
#   company                   = "MITRE"
# }

# # all user attributes
# variable principal_name2 { default = "testuser2" }
# variable samaccountname2 { default = "testuser2" }
# variable container      { default = "CN=Users,DC=MITRE,DC=org" }

# resource "ad_user" "u2" {
#   principal_name            = var.principal_name2
#   sam_account_name          = var.samaccountname2
#   display_name              = "Terraform Test User 2"
#   container                 = var.container
#   initial_password          = "Password2"
#   company                   = "MITRE"
# #   city                      = "City"
# #   country                   = "us"
# #   department                = "Department"
# #   description               = "Description"
# #   division                  = "Division"
# #   email_address             = "some@email.com"
# #   employee_id               = "id"
# #   employee_number           = "number"
# #   fax                       = "Fax"
# #   given_name                = "GivenName"
# #   home_directory            = "HomeDirectory"
# #   home_drive                = "HomeDrive"
# #   home_phone                = "HomePhone"
# #   home_page                 = "HomePage"
# #   initials                  = "Initia"
# #   mobile_phone              = "MobilePhone"
# #   office                    = "Office"
# #   office_phone              = "OfficePhone"
# #   organization              = "Organization"
# #   other_name                = "OtherName"
# #   po_box                    = "POBox"
# #   postal_code               = "PostalCode"
# #   state                     = "State"
# #   street_address            = "StreetAddress"
# #   surname                   = "Surname"
# #   title                     = "Title"
# #   smart_card_logon_required = false
# #   trusted_for_delegation    = true
# }
