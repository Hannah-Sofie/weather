#!/bin/bash

if ! [ -d "/opt/weather/.git" ]; then

    git init

    git config user.name "Hannah Sofie"
    git config user.email "Hannah-Sofie@live.no"
    git config user.password "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"
    # H@nnah2022
    git config credential.helper store

    git remote add origin "https://github.com/Hannah-Sofie/Weather.git"
fi


git add .

git commit -m "Changes at $(date)"

git push origin master