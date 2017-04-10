#!/bin/bash

my_public_ip=$(dig TXT  +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '\"')

sed -i '/extra_ssh_hosts/c\extra_ssh_hosts='\"${my_public_ip}\/32\"'' terraform.tfvars
