#!/bin/bash 

ID=$(id -u)

TIMESTAMP=$(date +%F-%M-%S)
LOGFILE=/tmp/$0-$TIMESTAMP.log 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate(){

    if [ $1 -ne  0 ]
    then 
        echo -e "$2...........$R faild $N"
    else 
        echo  -e "$2............$G success $N"
    fi
}


    if [ $ID -ne 0 ]
    then 
        echo -e  "$R you're not a root user $N"
        exit 1
    else 
        echo -e "$G you're a root user $N"
    

    cp /home/centos/newrobo/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
    validate $? "copying mango.repo" 

    dnf install mongodb-org -y  &>> $LOGFILE
    validate $? "installing mongo-shell"

    systemctl enable mongod &>> $LOGFILE
    validate $? "enable mongod"

    systemctl start mongod &>> $LOGFILE
    validate $? "starting mongod"

    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGFILE
    validate $? "remote access"

    systemctl restart mongod &>> $LOGFILE
    validate $? "restart mongod"

    fi




