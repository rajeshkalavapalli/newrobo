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

    mkdir /app &>> $LOGFILE
    validate $? "creating app director"

    curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE
    validate $? "copying resource" 

    cd /app  &>> $LOGFILE
    validate $? "changing to app director"

    unzip -o /tmp/catalogue.zip &>> $LOGFILE
    validate $? "unziping"

    cd /app &>> $LOGFILE
    validate $? "changing to app director"

    npm install &>> $LOGFILE
    validate $? "installig depencency"

    cp /home/centos/newrobo/catalogue.service /etc/systemd/system/catalogue.service &>> $LOGFILE
    validate $? "copying server file"

    systemctl daemon-reload &>> $LOGFILE
    validate $? "daemon-reloading"

    systemctl enable catalogue &>> $LOGFILE
    validate $? "enableing catalogue"

    systemctl start catalogue &>> $LOGFILE
    validate $? "starting catalogue"

    cp /home/centos/newrobo/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
    validate $? "copying mango.repo" 

    dnf install mongodb-org-shell -y &>> $LOGFILE
    validate $? "installing catalogue"

    mongo --host mongodb.bigmatrix.in </app/schema/catalogue.js &>> $LOGFILE
    validate $? "loading catalogue"

    fi








