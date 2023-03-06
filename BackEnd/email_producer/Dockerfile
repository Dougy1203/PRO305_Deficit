FROM public.ecr.aws/lambda/python:3.9
COPY email_producer.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
CMD [ "email_producer.lambda_handler" ]