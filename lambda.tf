# IAM role creation for Lambda function
resource "aws_iam_role_policy" "lambda_policy" {
  name  = "lambda_role_policy"
  role  = aws_iam_role.iam_for_lambda.id
  policy = <<-EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1584649420508",
      "Action": "rds:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584649451440",
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584649466288",
      "Action": "logs:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584649475940",
      "Action": "execute-api:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584649492946",
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "*"
    }
   ]
  }
 EOF
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": [
		"lambda.amazonaws.com",
		"dynamodb.amazonaws.com",
		"cloudwatch.amazonaws.com",
		"rds.amazonaws.com"
	   ]
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}
#AWS 1st Lambda function creation
resource "aws_lambda_function" "project" {
    function_name = "project_syncron"
    filename      = "lambda_handler.zip"
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = "lambda_handler.lambda_handler"
    source_code_hash = filebase64sha256("lambda_handler.zip")  
    runtime = "python3.7" 
}

#scheduler for Lambda 
resource "aws_cloudwatch_event_rule" "trigger_lambda" {
  name = "trigger_project_lambda"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "run_lambda_five_minutes"{
  rule = aws_cloudwatch_event_rule.trigger_lambda.name
  target_id = "project"
  arn = aws_lambda_function.project.arn
}

resource "aws_lambda_permission" "cloudwatch_to_lambda"{
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.project.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.trigger_lambda.arn
}

#AWS 2nd Lambda Creation 
resource "aws_lambda_function" "project-API" {
    function_name = "project_syncron-API"
    filename      = "lambda-api/lambda_handler.zip"
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = "lambda_handler.lambda_handler"
    source_code_hash = filebase64sha256("lambda-api/lambda_handler.zip")  
    runtime = "python3.7" 
}
