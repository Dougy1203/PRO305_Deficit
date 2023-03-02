import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
from pymongo import MongoClient
from dotenv import load_dotenv

load_dotenv()

MS = os.getenv('MCS')

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
        return response(200, 'Logged In')
    else:
        return response(401, 'Log In Failed')

# lo = lambda_handler({
#     'body' : {
#         'email' : 'liamd1203@gmail.com',
#         'password' : 'root',
#         }
#     },
#     None
# )

# print(lo)