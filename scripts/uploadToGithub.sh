#!/bin/bash

#!/bin/bash

git init


git config user.name "Hannah Sofie"
git config user.email "Hannah-Sofie@live.no"
git config user.password "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"

git config credential.helper store


git remote add origin "https://github.com/Hannah-Sofie/Weather.git"

git add .

git commit -m "Changes at $(date)"

git push origin master