resource "aws_iam_user" "User1" {
  name          = "User1"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "User1" {
  user    = aws_iam_user.User1.name
}

resource "aws_iam_user" "User2" {
  name          = "User2"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "User2" {
  user    = aws_iam_user.User2.name
}
