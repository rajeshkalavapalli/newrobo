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

    dnf module disable nodejs -y &>> $LOGFILE
    validate $? "disable nodejs"

    dnf module enable nodejs:18 -y &>> $LOGFILE
    validate $? "enableing nodejs"

    dnf install nodejs -y &>> $LOGFILE
    validate $? "instaling nodejs"

    useradd roboshop &>> $LOGFILE
    validate $? "user adding"

    mkdir -p /app &>> $LOGFILE
    validate $? "creating app director"

    curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE
    validate $? "downloading code"

    cd /app  &>> $LOGFILE
    validate $? "changing to app directory"

    unzip -o /tmp/user.zip &>> $LOGFILE
    validate $? "unzipping"

    cd /app  &>> $LOGFILE
    validate $? "changing to app directory"

    npm install  &>> $LOGFILE
    validate $? "installing dependencys"

    Cp /home/centos/newrobo /etc/systemd/system/user.service
    validate $? "copying user service"

    systemctl daemon-reload &>> $LOGFILE
    validate $? "daemon-reloading"

    systemctl enable user  &>> $LOGFILE
    validate $? "enableing  user"

    systemctl start user &>> $LOGFILE
    validate $? "starting user"

    cp /home/centos/newrobo/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
    validate $? "copying mango.repo" 

    dnf install mongodb-org-shell -y &>> $LOGFILE
    validate $? "installing catalogue"

    mongo --host mongodb.bigmatrix.in </app/schema/user.js &>> $LOGFILE
    validate $? "starting user"

    fi








