import json
import boto3
import os
from os import getenv
from uuid import uuid4
import pymongo
from pymongo import MongoClient
from dotenv import load_dotenv
from datetime import datetime
import smtplib, ssl

load_dotenv()

MS = os.getenv('MCS')
AAK = os.getenv('AAK')
ASAK = os.getenv('ASAK')
AEU = os.getenv('AEU')
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SE = os.getenv('SE')
SP = os.getenv('SP')

context = ssl.create_default_context()

sqs = boto3.resource(
    'sqs',
    aws_access_key_id= AAK,
    aws_secret_access_key= ASAK,
    endpoint_url= AEU)

sqs_queue = sqs.get_queue_by_name(QueueName='deficit_queue.fifo')

def lambda_handler(event, context):
    request_body = event['body']
    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls(context=context)
        server.login(SE, SP)
        while True:
            messages = sqs_queue.receive_messages()
            for message in messages:
                msg = json.loads(message.body)
                email = msg['email']
                content = msg['message']
                print(email)
                print(content)
                server.sendmail(SE, email, content)
                message.delete()
    except Exception as e:
        print('exception')
        print(e)


if __name__ == "__main__":
    lambda_handler({
        'body' : {}
        },
        None
        )


# {
#     "body" : {
#         "email" : "liamd1203@gmail.com",
#         "password" : "root"
#     }
# }