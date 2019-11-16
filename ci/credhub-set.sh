#!/bin/bash
set -eu pipefail

#AWS Credentials
#WARNING: Cannot handle multi definition
AWS_DEFAULT_REGION=`cat ~/.aws/credentials | grep "aws_default_region" | awk -F'aws_default_region=' '{print $2}'`
AWS_ACCESS_KEY_ID=`cat ~/.aws/credentials | grep "aws_access_key_id" | awk -F'aws_access_key_id=' '{print $2}'`
AWS_SECRET_ACCESS_KEY=`cat ~/.aws/credentials | grep "aws_secret_access_key" | awk -F'aws_secret_access_key=' '{print $2}'`

set +e
credhub get -n /concourse/main/aws_default_region > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/aws_default_region exists."
else
  set -e
  credhub set -t value -n /concourse/main/aws_default_region -v ${AWS_DEFAULT_REGION}
fi

set +e
credhub get -n /concourse/main/aws_access_key_id > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/aws_access_key_id exists."
else
  set -e
  credhub set -t value -n /concourse/main/aws_access_key_id -v ${AWS_ACCESS_KEY_ID}
fi

set +e
credhub get -n /concourse/main/aws_secret_access_key > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/aws_secret_access_key exists."
else
  set -e
  credhub set -t value -n /concourse/main/aws_secret_access_key -v ${AWS_SECRET_ACCESS_KEY}
fi

#Docker Credentials
set +e
credhub get -n /concourse/main/docker_username > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/docker_username exists."
else
  set -e
  echo -n "DOCKER_USERNAME: "
  read DOCKER_USERNAME
  credhub set -t value -n /concourse/main/docker_username -v ${DOCKER_USERNAME}
fi

set +e
credhub get -n /concourse/main/docker_password > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/docker_password exists."
else
  set -e
  echo -n "DOCKER_PASSWORD(secret): "
  read -s DOCKER_PASSWORD
  credhub set -t value -n /concourse/main/docker_password -v ${DOCKER_PASSWORD}
fi

set +e
credhub get -n /concourse/main/github_private_key > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Skip: /concourse/main/github_private_key exists."
else
  set -e
  credhub set -t value -n /concourse/main/github_private_key -v "$(cat ~/.ssh/keys/concourse/id_rsa)"
fi
