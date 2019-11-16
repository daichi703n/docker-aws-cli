#!/bin/sh
aws --version
# echo "Exit Code: $?"

#EC2 Instance
aws ec2 describe-instances
# echo "Exit Code: $?"
aws ec2 run-instances \
  --region $AWS_DEFAULT_REGION \
  --image-id `aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2' 'Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' --output text` \
  --count 1 \
  --instance-type t2.micro \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=deploy-test}]' \
  > ec2.log
# echo "Exit Code: $?"

aws ec2 terminate-instances \
  --instance-id `cat ec2.log | jq -r .Instances[0].InstanceId`
# echo "Exit Code: $?"

#S3 Objects
aws s3 ls
# echo "Exit Code: $?"

aws s3 mb s3://${DOCKER_USERNAME}-deploy-test-bucket
echo "test-message" > test-object
aws s3 cp test-object s3://${DOCKER_USERNAME}-deploy-test-bucket/
aws s3 cp s3://${DOCKER_USERNAME}-deploy-test-bucket/test-object downloaded-object
cat downloaded-object
aws s3 rb --force s3://${DOCKER_USERNAME}-deploy-test-bucket
