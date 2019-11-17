DOCKER_USERNAME=${USER}
DOCKER_IMAGE_NAME='awscli'
#---
#WARNING: Cannot handle multi definition
AWS_DEFAULT_REGION=`cat ~/.aws/credentials | grep "aws_default_region" | awk -F'aws_default_region=' '{print $2}'`
AWS_ACCESS_KEY_ID=`cat ~/.aws/credentials | grep "aws_access_key_id" | awk -F'aws_access_key_id=' '{print $2}'`
AWS_SECRET_ACCESS_KEY=`cat ~/.aws/credentials | grep "aws_secret_access_key" | awk -F'aws_secret_access_key=' '{print $2}'`
