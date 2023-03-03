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

MS = os.getenv('MCS')
AAK = os.getenv('AAK')
ASAK = os.getenv('ASAK')

dynamo_client = boto3.resource(
    service_name="dynamodb",
    region_name="us-east-1",
    aws_access_key_id= AAK,
    aws_secret_access_key= ASAK,
)

log_table = dynamo_client.Table("Logs")

mongo_client = MongoClient(MS)

deficit_table = mongo_client["Deficit"]
users_collection = deficit_table["Users"]

def response(status_code, body):
    return {
        "statusCode" : status_code,
        "headers" : {
            "Content-Type" : 'application/json'
        },
        "body" : json.dumps({'message' : body}),
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
            final_logs = []
            for log in log_list:
                temp_log = {}
                temp_log['fat'] = int(log['fat'])
                temp_log['protein'] = int(log['protein'])
                temp_log['carb'] = int(log['carb'])
                temp_log['calories'] = int(log['calories'])
                final_logs.append(temp_log)
            return response(200, final_logs)
        except Exception as e:
            print(e)
            return response(500, '[ERROR] Internal Server Error')
    else:
        return response(401, 'Login In Attempt Failed')

# loc = lambda_handler({
#     'body' : {
#         'email' : 'cstanley@gmail.com',
#         'password' : 'root',
#         }
#     },
#     None
# )
# print(loc)