data "http" "myip"{
  url = "https://ifconfig.me"
}

resource "aws_lightsail_key_pair" "key_pair" {
  name       = "ImportedKey"
  public_key = "${file(var.ssh_pubkey)}"
}

resource "aws_lightsail_instance" "lightsail_wp" {
  name              = var.wp_name
  availability_zone = "us-east-1a"
  blueprint_id      = "wordpress"
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.key_pair.id

  tags = merge(
    {
      Name = "${var.wp_name}-lightsail"
    },
    var.common_tag
  )
}

resource "aws_lightsail_instance_public_ports" "enabled_ports" {
  instance_name = aws_lightsail_instance.lightsail_wp.name

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidrs     = ["${chomp(data.http.myip.body)}/32"]
  }
  
  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidrs     = ["${chomp(data.http.myip.body)}/32"]
  }

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidrs     = ["${chomp(data.http.myip.body)}/32"]
  }
}
