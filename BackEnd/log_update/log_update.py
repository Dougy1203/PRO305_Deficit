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

log_table = dynamo_client.Table("Log")

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
        logs = table_logs['Items']
        log_data = logs[0]
        log_list = log_data['logs']

        #print('log list length:')
        #print(len(log_list))
        print(log_list)
        
        if(len(log_list) == 0):

            log = {
                'fat' : request_body['log']['fat'],
                'carb' : request_body['log']['carb'],   
                'protein' : request_body['log']['protein'],
                'calories' : request_body['log']['calories'],
                'date' : request_body['log']['date']
            }

            log_list.append(log)
            #print(log_list)

            log_table.update_item(
                Key={
                    'email' : request_body['email']
                },
                UpdateExpression= "SET #ts= :val1",
                ExpressionAttributeValues={
                    ':val1' : log_list
                },
                ExpressionAttributeNames={
                    '#ts' : 'logs'
                }
            )
            print('Log updated.')
        else:
            for log in log_list:
                #print(log)
                if(log['date'] == request_body['log']['date']):
                    print('adding to log')

                    log['fat'] += request_body['log']['fat']
                    log['carb'] += request_body['log']['carb']
                    log['protein'] += request_body['log']['protein']
                    log['calories'] += request_body['log']['calories']

                    log_table.update_item(
                        Key={
                            'email' : request_body['email']
                        },
                        UpdateExpression= "SET #ts= :val1",
                        ExpressionAttributeValues={
                            ':val1' : log_list
                        },
                        ExpressionAttributeNames={
                            '#ts' : 'logs'
                        }
                    )

            print('Creating new log')
            log = {
                'fat' : request_body['log']['fat'],
                'carb' : request_body['log']['carb'],   
                'protein' : request_body['log']['protein'],
                'calories' : request_body['log']['calories'],
                'date' : request_body['log']['date']
            }

            log_list.append(log)
            #print(log_list)

            log_table.update_item(
                Key={
                    'email' : request_body['email']
                },
                UpdateExpression= "SET #ts= :val1",
                ExpressionAttributeValues={
                    ':val1' : log_list
                },
                ExpressionAttributeNames={
                    '#ts' : 'logs'
                }
            )
            print('Log updated.')
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
            'calories' : 300,
            'date' : '2/20/2023'
            },
    }
    },
    None
    )
