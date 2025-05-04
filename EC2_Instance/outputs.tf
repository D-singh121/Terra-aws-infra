# output public ip for ec2 instance
output "ec2_public_ip" {
  value       = aws_instance.my_terra_ec2_instance.public_ip
  description = "The public IP address of the EC2 instance"
}


output "ec2_public_dns" {
  value       = aws_instance.my_terra_ec2_instance.public_dns
  description = "The public DNS address of the EC2 instance"

}