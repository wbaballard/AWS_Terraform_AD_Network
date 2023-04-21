output "password1" {
  value = aws_iam_user_login_profile.Ben.encrypted_password
}

output "password2" {
  value = aws_iam_user_login_profile.Jake.encrypted_password
}

output "server_private_ip" {
  value = aws_instance.gl-server-instance.private_ip
}

output "server_id" {
  value = aws_instance.gl-server-instance.id
}