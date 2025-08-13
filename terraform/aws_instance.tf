# ##############################
# IAM: AssumeRole
# ##############################
resource "aws_iam_role" "ec2-assume-role" {
  name               = "ec2-assume-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

# ##############################
# IAM: create policy for assume role
# ##############################
resource "aws_iam_role_policy" "ec2-assume-role-policy" {
  name   = "ec2-assume-role-policy"
  role   = aws_iam_role.ec2-assume-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "${aws_s3_bucket.csv_bucket.arn}",
              "${aws_s3_bucket.csv_bucket.arn}/*"
            ]
        }
    ]
}
EOF

}

# ##############################
# EC2 profile: attatch assume role
# ##############################
resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-assume-role.name
}

# ##############################
# EC2 Instance
# ##############################
resource "aws_instance" "bastion_host" {
  instance_type               = var.aws_ec2_type
  ami                         = var.aws_ec2_ami
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = aws_subnet.main_subnet_public.id
  associate_public_ip_address = true # allow public ip

  key_name = var.aws_key
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile.name     # attach instance profile

  # user data
  user_data = file("${path.module}/../ec2/user_data.sh")

  tags = {
    Name = "bastion_host"
  }
}

# ##############################
# Security Group
# ##############################
resource "aws_security_group" "bastion_sg" {
  name        = "Bastion Security Group"
  description = "Allow SSH access."
  vpc_id      = aws_vpc.vpc_main.id

  # inbound: ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
}

# ##############################
# Output
# ##############################
output "ssh_bastion_host" {
  value = "ssh -i terraform-ec2.pem ubuntu@${aws_instance.bastion_host.public_ip}"
}
