#!/bin/bash


path="/opt/weather/"

cd "${path}"

bash scripts/script01.sh 
bash scripts/script02.sh 
# This script is executed on the fly
# bash scripts/script03.sh 
bash scripts/notification.sh
bash scripts/uploadToGithub.sh
