#   germline_depth_filter with data `PINDEL`
# min_depth = 8
# caller = varscan
VCF=/data/call-bcftools_normalize_varscan_indel/execution/output.normalized.vcf.gz

OUT="/results/germline_depth_filter.VARINDEL.vcf"

ARGS="-m 8 -c varscan"

cd ../..
CMD="bash src/run_germline_depth_filter.sh $@ $ARGS -o $OUT $VCF"
# -h: Print this help message
# -d: Dry run - output commands but do not execute them
# -o OUT_VCF: Output VCF.  Default writes to STDOUT
# -e: filter debug mode
# -E: filter bypass
# -R: remove filtered variants.  Default is to retain filtered variants with filter name in VCF FILTER field
# -m min_depth: Retain sites where read depth > min_depth
# -c caller: specifies tool used for variant call. 'GATK', 'varscan', 'pindel'

>&2 echo Running: $CMD
eval $CMD

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal ERROR $rc: $!.  Exiting.
    exit $rc;
fi

>&2 echo Success.  Written to $OUT
