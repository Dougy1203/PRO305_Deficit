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
    if(user and (user['password'] == request_body['password'])):
        try:
            table_logs = log_table.query(
                KeyConditionExpression=Key('email').eq(request_body['email'])
            )
            logs = table_logs['Items']
            log_data = logs[0]
            log_list = log_data['logs']

            if(len(log_list) == 0):
                print('new log')
                log = {
                    'fat' : request_body['log']['fat'],
                    'carb' : request_body['log']['carb'],   
                    'protein' : request_body['log']['protein'],
                    'calories' : request_body['log']['calories'],
                    'date' : request_body['log']['date']
                }

                log_list.append(log)

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
                return response(200, 'Log Updated')
            else:
                print('updating log with date')
                date_in_log_list = False
                print(log_list)
                for log in log_list:
                    print(log)
                    if(log['date'] == request_body['log']['date']):
                        date_in_log_list = True
                if(date_in_log_list):
                    for log in log_list:
                        if(log['date'] == request_body['log']['date']):
                            log['fat'] += request_body['log']['fat']
                            log['carb'] += request_body['log']['carb']
                            log['protein'] += request_body['log']['protein']
                            log['calories'] += request_body['log']['calories']
                            print(log)
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
                            return response(200, 'Log Updated')
                else:
                    print('add log to list')
                    log = {
                        'fat' : request_body['log']['fat'],
                        'carb' : request_body['log']['carb'],   
                        'protein' : request_body['log']['protein'],
                        'calories' : request_body['log']['calories'],
                        'date' : request_body['log']['date']
                    }

                    log_list.append(log)

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
                return response(200, 'Log Updated')
        except Exception as e:
            print(e)
            return response(500, '[ERROR] Internal Server Error')
    else:
        return response(401, 'User Not Found')

fat = int(20)
carb = int(15)
protein = int(20)
calories = int(300)

# log = lambda_handler({
#     'body' : {
#         'email' : 'Liamd1203@gmail.com',
#         'password' : 'root',
#         'log' : 
#             {
#             'fat' : fat,
#             'carb': carb,
#             'protein' : protein,
#             'calories' : calories,
#             'date' : '2/20/2023'
#             },
#         }
#     },
#     None
# )
# print(log)
