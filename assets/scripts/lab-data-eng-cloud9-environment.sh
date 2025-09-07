#! /bin/bash

aws cloud9 create-environment-ec2 \
    --name data-eng-aula-$(date +%Y-%m-%d-%H-%M) \
    --description "Ambiente Cloud9 com Ubuntu 22.04 e m5.large para engenharia de dados." \
    --instance-type m5.large \
    --image-id ubuntu-22.04-x86_64 \
    --automatic-stop-time-minutes 60 \
    --connection-type CONNECT_SSH


