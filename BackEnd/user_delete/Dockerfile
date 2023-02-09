FROM public.ecr.aws/lambda/python:3.9
COPY user_delete.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
CMD [ "user_delete.lambda_handler" ]