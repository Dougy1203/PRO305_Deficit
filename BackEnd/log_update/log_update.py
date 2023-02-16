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
        table_logs = log_table.query(
            KeyConditionExpression=Key('email').eq(request_body['email'])
        )
        logs = table_logs['Items']
        log_data = logs[0]
        log_list = log_data['logs']

        # print(len(log_list))

        for log in log_list:
            if(log is None):
                print('log is empty')
            else:
                print('Adding to log')
        
        if(logs):

            log = {
                'fat' : request_body['log']['fat'],
                'carb' : request_body['log']['carb'],   
                'protein' : request_body['log']['protein'],
                'calories' : request_body['log']['calories'],
                'date' : current_date
            }

            log_list.append(json.dumps(log))
            print(log_list)
            return{
                'body' : f'There is already a Log for the Email: {request_body["email"]}'
            }
        else:
            print(f'There are no logs associated with that email.')
            
    except Exception as e:
        print(e)

# TODO add in password authentication once based logic works
log = lambda_handler({
    'body' : {
        'email' : 'cstanley@gmail.com',
        'password' : 'root',
        'log' : 
            {
            'fat' : 20,
            'carb': 15,
            'protein' : 20,
            'calories' : 300
            },
    }
    },
    None
    )
