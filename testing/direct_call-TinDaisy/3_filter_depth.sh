OUTD="/results"
mkdir -p $OUTD

INPUT="/data/inputs/-246599121/varscan-remapped.vcf"

OUT="$OUTD/length-filtered.vcf"

#min_depth_tumor = 14
#min_depth_normal = 8
#tumor_name = TUMOR
#normal_name = NORMAL
#caller = varscan

ARGS="-m 0 -x 100 "

CMD="bash ../../src/run_depth_filter.sh $@ $ARGS -o $OUT $EXCLUDE $INPUT"

>&2 echo Running $CMD
eval $CMD

