#!/bin/bash

cd $(dirname $0)/../

docker-compose --env-file .env -f containers/neurender-ctl/docker-compose.yml up