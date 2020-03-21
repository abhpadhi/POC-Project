resource "aws_api_gateway_rest_api" "API_Project" {
    name = "API-RDS-Info"
    description = "API gateway to fetch RDS instance details from DynamobDB"
    api_key_source = "HEADER"
    endpoint_configuration {
        types = ["EDGE"]
    }
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.API_Project.id
  parent_id   = aws_api_gateway_rest_api.API_Project.root_resource_id
  path_part   = "rdsinfo"
}

resource "aws_api_gateway_method" "getmethod" {
  rest_api_id   = aws_api_gateway_rest_api.API_Project.id 
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = { 
	#"integration.request.querystring.InstanceType" = true
	"method.request.querystring.InstanceType" = false
  }
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.API_Project.id  
  resource_id             = aws_api_gateway_resource.api_resource.id  
  http_method             = aws_api_gateway_method.getmethod.http_method  
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.project-API.invoke_arn
  request_templates = {
    "application/json" = <<EOF
      {
        "dbType": "$input.params('InstanceType')"
      }
   EOF
  }
}

resource "aws_api_gateway_method_response" "code200" {
  rest_api_id  = aws_api_gateway_rest_api.API_Project.id  
  resource_id  = aws_api_gateway_resource.api_resource.id  
  http_method  = aws_api_gateway_method.getmethod.http_method  
  status_code  = "200"
  response_models = {
        "application/json" = "Error"
  }
}

resource "aws_api_gateway_integration_response" "integrationresponse200" {
  rest_api_id         = aws_api_gateway_rest_api.API_Project.id  
  resource_id         = aws_api_gateway_resource.api_resource.id  
  http_method         = aws_api_gateway_method.getmethod.http_method
  status_code         = aws_api_gateway_method_response.code200.status_code
  response_templates  = {
        "application/json" = <<EOF
   EOF
  }
}

resource "aws_lambda_permission" "Lambda_permission" {
  statement_id  = "permission_api"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.project-API.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.API_Project.execution_arn}/*/*/*"
}
