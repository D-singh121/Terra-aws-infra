variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"

}

variable "ec2_ami_id" {
  type    = string
  default = "ami-0e35ddab05955cf57"
}

variable "ec2_root_volume_size" {
  default = 15
  type    = number

}

variable "ec2_root_volume_type" {
  default = "gp3"
  type    = string
}
