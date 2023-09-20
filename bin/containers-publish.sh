#!/bin/sh

# Change directory to the project root
cd $(dirname $0)/..

# Build containers first
/bin/sh bin/containers-build.sh

source .env

docker push $DOCKER_REPOSITORY/neurender-ctl
docker push $DOCKER_REPOSITORY/nerfstudio
docker push $DOCKER_REPOSITORY/neurender
