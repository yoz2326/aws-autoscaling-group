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

# run terraform destroy -plan first
terraform plan -destroy .

if [ $? -eq 0 ]; then
  echo
  echo "################################################################################"
  echo -e $YELLOW
  echo "Terraform found no errors during destroy plan phase"
  echo "Continue with terraform destroy (choose 1 or 2 for your answer) ?"
  echo -e $NC
  echo
  select yn in "Yes" "No"; do
    case $yn in
      Yes )
        echo ;
        echo "################################################################################" ;
        echo -e $YELLOW ;
        echo "Running terraform destroy" ;
        echo -e $NC ;
        echo "################################################################################" ;
        echo ;
        terraform destroy . ;
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
