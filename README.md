# DynamoDB-CI

DynamoDB Container to be used with CI environments.

The main idea of this container is to facilitate the utilization of DynamoDB Local in CI projects by offering one single container with DynamoDB and aws cli in it.

_This container is based in my container [jmtvms/dynamo-local](https://hub.docker.com/r/jmtvms/dynamodb-local/) wich is designed for development._ But different from the original container, in this one you cannot pass parameters to the DynamoDB inside, only commands to the aws cli.  
The commands my be local or even directly to amazon. To use this container do control the DynamoDB inside it, you just have to start it with the command you want to use, just like the example below.

```bash

docker run -d --rm -p 8000:8000 jmtvms/dynamodb-ci \
    aws dynamodb create-table \
    --table-name myTable \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --endpoint-url http://0.0.0.0:8000

```

Now, if you want to control assets outside this container, you can use it too. Just set the environment variables with your credentials and restart the container. But if you are planing on using this container just for the aws cli I recommend you try this one _[jmtvms/awscli](https://hub.docker.com/r/jmtvms/awscli/)_, it's lighter and may fit your needs.

## Environments variables

### AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION

If you want to use this containers aws cli to control other aws resources then from itself you can set this environment variables and use it freely to control whatever account you want. You can even have one container for each account.

### JAVA_OPTS

You can set options to the jvm running the DynamoDB adding them here. Be sure to know what you are doing or the DynamoDB may even not start. _This environment variable is inherited from the [jmtvms/dynamo-local](https://hub.docker.com/r/jmtvms/dynamodb-local/) container._