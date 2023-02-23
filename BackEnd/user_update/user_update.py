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
# x = users_collection.insert_one({"user_name":"Soumi"})
# print(x.inserted_id)

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

            return {
                'body' : 'User updated.'
            }
        except Exception as e:
            print(e)
    else:
        return {
            'body' : 'Validation failed try again.'
        }

user = lambda_handler({
    'body' : {
        'email' : 'rbrunney@gmail.com',
        'firstName' : 'Rob',
        'lastName' : 'Brunney',
        'password' : 'root',
        'goal' : {},
    }
    },
    None
    )

print(user)