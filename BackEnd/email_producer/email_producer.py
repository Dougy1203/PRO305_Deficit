import boto3
import os
from os import getenv

AAK = os.getenv('AAK')
ASAK = os.getenv('ASAK')
AEU = os.getenv('AEU')

sqs = boto3.resource(
    'sqs',
    aws_access_key_id= AAK,
    aws_secret_access_key= ASAK,
    endpoint_url= AEU)

sqs_queue = sqs.get_queue_by_name(QueueName='deficit_queue.fifo')

def lambda_handler(message_body, message_attributes=None):

    if not message_attributes:
        message_attributes = {}

        try:
            response = sqs_queue.send_message(
                MessageBody = message_body,
                MessageAttributes = message_attributes
            )

            return 'Message sent'
        except :
            return 'Send message failed.'
    else:
        return response
    
result = lambda_handler(
    "Testing if it is working"
)

print(result)