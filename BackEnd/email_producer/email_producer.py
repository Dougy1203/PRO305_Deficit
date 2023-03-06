import boto3
import json
import os
import random

sqs = boto3.client('sqs')

def response(status_code, body):
    return {
        "statusCode" : status_code,
        "headers" : {
            "Content-Type" : 'application/json'
        },
        "body" : json.dumps({'message' : body}),
    }

def lambda_handler(event, context):
    body = event['body']
    res = {"email" : body['email'], 'message' : body['message']}
    message = sqs.send_message(
        QueueUrl='https://sqs.us-east-1.amazonaws.com/278029930798/deficit_queue.fifo',
        MessageBody= json.dumps(res),
        MessageDeduplicationId=str(random.random()),
        MessageGroupId=str(random.random())
    )
    return response(200, "Message Send")
    

# lambda_handler(
#     {
#         "body" : {
#             "email" : "liamd1203@gmail.com",
#             "message" : "this is a message again"
#         }
#     }, None
# )