resource "aws_security_group" "allow_ssh_ter" {
  name = var.sg_group
  # description = usingsecurity allow_ssh

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #allow from every pne here
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "http"
    cidr_blocks      = ["0.0.0.0/0"] #allow from every pne here
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "http"
    cidr_blocks      = ["0.0.0.0/0"] #allow from every pne here
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_region
  }
}