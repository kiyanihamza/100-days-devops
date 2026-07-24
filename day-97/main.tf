
resource "aws_iam_policy" "iampolicy_javed" {
  name        = "iampolicy_javed"
  description = "Read-only access for viewing EC2 instances, AMIs, and snapshots in the console"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EC2ConsoleReadOnly"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:GetConsole*",
          "ec2:List*"
        ]
        Resource = "*"
      }
    ]
  })
}