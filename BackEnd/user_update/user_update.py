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
        "body" : json.dumps(body),
    }

def lambda_handler(event, context):
    request_body = event['body']

    user = users_collection.find_one({'email' : request_body['email']})
    if(user and (user['password'] == request_body['password'])):
        try:
            updated_user = {
                'email' : request_body['email'],
                'firstName' : request_body['firstName'],
                'lastName' : request_body['lastName'],
                'password' : request_body['password'],
                'goal' : json.dumps(request_body['goal'])
            }
            users_collection.update_one({'email': request_body['email']}, {"$set" : updated_user}, upsert=False)
            response(200, f'User Updated with Email: {request_body["email"]}')
        except Exception as e:
            print(e)
            response(500, '[Error] Internal Server Error')
    else:
        response(401, '[Error] User Validation Error')

# lambda_handler({
#     'body' : {
#         'email' : 'rbrunney@gmail.com',
#         'firstName' : 'Rob',
#         'lastName' : 'Brunney',
#         'password' : 'root',
#         'goal' : {},
#         }
#     },
#     None
# )