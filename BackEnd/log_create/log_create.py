import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
import pymongo
from dotenv import load_dotenv

load_dotenv(dotenv_path='./.env')

dynamo_client = boto3.resource(
    service_name="dynamodb",
    region_name="us-east-1",
    aws_access_key_id= os.environ.get('AWS_ACCESS_KEY'),
    aws_secret_access_key= os.environ.get('AWS_SECRET_ACCESS_KEY'),
)

performance_table = dynamo_client.Table("performances")
performer_table = dynamo_client.Table("performers")

def lambda_handler(event, context):
    request_body = json.loads(event['body'])


# performer = lambda_handler({
#     'body' : {
        # 'name' : 'Robert Brunney',
        # 'email_address' : 'hisbedrightnow@gmail.com',
        # 'phone_number' : '865-234-2947',
        # 'password' : 'pwd123',
        # 'role' : 'performer',
        # 'performances_participated_in' : [],
        # 'performances_currently_in' : ''
#     }},
#     None
#     )

# print(performer)
