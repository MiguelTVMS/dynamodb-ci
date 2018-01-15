# DynamoDB-CI

DynamoDB Container to be used with CI environments.

The main idea of this container is to facilitate the utilization of DynamoDB Local in CI projects by offering one single container with DynamoDB and aws cli.

With this container you can use de `CMD` to execute a startup command for a table creation to be used on a unit test.

Example:

```bash

docker run --name -p 8000:8000 jmtvms/dynamodb-ci aws dynamodb create-table --table-name myTable --attribute-definitions AttributeName=id,AttributeType=S --key-schema AttributeName=id,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --endpoint-url http://0.0.0.0:8000

```
