output "password1" {
  value = aws_iam_user_login_profile.User1.encrypted_password
}

output "password2" {
  value = aws_iam_user_login_profile.User2.encrypted_password
}

output "server_private_ip" {
  value = aws_instance.gl-server-instance.private_ip
}

output "server_id" {
  value = aws_instance.gl-server-instance.id
}
