#!/bin/bash


path="/opt/weather/"

if ! [ -d "/opt/weather/.git" ]; then

    sudo git init

    # git config --global user.name "Hannah Sofie"
    # git config --global user.email "Hannah-Sofie@live.no"
    
    # H@nnah2022
    sudo git config credential.helper store

    sudo git remote add origin "https://github.com/Hannah-Sofie/weather.git"
fi

cd "${path}"

sudo git add .

sudo git commit -m "Changes at $(date)"

sudo git push origin master