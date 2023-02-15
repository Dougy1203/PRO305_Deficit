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

    try:
        print(request_body)
    except Exception as e:
        print(e)

# TODO add in password authentication once based logic works
performer = lambda_handler({
    'body' : {
        'email' : 'cstanley@gmail.com',
        'log' : [
            {
            'fat' : 20,
            'carb': 15,
            'protein' : 20,
            'calories' : 300
            },
        ],
    }
    },
    None
    )
