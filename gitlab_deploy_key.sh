#!/bin/bash

# Variables
SERVER=''
GITLAB_REPO=''
KEY=''
KEY_PATH="$HOME/.ssh/$KEY"

# Generate Key
ssh-keygen -t rsa
eval $(ssh-agent -s)
ssh-add $KEY_PATH

# Configure SSH
cd ~/.ssh/
if ! test -f config; then
    touch config
fi
cat <<EOF >> config

# GitLab.com server
Host $SERVER
RSAAuthentication yes
IdentityFile $KEY_PATH
EOF
cd /var/www/webprod/
git remote set-url origin git@$SERVER:$GITLAB_REPO