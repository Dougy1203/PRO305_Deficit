import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
import pymongo
from pymongo import MongoClient
from dotenv import load_dotenv

load_dotenv()

MONGO_STRING = os.getenv('MONGO_CONNECTION_STRING')
AWS_ACCESS_KEY = os.getenv('AWS_ACCESS_KEY')
AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')

dynamo_client = boto3.resource(
    service_name="dynamodb",
    region_name="us-east-1",
    aws_access_key_id= AWS_ACCESS_KEY,
    aws_secret_access_key= AWS_SECRET_ACCESS_KEY,
)

log_table = dynamo_client.Table("Logs")

mongo_client = MongoClient(MONGO_STRING)

deficit_table = mongo_client["Deficit"]
users_collection = deficit_table["Users"]

def response(status_code, body):
    return {
        "statusCode" : status_code,
        "headers" : {
            "Content-Type" : 'application/json'
        },
        "body" : json.dumps(body),
    }

def lambda_handler(event, context):
    request_body = event['body']
    user = users_collection.find_one({'email' : request_body['email']})
    if user['password'] == request_body['password']:
        try:
            table_logs = log_table.query(
                KeyConditionExpression=Key('email').eq(request_body['email'])
            )
            logs = table_logs['Items']
            log_data = logs[0]
            log_list = log_data['logs']
            response(200, log_list)
        except Exception as e:
            print(e)
            response(500, '[ERROR] Internal Server Error')
    else:
        response(401, 'Login In Attempt Failed')

# lambda_handler({
#     'body' : {
#         'email' : '',
#         'password' : '',
#         'log' : [],
#         }
#     },
#     None
# )
