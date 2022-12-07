#!/bin/bash


path="/opt/weather/"

if ! [ -d "/opt/weather/.git" ]; then

    sudo git init

    # git config --global user.name "Hannah Sofie"
    # git config --global user.email "Hannah-Sofie@live.no"
    # sudo git config --global user.password "<token>"
    # access token = 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
    
    # github token works only one time
    # script needs push the code automatically
    # have to store the user and password to avoid write
    # them when git command ask for the credentials, so I use
    # git config user.name ""
    # git config user.email ""
    # git config user.password ""
    
    # didn't want to change the global values
    # but if I don't add "--global" on the commands this data
    # is saved on .git directory and when "push" is done
    # these values are also pushed. And if github detect
    # on the repositories, automatically are revoked.
    
    sudo git config credential.helper store

    sudo git remote add origin "https://github.com/Hannah-Sofie/weather.git"
fi

cd "${path}"

sudo git add .

sudo git commit -m "Changes at $(date)"

sudo git push origin master
