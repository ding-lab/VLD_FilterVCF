# start docker image with ../demo_data mapped to /data,
# unless another path is passed on command line.  uses
# the start_docker.sh script in /docker

if [ -z $1 ]; then
    DATD="../demo_data"
else
    DATD=$1
fi

source ../../docker/docker_image.sh

cd ../.. && bash src/start_docker.sh $@ -I $IMAGE $DATD:data


