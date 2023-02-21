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

    try:
        table_logs = log_table.query(
            KeyConditionExpression=Key('email').eq(request_body['email'])
        )
        logs = table_logs["Items"]
        if(logs):
            print(f'There is already a Log for the Email: {request_body["email"]}')
            return{
                'body' : f'There is already a Log for the Email: {request_body["email"]}'
            }
        else:
            log_table.put_item(
                Item={
                    'email' : request_body['email'],
                    'logs' : json.dumps(request_body['logs'])
                },
            )
            print(f'Log Created with Email: {request_body["email"]}')
            
    except Exception as e:
        print(e)
        

# TODO add in password authentication.
log = lambda_handler({
    'body' : {
        'email' : 'cstanley@gmail.com',
        'password' : 'root',
        'logs' : [],
    }
    },
    None
    )
