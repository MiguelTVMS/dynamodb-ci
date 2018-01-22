#!/bin/sh

echo "Configuring container."

awsFolder="$HOME/.aws"

if [ -d "$awsFolder" ]; then
    echo "Directory '$awsFolder' already exists."
else
    echo "Creating '$awsFolder' directory."
    mkdir $awsFolder
fi

credFile="$awsFolder/credentials"

if [ -f "$credFile" ]; then
    echo "Deleting credentials file '$credFile'."
    rm $credFile
    echo "A new one will be created later."
fi

echo "Creating credentials file '$credFile'."
touch $credFile
echo "[default]" > $credFile
echo "aws_access_key_id=$AWS_ACCESS_KEY_ID" >> $credFile
echo "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" >> $credFile

confFile="$awsFolder/config"

if [ -f "$confFile" ]; then
    echo "Deleting configurations file '$confFile'."
    rm $confFile
    echo "A new one will be created later."
fi

echo "Creating configurations file '$confFile'."
touch $confFile
echo "[default]" > $confFile
echo "region=""$AWS_DEFAULT_REGION""" >> $confFile
echo "output=$OUTPUT" >> $confFile

logDir="/var/dynamodb-log"
logFile="$logDir/console.log"
mkdir $logDir

./start.sh --sharedDb > $logFile 2>&1 &
( tail -f -n0 $logFile & ) | grep -q "CorsParams:"

if [ "$#" -gt 0 ]; then

    echo "Executing command:" >> $logFile
    echo $@ >> $logFile
    echo "" >> $logFile
    eval $@ >> $logFile 2>&1 &

fi

tail -f $logFile