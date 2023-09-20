
# Change directory to the project root
cd $(dirname $0)/..

echo "Building neurender-ctl"
docker-compose --env-file .env -f containers/neurender-ctl/docker-compose.yml build

echo "Building nerfstudio"
docker-compose --env-file .env -f containers/nerfstudio/docker-compose.yml build

echo "Building neurender"
docker-compose --env-file .env -f containers/neurender/docker-compose.yml build