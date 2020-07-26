OUTD="/results"
mkdir -p $OUTD

INPUT="$OUTD/merged.vcf"

OUT="$OUTD/merged-filtered.vcf"

CMD="bash ../../src/filter_vcf.sh $@ -o $OUT $EXCLUDE $INPUT"

>&2 echo Running $CMD
eval $CMD

