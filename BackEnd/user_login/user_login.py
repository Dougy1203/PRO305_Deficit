import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
from pymongo import MongoClient
from dotenv import load_dotenv

load_dotenv()

MONGO_STRING = os.getenv('MONGO_CONNECTION_STRING')

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
        response(200, 'Logged In')
    else:
        response(401, 'Log In Failed')

# lambda_handler({
#     'body' : {
#         'email' : 'liamd1203@gmail.com',
#         'password' : 'root',
#         }
#     },
#     None
# )