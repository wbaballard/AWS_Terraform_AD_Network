resource "aws_instance" "workstation1-instance" {
  ami               = "ami-0bde1eb2c18cb2abe"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  # Insert your generated EC2 key pair information from AWS
  key_name          = "main-key"

    network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.workstation1-nic.id
  }
}

resource "aws_instance" "workstation2-instance" {
  ami               = "ami-0bde1eb2c18cb2abe"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  # Insert your generated EC2 key pair information from AWS
  key_name          = "main-key"

    network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.workstation2-nic.id
  }
}