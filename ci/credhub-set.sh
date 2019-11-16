set -eu pipefail

#AWS Credentials
#WARNING: Cannot handle multi definition
AWS_DEFAULT_REGION=`cat ~/.aws/credentials | grep "aws_default_region" | awk -F'aws_default_region=' '{print $2}'`
AWS_ACCESS_KEY_ID=`cat ~/.aws/credentials | grep "aws_access_key_id" | awk -F'aws_access_key_id=' '{print $2}'`
AWS_SECRET_ACCESS_KEY=`cat ~/.aws/credentials | grep "aws_secret_access_key" | awk -F'aws_secret_access_key=' '{print $2}'`

credhub set -t value -n /concourse/main/aws_default_region -v ${AWS_DEFAULT_REGION}
credhub set -t value -n /concourse/main/aws_access_key_id -v ${AWS_ACCESS_KEY_ID}
credhub set -t value -n /concourse/main/aws_secret_access_key -v ${AWS_SECRET_ACCESS_KEY}

#Docker Credentials
echo -n DOCKER_USERNAME:
read DOCKER_USERNAME
echo -n DOCKER_PASSWORD:
read DOCKER_PASSWORD

credhub set -t value -n /concourse/main/docker_username -v ${DOCKER_USERNAME}
credhub set -t value -n /concourse/main/docker_password -v ${DOCKER_PASSWORD}
