#!/bin/bash

#title           :docker_install.sh
#description     :This script will install and run docker engine.
#author		 :Abuharis_Salih
#date            :20200804
#version         :1.0    
#usage		 :bash docker_install.sh
#notes           :""
#bash_version    :4.4.20(1)-release

/usr/bin/clear

read_only SCRIPT_NAME="$(basename "$0")"

function log() {
    local -r message="$1"
    local -r timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo >&2 -e "${timestamp} [$SCRIPT_NAME] ${message}"
	}

function log_info() {
    local -r message="$1"
    log "INFO" "$message"
	}

#Update packages
sudo apt-get update -y

log_info "Uninstalling any Older docker versions..."

#Uninstall Old Versions of Docker
sudo apt-get remove docker docker-engine docker.io -y

log_info "Installing docker..."

#Install docker
sudo apt install docker.io -y
if [ $? = 0 ]
then
    log_info "Docker has been installed successfully"
else
    log_info "Failed: Check the dependencies."
    exit 1
fi

log_info "Starting docker"

#Start and Automate Docker
sudo systemctl start docker
sudo systemctl enable docker

#Display the docker version
docker --version

