resource "aws_cloudwatch_event_rule" "event_rule" {
  name = "lightsail-backup-schedule"
  description = "Create a snapshot every day"
  schedule_expression = "cron(0 3 * * ? *)"
  tags = merge(
    {
      Name = "lightsail-backup-schedule"
    },
    var.common_tag
  )
}

resource "aws_cloudwatch_event_target" "event_target" {
  arn = module.lambda_function.lambda_function_arn
  rule = aws_cloudwatch_event_rule.event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.event_rule.arn
}
