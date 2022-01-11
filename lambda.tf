module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name       = "wpLightSailBackup"
  description         = "A lambda function to backup the Wordpress site on AWS LightSail"
  handler             = "snapshots.handler"
  runtime             = "python3.8"
  source_path         = "./snapshots.py"

  role_name           = "wpLightSailBackupRole"
  attach_policy_json  = true
  policy_json         = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lightsail:GetInstances",
                "lightsail:DeleteInstanceSnapshot",
                "lightsail:GetInstanceSnapshots",
                "lightsail:CreateInstanceSnapshot"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  timeout             = 60
  create_current_version_allowed_triggers   = false
  create_unqualified_alias_allowed_triggers = false
  cloudwatch_logs_retention_in_days         = var.cloudwatch_logs_retention
  cloudwatch_logs_tags                      = var.common_tag
  tags = merge(
    {
      Name = "wpLightSailBackup-lambda"
    },
    var.common_tag
  )
}
