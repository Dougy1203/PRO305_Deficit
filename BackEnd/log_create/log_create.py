import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
import pymongo
from pymongo import MongoClient
from dotenv import load_dotenv
from datetime import datetime

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

    current_time = datetime.now()
    current_date = f'{current_time.month}/{current_time.day}/{current_time.year}'

    table_logs = log_table.query(
        KeyConditionExpression=Key('email').eq(request_body['email'])
    )
    logs = table_logs["Items"]

    print(logs)
    try:
        #print(request_body)
        if(logs):
            print('There is already a log for that email.')
        else:
            log_table.put_item(
                Item={
                    'email' : request_body['email'],
                    'logs' : request_body['logs']
                },
            )
            print('Log created.')
    except Exception as e:
        print(e)

log = lambda_handler({
    'body' : {
        'email' : 'cstanley@gmail.com',
        'logs' : [],
    }
    },
    None
    )
