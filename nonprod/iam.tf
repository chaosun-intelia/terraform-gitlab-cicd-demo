
# resource "aws_iam_openid_connect_provider" "gitlab" {
#   url             = "https://gitlab.com"
#   client_id_list  = ["https://gitlab.com"]
#   thumbprint_list = ["A031C46782E6E6C662C2C87C76DA9AA62CCABD8E"] 
# }

# resource "aws_iam_role" "gitlab_ci_role" {
#   name = "gitlab-ci-oidc-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Federated = aws_iam_openid_connect_provider.gitlab.arn
#         }
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Condition = {
#           StringLike = {
#             "gitlab.com:sub" = [
#               "project_path:chaosundev-group/chaodev-terraform:ref_type:branch:ref:main",
#               "project_path:chaosundev-group/chaodev-terraform:ref_type:branch:ref:test",
#               "project_path:chaosundev-group/chaodev-terraform:ref_type:branch:ref:staging",
#               "project_path:chaosundev-group/chaodev-terraform:ref_type:branch:ref:feature/*"
#             ]
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "s3_access" {
#   role       = aws_iam_role.gitlab_ci_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }
