source ../../docker/docker_image.sh

#DATAD="/home/mwyczalk_test/Projects/TinDaisy/VEP_Filter"

# this should be read-only.  Maps to /data
DATAD_H="/home/mwyczalk_test/Projects/TinDaisy/testing/C3L-00908-data/dat/call-hotspot_vld_varscan_snv/hotspot_vld.cwl/27ac9be3-7575-4477-8f85-5d3652992ee9/call-vaf_length_depth_filters_B"

INPUT_C="/data/inputs/-246599121/varscan-remapped.vcf"


# ./docker-results will map to /results
OUTD_H="./results"
mkdir -p $OUTD_H
OUT="/results/varscan.somatic_vaf-filtered.vcf"  # OUT should be container path

# -m min_vaf_tumor: Retain sites where tumor VAF > than given value (aka min_vaf_somatic)
# -x max_vaf_normal: Retain sites where normal VAF <= than given value (aka max_vaf_germline)
# -c caller: specifies tool used for variant call. 'strelka', 'varscan', 'mutect', 'pindel', 'merged'
# -T tumor_name: Tumor sample name in VCF
# -N normal_name: Normal sample name in VCF

ARGS="-m 0.05 -x 0.02 -c varscan -T TUMOR -N NORMAL"

# This is what we want to run in docker
CMD_INNER="/bin/bash /opt/VLD_FilterVCF/src/run_somatic_vaf_filter.sh $@ $ARGS -o $OUT $INPUT_C"

#
# Launch stuff, keep as is
#
SYSTEM=docker   # docker MGI or compute1
START_DOCKERD="../../docker/WUDocker"  # https://github.com/ding-lab/WUDocker.git

VOLUME_MAPPING="$DATAD_H:/data $OUTD_H:/results"

>&2 echo Launching $IMAGE on $SYSTEM
CMD_OUTER="bash $START_DOCKERD/start_docker.sh -I $IMAGE -M $SYSTEM -c \"$CMD_INNER\" $VOLUME_MAPPING "
echo Running: $CMD_OUTER
eval $CMD_OUTER

>&2 echo Written to $OUT in $OUTD_H
