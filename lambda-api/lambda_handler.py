##Lambda function to fetch RDS details back to API endpoint based on USER inputs
import boto3 
from boto3 import resource
from boto3.dynamodb.conditions import Key,Attr
import json
import datetime

dynamodb_resource = resource('dynamodb')
dynamodb = boto3.resource('dynamodb')
dynamo_table = dynamodb.Table('rds_data_table')
table = dynamodb_resource.Table('rds_data_table')

def lambda_handler(event, context):
    dbType = event['dbType']
    input_len = len(dbType)
    if input_len < 0:
        resp = table.get_item(Key={type: ""})
        items = resp['Items']
    else:
        resp = dynamo_table.scan(FilterExpression=
        Attr('DBtype').eq(dbType))
        items = resp['Items'] 

    return items
