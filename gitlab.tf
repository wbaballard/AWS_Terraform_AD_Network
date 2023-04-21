resource "aws_instance" "gl-server-instance" {
  ami               = "ami-007855ac798b5175e"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  # Insert your generated EC2 key pair information from AWS
  key_name          = "main-key"

    network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.gl-server-nic.id
  }
}

# Ubuntu GitLab instalation: https://about.gitlab.com/install/#ubuntu
