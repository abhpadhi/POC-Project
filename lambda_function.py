#### first lambda function to fetch RDS details and insert in DynamoDB
import json
import boto3
import datetime


def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    dynamodb_table = dynamodb.Table('Db_details')
    rds_client = boto3.client('rds',region_name='us-east-1')
    db_instances = rds_client.describe_db_instances()
    db_len = len(db_instances)-1
    print(db_len)
    try:
        for i in range(0,db_len):
            db_endpoint = db_instances['DBInstances'][i]['Endpoint']['Address']
            db_type = db_instances['DBInstances'][i]['DBInstanceClass']
            dynamodb_table.put_item(
                Item={
                    'endpoint': db_endpoint,
                    'type': db_type
                }
           )

        return {
           'status': 200
           #'db_len': db_len
        }


    except Exception as e:
            print(e)
            print('Db Not found')
            raise e

