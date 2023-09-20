#!/bin/sh

SCRIPT_DIR=$(dirname $0)
REPOSITORY=airstudio

docker-compose -f $SCRIPT_DIR/../containers/nerfstudio//docker-compose.yml build
docker-compose -f $SCRIPT_DIR/../containers/neurender/docker-compose.yml build

docker push $REPOSITORY/nerfstudio
docker push $REPOSITORY/neurender
