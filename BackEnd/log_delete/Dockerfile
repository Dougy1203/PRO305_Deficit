FROM public.ecr.aws/lambda/python:3.9
COPY log_delete.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
CMD [ "log_delete.lambda_handler" ]