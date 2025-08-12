# # ##############################
# # EC2 Instance
# # ##############################

# resource "aws_instance" "bastion_host" {
#   instance_type               = var.aws_ec2_type
#   ami                         = var.aws_ec2_ami
#   vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
#   subnet_id                   = aws_subnet.main_subnet_public.id
#   associate_public_ip_address = true # allow public ip

#   key_name = var.aws_key

#   #   user_data_replace_on_change = true

#   # # user data
#   user_data = data.template_cloudinit_config.template_config.rendered

#   tags = {
#     Name = "bastion_host"
#   }
# }

# # ##############################
# # Security Group
# # ##############################
# resource "aws_security_group" "bastion_sg" {
#   name        = "Bastion Security Group"
#   description = "Allow SSH access."
#   vpc_id      = aws_vpc.vpc_main.id

#   # inbound: ssh
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "bastion_sg"
#   }
# }
