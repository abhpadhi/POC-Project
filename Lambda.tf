# IAM role creation for Lambda function
resource "aws_iam_role_policy" "lambda_policy" {
  name  = "lambda_role_policy"
  role  = aws_iam_role.iam_for_lambda.id
  policy = <<-EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1584631650584",
      "Action": "lambda:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584631713629",
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584631730371",
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1584631751806",
      "Action": "rds:*",
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

resource "aws_cloudwatch_event_target" "run_lambda_five_minutes"{
  rule = aws_cloudwatch_event_rule.trigger_lambda.id
  target_id = "lambda"
  arn = aws_lambda_function.project.arn
}


#AWS 2nd Lambda Creation 
resource "aws_lambda_function" "project-API" {
    function_name = "project_syncron-API"
    filename      = "code_for_second_lambda_function.zip"
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = "lambda_handler"
    source_code_hash = filebase64sha256("code_for_second_lambda_function.zip")  
    runtime = "python3.7" 
}
