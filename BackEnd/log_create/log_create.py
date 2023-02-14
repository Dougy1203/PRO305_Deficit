import json
import boto3
from boto3.dynamodb.conditions import Key
import os
from os import getenv
from uuid import uuid4
import pymongo
from pymongo import MongoClient
from dotenv import load_dotenv

# load_dotenv(dotenv_path='./.env')
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
myclient = MongoClient(MONGO_STRING)
myclient.server_info()
mydb = myclient["Deficit"]
mycol = mydb["Users"]
x = mycol.insert_one({"user_name":"Soumi"})
print(x.inserted_id)

tables = list(dynamo_client.tables.all())
print(tables)
# performer_table = dynamo_client.Table("performers")

def lambda_handler(event, context):
    request_body = event['body']
    try:
        print('my bed... right now')
        print(request_body)
    except Exception as e:
        print(e)

performer = lambda_handler({
    'body' : 'hello world'
    },
    None
    )
