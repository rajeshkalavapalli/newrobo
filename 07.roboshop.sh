#!/bin/bash

AMI="ami-0f3c7d07486cad139"
SE_ID="sg-0ecc0d38b1974ad3f"

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "cart" "user" "shipping" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do
    echo "instance is: $i"
    if [ "$i" == "mongodb" ] || [ "$i" == "mysql" ] || [ "$i" == "redis" ]
    then 
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    
    aws ec2 run-instances --image-id ami-0f3c7d07486cad139 --instance-type $INSTANCE_TYPE --security-group-ids sg-0ecc0d38b1974ad3f  

done
