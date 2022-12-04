#!/bin/bash


path="/opt/weather/"

cd "${path}"

bash scripts/script01.sh 
bash scripts/script02.sh 
bash scripts/notification.sh
bash scripts/uploadToGithub.sh
