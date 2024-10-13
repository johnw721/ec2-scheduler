resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"


tags = {
  Name = "Automation Scheduling Project"
}
}

# Lambda Function to Start EC2 instance in K8 Cluster

data "aws_lambda_function" "start_ec2_instance" {
  function_name = ""

  role = ""

  description = "Lambda function to start an EC2 instance"
}

# Attach necessary role(s) to Lambda Function

data "aws_iam_policy_document" "assume_role"{

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name="lambda_iam"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Lambda Function to Stop EC2 in K8 Cluster

resource "aws_lambda_function" "stop_ec2_instance" {
  function_name = "stop_instance"

  role = ""

  description = "Lambda function to start an EC2 instance"
}

# Create necessary role for Lambda Function



# Attach necessary role(s) to Lambda Function


#  Create CloudWatch event triggers and set schedulers that connect to and trigger corresponding lambda functions

resource "aws_cloudwatch_event_rule" "start_ec2" {
    name        = "start-ec2-instance"
    description = "Start EC2 instance in K8 cluster"

    event_pattern = jsonencode({
        detail-type = [
            "EC2 Instance State-change Notification"
        ]
    })

}

resource "aws_cloudwatch_event_rule" "stop_ec2" {
    name        = "stop-ec2-instance"
    description = "Stop EC2 instance in K8 cluster"

    event_pattern = jsonencode({
        detail-type = [
            "EC2 Instance State-change Notification"
        ]
    })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule

resource "aws_scheduler_schedule" "example" {
  name       = "my-schedule"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(1 hours)"

  target {
    arn      = aws_sqs_queue.example.arn
    role_arn = aws_iam_role.example.arn
  }
}