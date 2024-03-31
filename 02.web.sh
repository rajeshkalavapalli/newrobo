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

    dnf install nginx -y
    validate $? "installing nginx"

    systemctl enable nginx
    validate $? "enableing nginx"

    systemctl start nginx
    validate $? "starting nginx"

    rm -rf /usr/share/nginx/html/*
    validate $? "removing nginx html files"

    curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
    validate $? "copying roboshop"

    cd /usr/share/nginx/html
    validate $? "changing directory"

    unzip -o /tmp/web.zip
    validate $? "unzipping"

    systemctl restart nginx 
    validate $? "restarting nginx"

    fi






