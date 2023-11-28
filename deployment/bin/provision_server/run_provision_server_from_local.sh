#!/bin/bash

set -ex

SSH_USER=$1
SERVER_IP=$2
MYSQL_PASSWORD=$3

PUBLIC_SSH_KEY=$(cat $HOME/.ssh/id_rsa.pub)

scp -C -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa $SSH_USER@$SERVER_IP:~/.ssh/id_rsa
ssh -tt -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa $SSH_USER@$SERVER_IP "sudo ssh-keyscan github.com >> ~/.ssh/known_hosts"

scp -C -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa ./provision_server.sh $SSH_USER@$SERVER_IP:./provision_server.sh
ssh -tt -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa $SSH_USER@$SERVER_IP "sudo chmod +x ./provision_server.sh && ./provision_server.sh $MYSQL_PASSWORD \"$PUBLIC_SSH_KEY\""
ssh -tt -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa $SSH_USER@$SERVER_IP "sudo ssh-keyscan github.com >> /home/mhd/.ssh/known_hosts"
