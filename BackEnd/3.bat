::CREATING API
aws apigateway create-rest-api --name 'deficit' --region us-east-1
set /p api_id=Enter Returned ID:

aws apigateway get-resources --rest-api-id %api_id% --region us-east-1
set /p root_id=Enter Returned ID:

:: create init path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part init
set /p path_id=Enter Returned ID:
:: create log POST
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:init/invocations

:: create log path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part log
set /p path_id=Enter Returned ID:
:: create log POST
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:log_create/invocations
:: create log PUT
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method PUT --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method PUT --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:log_update/invocations
:: create log DELETE
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method DELETE --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method DELETE --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:log_delete/invocations
:: create log DELETE
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method DELETE --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method DELETE --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:log_delete/invocations

:: create logs path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part logs
set /p path_id=Enter Returned ID:
:: create logs POST (Get Logs)
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:log_read/invocations

:: create user path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part user
set /p path_id=Enter Returned ID:
:: create user POST
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:user_create/invocations
:: create user PUT
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method PUT --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method PUT --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:user_update/invocations
:: create user DELETE
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method DELETE --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method DELETE --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:user_delete/invocations

:: create login path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part login
set /p path_id=Enter Returned ID:
:: create login POST
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:user_login/invocations

:: create email path
aws apigateway create-resource --rest-api-id %api_id% --region us-east-1 --parent-id %root_id% --path-part email
set /p path_id=Enter Returned ID:
:: create email POST
aws apigateway put-method --rest-api-id %api_id% --region us-east-1 --resource-id %path_id% --http-method POST --authorization-type "NONE"
aws apigateway put-integration --region us-east-1 --rest-api-id %api_id% --resource-id %path_id% --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:803626219445:function:email/invocations
