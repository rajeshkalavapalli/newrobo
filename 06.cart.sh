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

    curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip
    validate $? "downloading"

    cd /app 
    validate $? "changing app director"

    unzip /tmp/cart.zip
    validate $? "unziping"

    cd /app 
    validate $? "changing app director"

    npm install 
    validate $? "installing dependency"

    cp /home/centos/newrobo/cart.service /etc/systemd/system/cart.service
    validate $? "copying service"

    systemctl daemon-reload &>> $LOGFILE
    validate $? "daemon-reloading"

    systemctl enable cart  &>> $LOGFILE
    validate $? "enableing  user"

    systemctl start cart &>> $LOGFILE
    validate $? "starting user"

    fi

