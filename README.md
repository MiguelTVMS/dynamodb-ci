# DynamoDB-CI

DynamoDB Container to be used with CI environments.

The main idea of this container is to facilitate the utilization of DynamoDB Local in CI projects by offering one single container with DynamoDB and aws cli in it.

In this container I didn't use the `CMD` on the docker file so you can for example start it with a command of your own for creating a table of unit tests just like the example below.

```bash

docker run -d --rm -p 8000:8000 jmtvms/dynamodb-ci \
    aws dynamodb create-table \
    --table-name myTable \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --endpoint-url http://0.0.0.0:8000

```
## Environments variables

### **AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY** and **AWS_DEFAULT_REGION**

If you want to use this containers aws cli to control other aws resources then from itself you can set this environment variables and use it freely to control whatever account you want. You can even have one container for each account.

### **JAVA_OPTS**

You can set options to the jvm running the DynamoDB adding them here. Be sure to know what you are doing or the DynamoDB may even not start.

### **PORT**

You can change the port wich DynamoDB service is running inside the container. I doubt anyone wants to mess with that since you can map the port on the host running the container but I'm really adept of flexibility...