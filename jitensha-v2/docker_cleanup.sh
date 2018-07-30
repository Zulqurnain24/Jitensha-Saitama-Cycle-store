docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f jitensha:v2
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker images
docker ps -a
