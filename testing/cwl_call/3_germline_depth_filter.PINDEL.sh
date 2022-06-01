

source /opt/ibm/lsfsuite/lsf/conf/lsf.conf

PWD=$(pwd)
CWL_ROOT_H=$PWD/../..
CWL="$CWL_ROOT_H/cwl/germline_depth_filter.cwl"

CONFIG="cromwell-config/cromwell-config-db.compute1-filedb.dat"
YAML="yaml/C3L-00017.PINDEL.germline_depth_filter.yaml"

# Cromwell v78 
JAVA="/opt/java/openjdk/bin/java"
CROMWELL="/app/cromwell-78-38cd360.jar"

# from https://confluence.ris.wustl.edu/pages/viewpage.action?spaceKey=CI&title=Cromwell#Cromwell-ConnectingtotheDatabase
# Connecting to the database section
# Note also database section in config file
CMD="$JAVA -Dconfig.file=$CONFIG -jar $CROMWELL run -t cwl -i $YAML $CWL"

echo Running: $CMD
eval $CMD

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
fi



# [ Wed Jun 1 20:17:30 UTC 2022 ] Running: zcat /cromwell-executions/germline_depth_filter.cwl/2f576cd7-56c2-414d-bc6b-affdfdf74000/call-germline_depth_filter.cwl/inputs/-1670431735/output.normalized.vcf.gz | /usr/local/bin/vcf_filter.py --local-script germline_depth_filter.py - read_depth --min_depth 8 > germline_depth_filter.output.vcf
# Exception: Error: Argument caller not defined

