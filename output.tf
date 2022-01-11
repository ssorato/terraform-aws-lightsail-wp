output "ip" {
  value = aws_lightsail_instance.lightsail_wp.public_ip_address
  description = "The public IP address of the instance"
}

output "is_statis_ip" {
  value = aws_lightsail_instance.lightsail_wp.is_static_ip
  description = "A Boolean value indicating whether this instance has a static IP assigned to it"
}

output "username" {
  value = aws_lightsail_instance.lightsail_wp.username
  description = "The user name for connecting to the instance"
}