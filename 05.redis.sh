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

        dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
        validate $? "installig redis repo"

        dnf module enable redis:remi-6.2 -y &>> $LOGFILE
        validate $? "enable  redis repo"

        dnf install redis -y &>> $LOGFILE
        validate $? "installin  redis "

        sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf &>> $LOGFILE
        validate $? "remote acces redis"

        systemctl enable redis &>> $LOGFILE
        validate $? "enable  redis "

        systemctl start redis &>> $LOGFILE
        validate $? "start redis "

        fi


    