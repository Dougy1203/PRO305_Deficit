import json
import boto3
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
AWS_ENDPOINT_URL = os.getenv('AWS_ENDPOINT_URL')

print(AWS_ENDPOINT_URL)

sqs = boto3.resource(
    'sqs',
    aws_access_key_id= AWS_ACCESS_KEY,
    aws_secret_access_key= AWS_SECRET_ACCESS_KEY,
    endpoint_url= AWS_ENDPOINT_URL)

sqs_queue = sqs.get_queue_by_name(QueueName='deficit_queue.fifo')

def send_email(message):
    print(message)

def lambda_handler(event, context):
    request_body = event['body']
    try:
        if __name__ == '__main__':
            while True:
                messages = sqs_queue.receive_messages()
                for message in messages:
                    send_email(message.body)
                    message.delete()
    except Exception as e:
        print(e)

lambda_handler({
    'body' : {}
    },
    None
    )
