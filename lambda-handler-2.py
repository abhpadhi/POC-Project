import boto3 
from boto3 import resource
from boto3.dynamodb.conditions import Key,Attr
import json
import datetime

dynamodb_resource = resource('dynamodb')
dynamodb = boto3.resource('dynamodb')
dynamo_table = dynamodb.Table('Db_details')
table = dynamodb_resource.Table('Db_details')

def lambda_handler(event, context):
    dbType = event['dbType']
    input_len = len(dbType)
    if dbType is None:
        resp = table.get_item(Key={type: ""})
        items = resp['Items']
    else:
        resp = dynamo_table.scan(FilterExpression=
        Attr('type').eq(dbType))
        items = resp['Items'] 

    return items
