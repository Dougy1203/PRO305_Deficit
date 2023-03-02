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
    if(user and (user['password'] == request_body['password'])):
        try:
            table_logs = log_table.query(
                KeyConditionExpression=Key('email').eq(request_body['email'])
            )
            user = users_collection.find_one({'email' : request_body['email']})
            logs_data = table_logs['Items'][0]
            print(logs_data)
            logs = logs_data['logs']
            print(logs)
            if(logs):
                for log in logs:
                    if(log['date'] == request_body['date']):
                        logs.remove(log)
                        print(logs)
                        log_table.update_item(
                            Key={
                                'email': request_body['email'],
                            },
                            UpdateExpression='SET #ts = :val1',
                            ExpressionAttributeValues={
                              ":val1": logs,
                            },
                            ExpressionAttributeNames={
                              "#ts": "logs"
                            }
                        )
                        print(f'Log Deleted With Date: {request_body["date"]}')
                        return response(200, f'Log Deleted With Date: {request_body["date"]}')
                    else:
                        return response(401, 'Date Not Found:::: Try Again')
            else:
                return response(401, f'Log Not Found with Email: {request_body["email"]}')  
        except Exception as e:
            print(e)
            return response(500, '[ERROR] Internal Server Error')
    else:
        return response(401, 'User Not Found:::: Try Again')

# lambda_handler({
#     'body' : {
#         'email' : 'cstanley@gmail.com',
#         'password' : 'root',
#         'date' : '2/20/2023',
#         }
#     },
#     None
# )
