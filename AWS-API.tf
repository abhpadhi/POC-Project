resource "aws_api_gateway_rest_api" "API_Project" {
    name = "API-RDS-Info"
    description = "API gateway to fetch RDS instance details from DynamobDB"
    api_key_source = "HEADER"
    endpoint_configuration {
        types = ["EDGE OPTIMIZED"]
    }
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.API_project.id
  parent_id   = aws_api_gateway_rest_api.API_project.root_resource_id
  path_part   = "rdsinfo"
}

resource "aws_api_gateway_method" "getmethod" {
  rest_api_id   = aws_api_gateway_rest-api.API_Project.id 
  resource_id   = aws_api+gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = { 
	    "integration.request.querystring.var1"="'InstanceType'"
  }
}

#resource "aws_api_gateway_method" "gateway_method" {
#
#  
#  
#  request_parameters = { 
#	    "integration.request.querystring.var1"="'InstanceType'"
#  }
#}


resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.API_Project.id  
  resource_id             = aws_api_gateway_resource.api_resource.id  
  http_method             = aws_api_gateway_method.getmethod.http_method  
  type                    = "AWS"
  integration_http_method = "GET"
  uri                     = aws_lambda_function.project.invoke_arn
  request_templates = {
    "application/json" = <<EOF
      {
        "dbType": "$input.params('InstanceType')"
      }
  }

}

