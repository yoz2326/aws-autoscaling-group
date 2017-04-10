#!/bin/bash

# define colors
NC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'

# set aws creds
. ./secrets/aws/creds.sh

cd ./terraform

# configure remote terraform state
. ./files/remote-state.sh

# set my_public_ip antry in terraform.tfvars
. ./files/set_my_public_ip.sh

# run terraform plan first
terraform plan .

if [ $? -eq 0 ]; then
  echo
  echo "################################################################################"
  echo -e $YELLOW
  echo "Terraform found no errors during planning phase"
  echo "Continue with terraform apply (choose 1 or 2 for your answer) ?"
  echo -e $NC
  echo
  select yn in "Yes" "No"; do
    case $yn in
      Yes )
        echo ;
        echo "################################################################################" ;
        echo -e $YELLOW ;
        echo "Running terraform apply" ;
        echo -e $NC ;
        echo "################################################################################" ;
        echo ;
        terraform apply . ;
        terraform remote push ;
        break ;;
      No )
        echo
        echo "exit"
        exit ;;
    esac
  done
fi

# clear AWS creds
cd ../ && . ./secrets/aws/unset-creds.sh
