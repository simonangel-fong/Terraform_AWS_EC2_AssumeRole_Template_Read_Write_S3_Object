# # ##############################
# # User
# # ##############################
# resource "aws_iam_user" "tf-admin1" {
#   name = "tf-admin1"
# }

# resource "aws_iam_user" "tf-admin2" {
#   name = "tf-admin2"
# }

# # ##############################
# # Group
# # ##############################
# resource "aws_iam_group" "tf-admin-group" {
#   name = "tf-admin-group"
# }

# # group policy attachment
# resource "aws_iam_policy_attachment" "tf-admin-policy-attach" {
#   name       = "tf-admin-policy-attach"
#   groups     = [aws_iam_group.tf-admin-group.name]
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# # group membership
# resource "aws_iam_group_membership" "tf-admin-group-membership" {
#   name = "administrators-users"
#   users = [
#     aws_iam_user.tf-admin1.name,
#     aws_iam_user.tf-admin2.name,
#   ]
#   group = aws_iam_group.tf-admin-group.name
# }

# output "warning" {
#   value = "WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources"
# }
