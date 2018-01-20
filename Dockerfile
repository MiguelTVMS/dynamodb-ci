FROM jmtvms/dynamodb-local:stable

LABEL maintainer="joao@miguel.ms"
LABEL description="DynamoDB Container to be used with CI environments"
LABEL repository="https://github.com/jmtvms/dynamodb-ci.git"
LABEL bugs="https://github.com/jmtvms/dynamodb-ci/issues"
LABEL github="https://github.com/jmtvms/dynamodb-ci"
LABEL version="1.0.0"

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""

# Installing AWS Cli
RUN apt-get update
RUN apt-get install python-pip -y
RUN pip install awscli --upgrade
RUN apt-get autoremove -y
RUN apt-get clean -y