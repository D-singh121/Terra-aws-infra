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


# my ec2 instance for terraform practice
resource "aws_instance" "my_terra_ec2_instance" {
  # count                  = 2         # create 2 ec2 instance with same name and configuration
  # for multiple instance creation with different configuration use for_each
  for_each = {
    webApp     = { ami = "ami-0e35ddab05955cf57", instance_type = "t2.micro", name = "webApp" }
    backend = { ami = "ami-0e35ddab05955cf57", instance_type = "t2.medium", name = "backendApp" }

  }

  # for multiple instance creation
  ami           = each.value.ami
  instance_type = each.value.instance_type

  # ami                    = var.ec2_ami_id
  # instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.terraform_ec2_key.key_name                 # refrence of key pair name.
  vpc_security_group_ids = [aws_security_group.my_terraform_ec2_security_group.id] # refrence of security group id in array format because we can have multiple security group in one vpc.

  user_data = file("install_Nginx.sh") # install nginx via user data script at first time of ec2 instance launch.
  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = var.ec2_root_volume_type # General Purpose SSD.
  }

  tags = {
    # Name = "MyTerraEC2Demo_Instance"
    Name = each.value.name
  }

  depends_on = [aws_key_pair.terraform_ec2_key] # aws instance depends on key pair creation
}


