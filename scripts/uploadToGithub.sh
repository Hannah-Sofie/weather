#!/bin/bash


path="/opt/weather/"

if ! [ -d "/opt/weather/.git" ]; then

    git init

    # git config --global user.name "Hannah Sofie"
    # git config --global user.email "Hannah-Sofie@live.no"
    
    # H@nnah2022
    git config credential.helper store

    git remote add origin "https://github.com/Hannah-Sofie/weather.git"
fi

cd "${path}"

git add .

git commit -m "Changes at $(date)"

git push origin master