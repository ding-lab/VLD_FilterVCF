# Input data to be found here
DATAD="/storage1/fs1/m.wyczalkowski/Active/cromwell-data/cromwell-workdir/cromwell-executions/TinJasmine.cwl/020f0455-9d82-4da7-aee3-00408f91a822"
OUTD="/cache1/fs1/home1/Active/home/m.wyczalkowski/Projects/CWL-dev/VLD_FilterVCF/TinJasmine-dev/results"
mkdir -p $OUTD
SYSTEM=compute1

# changing directories so entire project directory is mapped by default
cd ../..

source docker/docker_image.sh

bash docker/WUDocker/start_docker.sh $@ -M $SYSTEM -I $IMAGE $DATAD:/data $OUTD:/results


