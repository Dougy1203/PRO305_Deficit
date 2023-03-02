:: Create API Gateway
aws apigateway create-rest-api --name 'deficit' --region us-east-1
:: NOTE THE ID THIS GIVES YOU// USED IN NEXT COMMAND
set /p api_id=Enter Returned ID:

:: Get Resources of API to get root resource id
aws apigateway get-resources --rest-api-id %api_id% --region us-east-1
:: NOTE THE ID THIS ONE GIVES YOU TOO
set /p root_id=Enter Returned ID:
set /p resource1=Enter init:

:: Create Resource on root
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part %resource1%
set /p resource1_id=Enter Returned ID:

set /p method=What HTTP Method (GET, POST, PUT, DELETE):
::Create an HTTP Method on Resource
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %resource1_id% --http-method %method% --authorization-type "NONE"

::Which Lambda would you like to Invocate
set /p lambda=ENTER init:

:: Connect to Lambda
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %resource1_id% --http-method %method% --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:%lambda%/invocations
pause
::TUTORIAL END