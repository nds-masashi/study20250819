#EC2セキュリティーグループ
resource "aws_security_group" "allow_ec2_sg" {
  name        = "${var.resourceName}-ec2-sg"
  description = "Allow ec2 sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.specificAddress]
    description = "http"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.specificAddress]
    description = "ssh"
  }

  tags = {
    Name = "${var.resourceName}-ec2-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_ssh_rule" {
  security_group_id = aws_security_group.allow_ec2_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "ssh"
}

resource "aws_vpc_security_group_egress_rule" "ec2_https_rule" {
  security_group_id = aws_security_group.allow_ec2_sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "https"
}

resource "aws_vpc_security_group_egress_rule" "ec2_http_rule" {
  security_group_id = aws_security_group.allow_ec2_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "http"
}