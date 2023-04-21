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
