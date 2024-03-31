#!/bin/bash 

ID=$(id-u)

TIMESTAMP=$(date +%F-%M-%S)
LOGFILE=/tmp/$0-$TIMESTAMP.log 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate()[

    if [ $1 -ne  0 ]
    then 
        echo "$2...........$R faild $N"
    else 
        echo "$2............$G success $N"
    fi
]


    if [ $ID -ne 0 ]
    then 
        echo "$R you're not a root user $N"
    else 
        echo "$G you're a root user $N"
    fi

    cp 
    dnf install mongodb-org -y 
    validate $? "installing mongo-shell"


