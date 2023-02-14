import json
import boto3
from boto3.dynamodb.conditions import Key
from os import getenv
from uuid import uuid4
import pymongo

region_name = getenv('APP_REGION')

performers_table = boto3.resource(
    'dynamodb',
    region_name=region_name
    ).Table('Performers')

def lambda_handler(event, context):
    request_body = json.loads(event['body'])

    try:
        response = performers_table.query(
            KeyConditionExpression=Key('email_address').eq(request_body['email_address'])
        )
        items = response['Items']
        email = request_body['email_address']

        if(items):
            return request_response(400, {'message' : f'Performer with "{email}" already exists'})
        else:
            performers_table.put_item(
                Item={
                    'Id' : str(uuid4()),
                    "name" : request_body["name"],
                    "email_address" : request_body["email_address"],
                    "phone_number" : request_body["phone_number"],
                    "role" : request_body["role"],
                    "password" : request_body['password'],
                    "performances_participated_in" : json.dumps(request_body["performances_participated_in"]),
                    "performances_currently_in" : request_body["performances_currently_in"]
            })

        return request_response(200, {'message' : 'Performer created!'})
    except Exception as e:
        print(e)
        return request_response(400, {'message' : 'Could not create performer.'})

def request_response(status_code, body):
    return {
        "statusCode" : status_code,
        "headers" : {
            "Content-Type" : "application/json"
        },
        "body" : json.dumps(body)
    }

# performer = lambda_handler({
#     'body' : {
        # 'name' : 'Robert Brunney',
        # 'email_address' : 'hisbedrightnow@gmail.com',
        # 'phone_number' : '865-234-2947',
        # 'password' : 'pwd123',
        # 'role' : 'performer',
        # 'performances_participated_in' : [],
        # 'performances_currently_in' : ''
#     }},
#     None
#     )

# print(performer)
