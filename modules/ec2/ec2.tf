#EC2ロール
resource "aws_iam_role" "ec2_role" {
  name = "${var.resourceName}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.resourceName}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ec2_instance_private" {
  ami                    = "ami-0e2612a08262410c8" # AmazonLinux
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.allow_ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  key_name               = "aws-eb"

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "${var.resourceName}-instance"
  }
}

