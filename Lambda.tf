# IAM role creation for Lambda function
resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1584280434313",
      "Action": "lambda:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584280538356",
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584280644201",
      "Action": [
        "rds:DescribeDBInstances",
        "rds:ModifyDBInstance"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584280722146",
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:CreateTable",
        "dynamodb:GetItem",
        "dynamodb:GetRecords",
        "dynamodb:ListTables",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem",
        "dynamodb:UpdateTable"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584280750344",
      "Action": "logs:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#AWS 1st Lambda function creation
resource "aws_lambda_function" "project" {
    function_name = "project_syncron"
    filename      = "code_for_lambda_function.zip"
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = "lambda_handler"
    source_code_hash = filebase64sha256("code_for_lambda_function.zip")  
    runtime = "python3.7" 
}

#scheduler for Lambda 
resource "aws_cloudwatch_event_rule" "trigger_lambda" {
  name = "trigger_project_lambda"
  schedule_expression = "rate(5 minutes)"
}

#AWS 2nd Lambda Creation 
#resource "aws_lambda_function" "project-API" {
#    function_name = "project_syncron-API"
#    filename      = "code_for_second_lambda_function.zip"
#    role          = aws_iam_role.iam_for_lambda.arn
#    handler       = "lambda_handler"
#    source_code_hash = filebase64sha256("code_for_second_lambda_function.zip")  
#    runtime = "python3.7" 
#}
