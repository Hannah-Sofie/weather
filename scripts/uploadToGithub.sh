#!/bin/bash

if ! [ -d "/opt/weather/.git" ]; then

    git init

    git config --global user.name "Hannah Sofie"
    git config --global user.email "Hannah-Sofie@live.no"
    git config --global user.password "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"
    # H@nnah2022
    git config credential.helper store

    git remote add origin "https://github.com/Hannah-Sofie/Weather.git"
fi


git add .

git commit -m "Changes at $(date)"

git push origin master