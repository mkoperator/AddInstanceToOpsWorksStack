#!/bin/bash
apt-get install python2.7 -y
wget https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
sed -i'' -e 's/.*requiretty.*//' /etc/sudoers
pip install --upgrade awscli
INSTANCE_ID=$(/usr/local/bin/aws opsworks register --use-instance-profile --infrastructure-class ec2 --region {REGION} --stack-id {STACKID} --override-hostname $(tr -cd 'a-z' < /dev/urandom |head -c8) --local 2>&1 |grep -o 'Instance ID: .*' |cut -d' ' -f3)
/usr/local/bin/aws opsworks wait instance-registered --region us-east-1 --instance-id $INSTANCE_ID
/usr/local/bin/aws opsworks assign-instance --region us-east-1 --instance-id $INSTANCE_ID --layer-ids {LAYERID}

