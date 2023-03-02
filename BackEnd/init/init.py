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
users_collection.drop()
deficit_table.create_collection('Users')
users_collection = deficit_table['Users']


def lambda_handler(event, context):
    request_body = event['body']
    try:
        liam = 'liamd1203@gmail.com'
        chris = 'cstanley@gmail.com'

        # current_time = datetime.now()
        # current_date = f'{current_time.month}/{current_time.day}/{current_time.year}'

        # print(current_date)

        users_collection.insert_one({'email' : liam, 'password' : 'root', 'firstName' : 'Liam', 'lastName' : 'Douglas', 'goal' : json.dumps({})})
        users_collection.insert_one({'email' : chris, 'password' : 'root', 'firstName' : 'Christopher', 'lastName' : 'Stanley', 'goal' : json.dumps({})})

        liam_logs = log_table.query(
            KeyConditionExpression=Key('email').eq(liam)
        )
        liam_log = liam_logs["Items"]
        if(liam_log):
            print(f'User with email: {liam} already exists')
            return{
                'body' : f'User with email: {liam} already exists'
            }
        else:
            log_table.put_item(
                Item={
                    'email' : liam,
                    'logs' : []
                },
            )

        chris_logs = log_table.query(
            KeyConditionExpression=Key('email').eq(chris)
        )
        chris_log = chris_logs["Items"]
        if(chris_log):
            print(f'User with email: {chris} already exists')
            return{
                'body' : f'User with email: {chris} already exists'
            }
        else:
            log_table.put_item(
                Item={
                    'email' : chris,
                    'logs' : []
                },
            )
    except Exception as e:
        print(e)

# lambda_handler({
#     'body' : {}
#     },
#     None
#     )
