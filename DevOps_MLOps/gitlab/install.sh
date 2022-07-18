#!/bin/sh
# https://about.gitlab.com/install/#ubuntu

sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
sudo apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get update
GITLAB_ROOT_PASSWORD='secretsecret'
sudo EXTERNAL_URL="http://localhost:8880" apt-get -y install gitlab-ce
sudo apt-get install gitlab-runner