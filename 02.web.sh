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

    dnf install nginx -y &>> $LOGFILE
    validate $? "installing nginx"

    systemctl enable nginx &>> $LOGFILE
    validate $? "enableing nginx"

    systemctl start nginx &>> $LOGFILE
    validate $? "starting nginx"

    rm -rf /usr/share/nginx/html/* &>> $LOGFILE
    validate $? "removing nginx html files"

    curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
    validate $? "copying roboshop"

    cd /usr/share/nginx/html &>> $LOGFILE
    validate $? "changing directory"

    unzip -o /tmp/web.zip &>> $LOGFILE
    validate $? "unzipping"

    cp /home/centos/newrobo/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
    validate $? "copying config"

    systemctl restart nginx  &>> $LOGFILE
    validate $? "restarting nginx"

    fi






