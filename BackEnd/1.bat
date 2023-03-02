:: check if connection is valid with login success
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310

:: docker-compose
docker compose up -d

:: create AWS ECR Repository
aws ecr create-repository --repository-name sen310 --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

:: tags and pushes to ecr
docker tag email_service:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:email
docker tag init:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:init
docker tag log_create:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_create
docker tag log_delete:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_delete
docker tag log_read:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_read
docker tag log_update:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_update
docker tag user_create:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_create
docker tag user_delete:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_delete
docker tag user_login:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_login
docker tag user_update:1.0 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_update
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:email
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:init
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_create
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_delete
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_read
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:log_update
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_create
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_delete
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_login
docker push 803626219445.dkr.ecr.us-east-1.amazonaws.com/sen310:user_update
pause