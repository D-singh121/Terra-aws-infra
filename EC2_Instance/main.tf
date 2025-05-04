
# key pair genrate by ssh-keygen command
resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terra-ec2-key.pub")
}

# vpc  and security group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my_terraform_ec2_security_group" {
  name        = "my_terraform_ec2_security_group"
  description = "This will generate a security group for ec2 instance via terraform"
  vpc_id      = aws_default_vpc.default.id # interpolation example

  # inbound rules: simply ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }


  # outbound rules: simply egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          // any protocol
    cidr_blocks = ["0.0.0.0/0"] // all ip address
    description = "Allow all outbound traffic"
  }

}


# my demo instance for terraform practice
resource "aws_instance" "my_terra_ec2_instance" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.terraform_ec2_key.key_name                 # refrence of key pair name
  vpc_security_group_ids = [aws_security_group.my_terraform_ec2_security_group.id] # refrence of security group id in array format because we can have multiple security group in one vpc

  root_block_device {
    volume_size = 15
    volume_type = "gp3" # General Purpose SSD
  }

  tags = {
    Name = "MyTerraEC2Demo_Instance"
  }
}

# output public ip for ec2 instance
output "ec2_public_ip" {
  value       = aws_instance.my_terra_ec2_instance.public_ip
  description = "The public IP address of the EC2 instance"
}

