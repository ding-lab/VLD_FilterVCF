OUTD="/results"
mkdir -p $OUTD

INPUT="/data/inputs/-246599121/varscan-remapped.vcf"

OUT="$OUTD/length-filtered.vcf"

#-m min_length: Retain sites where indel length > given value
#-x max_length: Retain sites where indel length <= given value. 0 disables test

# max_length = 100
# min_length = 0 

ARGS="-m 0 -x 100 "

CMD="bash ../../src/run_length_filter.sh $@ $ARGS -o $OUT $EXCLUDE $INPUT"

>&2 echo Running $CMD
eval $CMD

