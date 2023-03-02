import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
from pymongo import MongoClient
from dotenv import load_dotenv
import rsa

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
            users_collection.delete_one(user)
            return response(200, f'User Deleted with Email: {request_body["email"]}')
        except Exception as e:
            print(e)
            return response(500, '[Error] Internal Server Error')
    else:
        return response(401, '[Error] User Validation Error')

# lambda_handler({
#     'body' : {
#         'email' : 'cstanley@gmail.com',
#         'password' : 'root'
#         }
#     },
#     None
# )