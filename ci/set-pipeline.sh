DOCKER_IMAGE_NAME=awscli
fly -t main sp -p docker-${DOCKER_IMAGE_NAME} \
    -c `dirname $0`/pipeline.yml \
    -v "docker_image_name=${DOCKER_IMAGE_NAME}"
