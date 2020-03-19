import boto3 
import datetime
rds = boto3.resource('rds')
#rds_client = boto3.client('rds')
dynamodb = boto3.resource('dynamodb')
dynamodb_table = dynamodb.Table('Db_details')
rds_client = boto3.client('rds', region_name='us-east-1')
db_instances = rds_client.describe_db_instances()
for i in range(len(db_instances('DBInstances'))):    
    db_endpoint = db_instances['DBInstances'][0]['Endpoint']
    db_type = db_instances['DBInstances'][0]['DBInstanceClass']
    dynamodb_table.put_item(
        Item={
            'endpoint': db_endpoint ,
            'instance': db_type
        }
    )
    