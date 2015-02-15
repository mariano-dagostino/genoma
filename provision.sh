#!/bin/sh

ansible-playbook ansible/ansible.yml --private-key=~/.vagrant.d/insecure_private_key -i ansible/hosts
