#!/bin/bash

# tell the shell to use the bash interpreter so we don't run into compatability issues.

#check if root user
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

#Install OpenSSH Server, a connectivity tool for remote login with SSH protocol. 
# -y answers all prompts with yes 
apt-get install openssh-server -y

# Change the port inside the sshd_config file from the default 22 to 50000
# Ports 0 - 1023 are reserved by Internet Assigned Numbers Authority
# Registered Ports 1024 - 49151 should also be avoided. 
# Dynamic and/or Private Ports are 49152 - 65535.

# sed . means any single character. 
# The * means wildcard zero or more (to cover whatever port# it could be)

#-i.bak to create a backup file before editing for safety.
sed -i.bak 's/Port.*/Port 50000/' /etc/ssh/sshd_config

#Restart SSH service and it will swap to the new port.
/etc/init.d/ssh restart

echo "SSH Port Number changed to 50000"