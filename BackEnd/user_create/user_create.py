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
    if(user is None):
        try:
            new_user = {
                'email' : request_body['email'],
                'firstName' : request_body['firstName'],
                'lastName' : request_body['lastName'],
                'password' : request_body['password'],
                'goal' : json.dumps(request_body['goal'])
            }

            users_collection.insert_one(new_user)
            response(200, 'User Created')
        except Exception as e:
            print(e)
            response(500, '[ERROR] Internal Server Error')
    else:
        response(401, f'User Already Exists with Email: {request_body["email"]}')

# lambda_handler({
#     'body' : {
#         'email' : 'rbrunney@gmail.com',
#         'firstName' : 'Robert',
#         'lastName' : 'Brunney',
#         'password' : 'root',
#         'goal' : {},
#         }
#     },
#     None
# )