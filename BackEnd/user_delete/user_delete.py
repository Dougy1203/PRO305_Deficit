import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
from pymongo import MongoClient
from dotenv import load_dotenv
import rsa

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
            users_collection.delete_one(user)

            return {
                'body' : 'User deleted.'
            }
        except Exception as e:
            print(e)
    else:
        return {
            'body' : 'Validation failed try again.'
        }

user = lambda_handler({
    'body' : {
        'email' : 'cstanley@gmail.com',
        'password' : 'root'
    }
    },
    None
    )
print(user)